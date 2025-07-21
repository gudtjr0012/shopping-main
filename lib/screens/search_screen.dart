import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final VoidCallback? onBack; // ★ onBack 콜백!

  const SearchScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 검색 박스
          Container(
            margin: const EdgeInsets.only(top: 30),

            /// 상단 여백 공간 수정
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
                  onPressed: onBack, // ★ 콜백으로 이전탭 이동!
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
          const Expanded(
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
