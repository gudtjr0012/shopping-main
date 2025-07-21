import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onBack; // ★ 추가!

  const CartScreen({super.key, this.onBack});

  // 재사용 가능한 장바구니 상품 아이템 위젯
  Widget _cartItem() {
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
          ),
          const SizedBox(width: 16),
          // 상품명, 가격, 수량 조절
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                const Text(
                  '제품명',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 3),
                const Text(
                  '가격',
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _qtyButton(icon: Icons.remove, onPressed: () {}),
                    const SizedBox(width: 8),
                    const Text(
                      '01',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _qtyButton(icon: Icons.add, onPressed: () {}),

                    /// 수량 조절 버튼 위치 바꿈
                  ],
                ),
              ],
            ),
          ),
          // 삭제 버튼
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black45),
            onPressed: () {},
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // 수량 버튼 위젯 (재사용)
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
          onPressed: onBack, // ★ 이전탭 돌아가기 콜백!
        ),
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
      ),
      // 장바구니 리스트 & 총합계
      body: Column(
        children: [
          // 상품 리스트
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [_cartItem(), _cartItem(), _cartItem()],
            ),
          ),
          // 총 합계 & 주문하기 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: const [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Spacer(),
                Text(
                  '00.000원',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
