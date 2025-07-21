import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/my_screen.dart';
import 'screens/search_screen.dart';
import 'screens/product_list_page.dart';

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

  // 전역 장바구니 리스트
  List<Map<String, dynamic>> cartItems = [];

  // 주문내역 리스트
  List<Map<String, dynamic>> orderHistory = [];

  // 장바구니에 상품 추가 함수
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      // 동일 상품(옵션까지 동일) 있으면 수량만 증가
      final idx = cartItems.indexWhere((e) =>
        e['productName'] == item['productName'] &&
        e['color'] == item['color'] &&
        e['size'] == item['size'] &&
        e['price'] == item['price']
      );
      if (idx != -1) {
        cartItems[idx]['qty'] = (cartItems[idx]['qty'] ?? 1) + 1;
      } else {
        cartItems.add({...item, 'qty': 1});
      }
    });
  }

  // 장바구니에서 상품 삭제 함수 (index 기준)
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // 수량 증가
  void incQty(int index) {
    setState(() {
      cartItems[index]['qty'] = (cartItems[index]['qty'] ?? 1) + 1;
    });
  }

  // 수량 감소 (1 미만이면 삭제)
  void decQty(int index) {
    setState(() {
      if ((cartItems[index]['qty'] ?? 1) > 1) {
        cartItems[index]['qty']--;
      }
      // 1일 때는 아무 동작도 하지 않음
    });
  }

  // 총합계 계산
  int getTotalPrice() {
    int total = 0;
    for (final item in cartItems) {
      final price = (item['price'] as num).toInt();
      final qty = ((item['qty'] ?? 1) as num).toInt();
      total += price * qty;
    }
    return total;
  }

  // 주문하기: 장바구니 상품을 주문내역으로 옮기고 장바구니 비우기
  void orderAll() {
    setState(() {
      if (cartItems.isNotEmpty) {
        orderHistory.addAll(cartItems.map((e) => {...e}));
        cartItems.clear();
      }
    });
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
        onCartTap: () => setState(() { _currentIndex = 2; _selectedCategory = null; }),
      );
    }

    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onCategoryTap: (category) =>
              setState(() => _selectedCategory = category),
          onSearchTap: () => setState(() => _currentIndex = 4), // 돋보기 클릭 시!
        );
      case 1:
        return const FeedScreen();
      case 2:
        return CartScreen(
          cartItems: cartItems,
          removeFromCart: removeFromCart,
          incQty: incQty,
          decQty: decQty,
          getTotalPrice: getTotalPrice,
          orderAll: orderAll,
          orderHistory: orderHistory,
        );
      case 3:
        return const MyScreen();
      case 4:
        return const SearchScreen(); // 검색화면
      default:
        return const Center(child: Text("NOT FOUND"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex > 3 ? 0 : _currentIndex, // 4일 때도 홈 선택된 것처럼
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
        onTap: (index) => setState(() {
          _currentIndex = index;
          _selectedCategory = null;
        }),
      ),
    );
  }
}
