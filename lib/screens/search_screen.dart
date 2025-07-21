import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const SearchScreen({super.key, this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 검색 바
          Container(
            margin: const EdgeInsets.only(top: 30),
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
                  onPressed: widget.onBack,
                  splashRadius: 22,
                ),
                // TextField (검색 입력)
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: '상품명 또는 브랜드명을 입력하세요',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                    ),
                    style: const TextStyle(fontSize: 17),
                    onChanged: (val) {
                      setState(() => searchText = val);
                    },
                    onSubmitted: (val) {
                      // 엔터 시 검색 로직
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black, size: 26),
                  onPressed: () {
                    // 돋보기 클릭 시 검색 로직 (예시: print)
                    FocusScope.of(context).unfocus();
                    print("검색어: ${_searchController.text}");
                    // 검색결과 리스트 등을 추가로 구현 가능
                  },
                  splashRadius: 22,
                ),
              ],
            ),
          ),
          // 본문 안내
          Expanded(
            child: Center(
              child: Text(
                searchText.isEmpty
                    ? '검색결과가 없습니다.'
                    : "'$searchText'에 대한 검색결과가 없습니다.",
                style: const TextStyle(fontSize: 17, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
