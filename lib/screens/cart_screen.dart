import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
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
    this.onBack,
    required this.cartItems,
    required this.removeFromCart,
    required this.incQty,
    required this.decQty,
    required this.getTotalPrice,
    required this.orderAll,
    required this.orderHistory,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _removeFromCart(int index) {
    widget.removeFromCart(index);
    setState(() {});
  }

  void _incQty(int index) {
    widget.incQty(index);
    setState(() {});
  }

  void _decQty(int index) {
    widget.decQty(index);
    setState(() {});
  }

  void showOrderHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('주문내역'),
        content: widget.orderHistory.isEmpty
            ? const Text('주문내역이 없습니다.')
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.orderHistory.length,
                  itemBuilder: (context, idx) {
                    final item = widget.orderHistory[idx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['productName'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('컬러: ${item['color']}, 사이즈: ${item['size']}'),
                          Text('수량: ${item['qty'] ?? 1}'),
                          Text(
                            '가격: ${(item['price'] as int).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                          ),
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

  Widget _cartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
          // 상품정보(간격 추가)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 상품명
                Text(
                  item['productName'] ?? '제품명',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // 상품명-컬러 간격
                /// 컬러/사이즈
                Text(
                  '컬러: ${item['color']}, 사이즈: ${item['size']}',
                  style: const TextStyle(fontSize: 13, color: Colors.black45),
                ),
                const SizedBox(height: 10), // 컬러/가격 간격
                /// 가격
                Text(
                  '가격: ${(item['price'] as int).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 14), // 가격-수량조절 간격(조금 더 넓게)
                /// 수량조절
                Row(
                  children: [
                    _qtyButton(
                      icon: Icons.remove,
                      onPressed: () => _decQty(index),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (item['qty'] ?? 1).toString().padLeft(2, '0'),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    _qtyButton(
                      icon: Icons.add,
                      onPressed: () => _incQty(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black45),
            onPressed: () => _removeFromCart(index),
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      '장바구니가 비어있습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, idx) =>
                        _cartItem(widget.cartItems[idx], idx),
                  ),
          ),
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
                  '${widget.getTotalPrice().toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}원',
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
                    onPressed: () => showOrderHistory(context),
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
                      if (widget.cartItems.isEmpty) {
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
                        widget.orderAll();
                        setState(() {});
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
