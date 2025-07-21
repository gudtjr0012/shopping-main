import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/my_screen.dart';
import 'screens/search_screen.dart';
import 'screens/product_list_page.dart';
import 'screens/product_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainTabNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabNavigator extends StatefulWidget {
  const MainTabNavigator({super.key});
  @override
  State<MainTabNavigator> createState() => _MainTabNavigatorState();
}

class _MainTabNavigatorState extends State<MainTabNavigator> {
  int _currentIndex = 0;
  String? _selectedCategory;
  final List<int> _tabHistory = [0];

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> orderHistory = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      final idx = cartItems.indexWhere(
        (e) =>
            e['productName'] == item['productName'] &&
            e['color'] == item['color'] &&
            e['size'] == item['size'] &&
            e['price'] == item['price'],
      );
      if (idx != -1) {
        cartItems[idx]['qty'] = (cartItems[idx]['qty'] ?? 1) + 1;
      } else {
        cartItems.add({...item, 'qty': 1});
      }
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void incQty(int index) {
    setState(() {
      cartItems[index]['qty'] = (cartItems[index]['qty'] ?? 1) + 1;
    });
  }

  void decQty(int index) {
    setState(() {
      if ((cartItems[index]['qty'] ?? 1) > 1) {
        cartItems[index]['qty']--;
      }
    });
  }

  int getTotalPrice() {
    int total = 0;
    for (final item in cartItems) {
      final price = (item['price'] as num).toInt();
      final qty = ((item['qty'] ?? 1) as num).toInt();
      total += price * qty;
    }
    return total;
  }

  void orderAll() {
    setState(() {
      if (cartItems.isNotEmpty) {
        orderHistory.addAll(cartItems.map((e) => {...e}));
        cartItems.clear();
      }
    });
  }

  // 🚩 장바구니 push (항상 최신 cartItems/콜백 사용!)
  void openCartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          cartItems: cartItems,
          removeFromCart: removeFromCart,
          incQty: incQty,
          decQty: decQty,
          getTotalPrice: getTotalPrice,
          orderAll: orderAll,
          orderHistory: orderHistory,
          onBack: () {
            Navigator.of(context).pop();
            setState(() {}); // 돌아왔을 때 리렌더!
          },
        ),
      ),
    ).then((_) => setState(() {}));
  }

  void _onTabSelected(int index) {
    if (index != _currentIndex) {
      setState(() {
        _tabHistory.add(index);
        _currentIndex = index;
        _selectedCategory = null;
      });
    }
  }

  void _onBackPressed() {
    if (_tabHistory.length > 1) {
      setState(() {
        _tabHistory.removeLast();
        _currentIndex = _tabHistory.last;
        _selectedCategory = null;
      });
    }
  }

  Widget _getBody() {
    if (_selectedCategory != null) {
      return ProductListPage(
        initialFit: _selectedCategory!,
        onBack: () => setState(() => _selectedCategory = null),
        addToCart: addToCart,
        cartItems: cartItems,
        removeFromCart: removeFromCart,
        incQty: incQty,
        decQty: decQty,
        getTotalPrice: getTotalPrice,
        orderAll: orderAll,
        orderHistory: orderHistory,
        openCartScreen: openCartScreen, // 🟢 장바구니 열기
      );
    }

    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onCategoryTap: (category) =>
              setState(() => _selectedCategory = category),
          onSearchTap: () => _onTabSelected(4),
        );
      case 1:
        return FeedScreen(onBack: _onBackPressed);
      case 2:
        return CartScreen(
          onBack: _onBackPressed,
          cartItems: cartItems,
          removeFromCart: removeFromCart,
          incQty: incQty,
          decQty: decQty,
          getTotalPrice: getTotalPrice,
          orderAll: orderAll,
          orderHistory: orderHistory,
        );
      case 3:
        return MyScreen(onBack: _onBackPressed);
      case 4:
        return SearchScreen(onBack: _onBackPressed);
      default:
        return const Center(child: Text("NOT FOUND"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex > 3 ? 0 : _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '피드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '장바구니',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'MY',
          ),
        ],
        onTap: _onTabSelected,
      ),
    );
  }
}
