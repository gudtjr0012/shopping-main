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
  final List<int> _tabHistory = [0]; // 탭 이동 내역

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
      );
    }

    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onCategoryTap: (category) =>
              setState(() => _selectedCategory = category),
          onSearchTap: () => _onTabSelected(4), // 돋보기 클릭 시!
        );
      case 1:
        return FeedScreen(onBack: _onBackPressed);
      case 2:
        return CartScreen(onBack: _onBackPressed);
      case 3:
        return MyScreen(onBack: _onBackPressed);
      case 4:
        return SearchScreen(onBack: _onBackPressed); // 검색화면도 뒤로가기 콜백
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
