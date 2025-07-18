import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shopping/screens/product_detail_screen.dart';

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
                  height: 150, // 엑박 방지용 높이 수정!
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
