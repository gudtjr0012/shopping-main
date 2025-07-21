import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/cart_screen.dart'; // Added import for CartScreen

// ★★★ 상품리스트 페이지 ★★★
class ProductListPage extends StatefulWidget {
  final String initialFit;
  final VoidCallback? onBack;
  final void Function(Map<String, dynamic>) addToCart;
  final List<Map<String, dynamic>> cartItems;
  final void Function(int) removeFromCart;
  final void Function(int) incQty;
  final void Function(int) decQty;
  final int Function() getTotalPrice;
  final void Function() orderAll;
  final List<Map<String, dynamic>> orderHistory;
  final VoidCallback onCartTap;

  // *** 병합 후 모든 필수 파라미터 포함 ***
  const ProductListPage({
    Key? key,
    required this.initialFit,
    this.onBack,
    required this.addToCart,
    required this.cartItems,
    required this.removeFromCart,
    required this.incQty,
    required this.decQty,
    required this.getTotalPrice,
    required this.orderAll,
    required this.orderHistory,
    required this.onCartTap,
  }) : super(key: key);

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
                  int price = (idx + 1) * 10000;
                  // 카테고리(핏)별 이미지 리스트 매핑
                  Map<String, List<String>> fitImageMap = {
                    '오버핏': List.generate(
                      5,
                      (i) => 'assets/images/fit${i + 1}.jpg',
                    ),
                    '슬림핏': List.generate(
                      5,
                      (i) => 'assets/images/fit${i + 1}.jpg',
                    ),
                    '레귤러핏': List.generate(
                      5,
                      (i) => 'assets/images/fit${i + 1}.jpg',
                    ),
                    '컴포트핏': List.generate(
                      5,
                      (i) => 'assets/images/fit${i + 1}.jpg',
                    ),
                    '머슬핏': List.generate(
                      5,
                      (i) => 'assets/images/fit${i + 1}.jpg',
                    ),
                  };
                  List<String> imageList =
                      fitImageMap[fitTypes[selectedFitIndex]] ?? [];
                  String imagePath = imageList.isNotEmpty
                      ? imageList[idx % imageList.length]
                      : 'assets/images/logo.png';
                  return ProductCard(
                    productName: productName,
                    price: price,
                    imagePath: imagePath,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productName: productName,
                            price: price,
                            imagePath: imagePath,
                            addToCart: widget.addToCart,
                            cartItems: widget.cartItems,
                            removeFromCart: widget.removeFromCart,
                            incQty: widget.incQty,
                            decQty: widget.decQty,
                            getTotalPrice: widget.getTotalPrice,
                            orderAll: widget.orderAll,
                            orderHistory: widget.orderHistory,
                            onCartTap: widget.onCartTap,
                          ),
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
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              widget.onCartTap();
            },
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
          if (widget.cartItems.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  widget.cartItems
                      .fold<int>(
                        0,
                        (sum, item) =>
                            sum + ((item['qty'] ?? 1) as num).toInt(),
                      )
                      .toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
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
  final int price;
  final String imagePath;

  ProductCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.imagePath,
    this.onTap,
  }) : rating = double.parse(
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
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 3),
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444444),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(${widget.reviewCount})',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444444),
                          fontWeight: FontWeight.w500,
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