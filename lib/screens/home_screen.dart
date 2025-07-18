import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final void Function(String)? onCategoryTap;
  final VoidCallback? onSearchTap; // ← 꼭 추가

  const HomeScreen({super.key, this.onCategoryTap, this.onSearchTap});

  Widget _buildCategoryBox(String title, String imageAsset) {
    return GestureDetector(
      onTap: () {
        if (onCategoryTap != null) onCategoryTap!(title);
      },
      child: Column(
        children: [
          Container(
            width: 110,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12, width: 1),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(imageAsset, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Image.asset('assets/images/logo.png', height: 50),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 32),
              onPressed: onSearchTap, // 여기에만 씁니다!
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 330,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/banner1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'CATEGORY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryBox('슬림핏', 'assets/images/fit1.jpg'),
                  _buildCategoryBox('오버핏', 'assets/images/fit2.jpg'),
                  _buildCategoryBox('레귤러핏', 'assets/images/fit3.jpg'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryBox('컴포트핏', 'assets/images/fit4.jpg'),
                  _buildCategoryBox('머슬핏', 'assets/images/fit5.jpg'),
                  GestureDetector(
                    onTap: () {
                      if (onCategoryTap != null) onCategoryTap!('전체');
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'ALL',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '전체',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
