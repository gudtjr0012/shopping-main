import 'package:flutter/material.dart';
import 'package:shopping/screens/cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final int price;
  final String imagePath;
  final Function(Map<String, dynamic>) addToCart;
  final List<Map<String, dynamic>> cartItems;
  final void Function(int) removeFromCart;
  final void Function(int) incQty;
  final void Function(int) decQty;
  final int Function() getTotalPrice;
  final void Function() orderAll;
  final List<Map<String, dynamic>> orderHistory;
  final VoidCallback onCartTap;
  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.addToCart,
    required this.cartItems,
    required this.removeFromCart,
    required this.incQty,
    required this.decQty,
    required this.getTotalPrice,
    required this.orderAll,
    required this.orderHistory,
    required this.onCartTap,
  });
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = "M";
  Color selectedColor = Colors.black;
  String printingText = '';
  final TextEditingController printingController = TextEditingController();

  String get selectedColorName {
    if (selectedColor == Colors.black) return "블랙";
    if (selectedColor == Colors.red) return "레드";
    if (selectedColor == Colors.blue) return "블루";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // ← 여기!
        ),
        centerTitle: true,
        title: Text(
          widget.productName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 이미지
            Container(
              width: double.infinity,
              height: 400,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26, width: 1),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
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
                  Text(
                    widget.productName,
                    style: const TextStyle(
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
                      Text(
                        '${widget.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        '00.000원',
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
                  const SizedBox(height: 18),
                  Text(
                    '프린팅 추가',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: printingController,
                    onChanged: (val) => setState(() => printingText = val),
                    decoration: InputDecoration(
                      hintText: '원하는 문구 입력하세요 (최대 20자)',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    maxLength: 20,
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
                        Text(
                          '• 프리미엄 코튼 100% 소재로 부드럽고 쾌적한 착용감',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '• 여유로운 실루엣의 트렌디한 오버핏 디자인',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '• 내구성 높은 이중 스티치 마감',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '• 데일리룩, 캐주얼룩 모두 활용 가능한 베이직 아이템',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '• 모델 착용 사이즈: L / 키 183cm, 70kg',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
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
                  // 장바구니에 상품 추가
                  widget.addToCart({
                    'productName': widget.productName,
                    'color': selectedColorName,
                    'size': selectedSize,
                    'price': widget.price,
                    'imagePath': widget.imagePath,
                    'printingText': printingText,
                  });
                  setState(() {}); // FAB 뱃지 즉시 반영
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('장바구니에 담았습니다!'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
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
                  // 구매하기 버튼: 주문 완료 팝업만 띄움
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('주문 완료'),
                      content: const Text('주문이 완료되었습니다!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
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
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pop(context);
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
