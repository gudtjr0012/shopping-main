import 'package:flutter/material.dart';
import 'dart:math';

// ★★★ 내가 만든 상품 상세페이지 (파라미터 없음) ★★★
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = "M";
  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          '상품명',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지
            Container(
              width: double.infinity,
              height: 260,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26, width: 1),
              ),
              alignment: Alignment.center,
              child: const Text(
                '제품사진',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Text(
                    '브랜드명',
                    style: TextStyle(color: Colors.black38, fontSize: 13),
                  ),
                  const Text(
                    '제품명',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // 별점/리뷰
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.star, color: Colors.white, size: 16),
                            SizedBox(width: 2),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '87 Reviews',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 가격/할인
                  Row(
                    children: [
                      const Text(
                        '00.000원',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        '10.000원',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '0% OFF',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 컬러 선택
                  const Text(
                    '컬러',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [Colors.black, Colors.red, Colors.blue].map((
                      color,
                    ) {
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.black26,
                              width: isSelected ? 3 : 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 22,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),

                  // 사이즈 선택
                  const Text(
                    '사이즈',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['S', 'M', 'L', 'XL'].map((size) {
                      final isSelected = selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => selectedSize = size),
                        child: Container(
                          margin: const EdgeInsets.only(right: 14),
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black : Colors.white,
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.black26,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),
                  // 제품 상세 설명
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '제품 상세',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('• □□□ - □□□', style: TextStyle(fontSize: 14)),
                        Text('• □□□ - □□□', style: TextStyle(fontSize: 14)),
                        Text('• □□□ - □□□', style: TextStyle(fontSize: 14)),
                        Text('• □□□ - □□□', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            // body 끝
          ],
        ),
      ),
      // 하단 버튼 2개
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black87, width: 2),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // print('선택 컬러: $selectedColor, 사이즈: $selectedSize');
                },
                child: const Text(
                  '장바구니',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // print('선택 컬러: $selectedColor, 사이즈: $selectedSize');
                },
                child: const Text(
                  '구매하기',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ★★★ 상품리스트 페이지 ★★★
class ProductListPage extends StatefulWidget {
  final String initialFit;
  final VoidCallback? onBack;

  const ProductListPage({Key? key, required this.initialFit, this.onBack})
    : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> fitTypes = ['오버핏', '슬림핏', '레귤러핏', '컴포트핏', '머슬핏'];
  final List<String> fitTypesEng = [
    'Over fit',
    'Slim fit',
    'Regular fit',
    'Comfort fit',
    'Muscle fit',
  ];
  int selectedFitIndex = 0;

  @override
  void initState() {
    super.initState();
    final idx = fitTypes.indexOf(widget.initialFit);
    if (idx != -1) {
      selectedFitIndex = idx;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          '${fitTypesEng[selectedFitIndex]}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(fitTypes.length, (idx) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFitIndex = idx;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.checkroom,
                        size: 40,
                        color: idx == selectedFitIndex
                            ? Colors.black
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fitTypes[idx],
                        style: TextStyle(
                          fontWeight: idx == selectedFitIndex
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: idx == selectedFitIndex
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, idx) {
                  // 상품 이름(예시) 생성
                  String productName =
                      '${fitTypes[selectedFitIndex]} 상품 ${idx + 1}';
                  return ProductCard(
                    productName: productName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProductDetailScreen(), // <<-- 여기!
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 상품카드
class ProductCard extends StatefulWidget {
  final double rating;
  final int reviewCount;
  final VoidCallback? onTap;
  final String productName;

  ProductCard({Key? key, required this.productName, this.onTap})
    : rating = double.parse(
        ((Random().nextDouble() * 1.0) + 4.0).toStringAsFixed(1),
      ),
      reviewCount = Random().nextInt(191) + 10,
      super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // 카드 전체 클릭 이벤트!
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지 + 찜 버튼
            Stack(
              children: [
                Container(
                  height: 165,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  width: double.infinity,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // 상품 정보
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('가격'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ' (${widget.reviewCount} reviews)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
