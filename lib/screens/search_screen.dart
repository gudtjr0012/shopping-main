import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 검색 박스 (앱바 아님! 직접 만듦)
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 26,
                  ),
                  onPressed: () {},
                  splashRadius: 22,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black, size: 26),
                  onPressed: () {},
                  splashRadius: 22,
                ),
              ],
            ),
          ),
          // 본문 (중앙 안내문구)
          Expanded(
            child: Center(
              child: Text(
                '브랜드, 상품명을 검색해보세요',
                style: TextStyle(fontSize: 17, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
