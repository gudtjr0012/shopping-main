import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  final VoidCallback? onBack; // ★ onBack 콜백 추가

  const FeedScreen({super.key, this.onBack});

  // 블록 위젯 재사용
  Widget _block({double w = 140, double h = 140, String? assetPath}) =>
      Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(32),
        ),
        clipBehavior: Clip.hardEdge,
        child: assetPath != null
            ? Image.asset(assetPath, fit: BoxFit.cover)
            : null,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 상단바
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: onBack, // ★ 이전탭 돌아가기 콜백!
        ),
        centerTitle: true,
        title: const Text('Feed', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              children: [
                // 첫 번째: 큰 박스 (2열 합침)
                _block(w: 400, h: 150, assetPath: 'assets/images/feed8.jpg'),
                const SizedBox(height: 10),
                // 아래는 2열 불규칙 그리드
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 왼쪽 열
                    Column(
                      children: [
                        _block(
                          w: 190,
                          h: 150,
                          assetPath: 'assets/images/feed1.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 150,
                          assetPath: 'assets/images/feed2.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 100,
                          assetPath: 'assets/images/feed5.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 110,
                          assetPath: 'assets/images/feed4.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 250,
                          assetPath: 'assets/images/feed9.jpg',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(width: 10),
                    // 오른쪽 열
                    Column(
                      children: [
                        _block(
                          w: 190,
                          h: 210,
                          assetPath: 'assets/images/feed3.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 150,
                          assetPath: 'assets/images/feed6.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 190,
                          assetPath: 'assets/images/feed7.jpg',
                        ),
                        const SizedBox(height: 10),
                        _block(
                          w: 190,
                          h: 210,
                          assetPath: 'assets/images/feed10.jpg',

                          /// 이미지 추가, 수정
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
