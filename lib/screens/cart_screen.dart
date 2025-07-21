import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  // === 모든 props 받아오기 (협업자+경현님) ===
  final VoidCallback? onBack;
  final List<Map<String, dynamic>> cartItems;
  final void Function(int) removeFromCart;
  final void Function(int) incQty;
  final void Function(int) decQty;
  final int Function() getTotalPrice;
  final void Function() orderAll;
  final List<Map<String, dynamic>> orderHistory;

  const CartScreen({
    Key? key,
    this.onBack, // onBack은 null 가능(호환 위해)
    required this.cartItems,
    required this.removeFromCart,
    required this.incQty,
    required this.decQty,
    required this.getTotalPrice,
    required this.orderAll,
    required this.orderHistory,
  }) : super(key: key);

  // ===== 재사용 가능한 장바구니 상품 아이템 위젯 =====
  Widget _cartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상품 이미지
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.hardEdge,
            child: item['imagePath'] != null
                ? Image.asset(item['imagePath'], fit: BoxFit.cover)
                : null,
          ),
          const SizedBox(width: 16),
          // 상품명, 가격, 옵션, 수량 조절
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  item['productName'] ?? '제품명',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 3),
                Text(
                  '컬러: ${item['color']}, 사이즈: ${item['size']}',
                  style: const TextStyle(fontSize: 13, color: Colors.black45),
                ),
                const SizedBox(height: 3),
                Text(
                  '가격: ${(item['price'] as int).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                  style: const TextStyle(fontSize: 13, color: Colors.black),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    // 수량 감소 버튼 (0보다 작아지지 않게)
                    _qtyButton(
                      icon: Icons.remove,
                      onPressed: () => decQty(index),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      (item['qty'] ?? 1).toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 수량 증가 버튼
                    _qtyButton(
                      icon: Icons.add,
                      onPressed: () => incQty(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 삭제 버튼
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black45),
            onPressed: () => removeFromCart(index),
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // ===== 수량 버튼 위젯 (재사용) =====
  static Widget _qtyButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black54, size: 18),
        onPressed: onPressed,
        splashRadius: 20,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  // ===== 주문내역 팝업 위젯 =====
  void showOrderHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('주문내역'),
        content: orderHistory.isEmpty
            ? const Text('주문내역이 없습니다.')
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderHistory.length,
                  itemBuilder: (context, idx) {
                    final item = orderHistory[idx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['productName'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('컬러: ${item['color']}, 사이즈: ${item['size']}'),
                          Text('수량: ${item['qty'] ?? 1}'),
                          Text('가격: ${(item['price'] as int).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원'),
                        ],
                      ),
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 상단 바
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: onBack, // onBack이 null이어도 안전하게 동작
        ),
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
      ),
      // 장바구니 리스트 & 총합계
      body: Column(
        children: [
          // 상품 리스트
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      '장바구니가 비어있습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, idx) => _cartItem(cartItems[idx], idx),
                  ),
          ),
          // 총 합계 & 주문하기 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const Spacer(),
                Text(
                  '${getTotalPrice().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black87, width: 2),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showOrderHistory(context);
                    },
                    child: const Text(
                      '주문내역',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      if (cartItems.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('알림'),
                            content: const Text('상품을 장바구니에 담아주세요!'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('확인'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        orderAll();
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
                      }
                    },
                    child: const Text(
                      '주문하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}