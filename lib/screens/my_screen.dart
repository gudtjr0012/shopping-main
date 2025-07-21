import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  final VoidCallback? onBack; // ★ 추가!

  const MyScreen({super.key, this.onBack});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController topSizeController = TextEditingController();
  final TextEditingController bottomSizeController = TextEditingController();

  bool? isMale;
  int? selectedBodyType;

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    topSizeController.dispose();
    bottomSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.black38, width: 1),
    );
    Widget spacing({double h = 16}) => SizedBox(height: h);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBack, // ★ onBack 콜백 호출
        ),
        centerTitle: true,
        title: const Text(
          'My',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // 입력폼(스크롤)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 기본 정보
                    const Text(
                      '기본 정보',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spacing(h: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: heightController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '키 (cm)',
                              border: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: weightController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '몸무게 (kg)',
                              border: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacing(),

                    // 성별
                    const Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spacing(h: 6),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: isMale,
                              onChanged: (value) =>
                                  setState(() => isMale = value),
                            ),
                            const Text('남성', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: isMale,
                              onChanged: (value) =>
                                  setState(() => isMale = value),
                            ),
                            const Text('여성', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                    spacing(),

                    // 체형 선택 (피토그램)
                    const Text(
                      '체형 선택',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spacing(h: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (idx) => Padding(
                          padding: EdgeInsets.only(right: idx != 3 ? 16 : 0),
                          child: GestureDetector(
                            onTap: () => setState(() => selectedBodyType = idx),
                            child: Column(
                              children: [
                                BodyShapeIcon(
                                  type: idx,
                                  selected: selectedBodyType == idx,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ["역삼각형", "사각형", "삼각형", "모래시계"][idx],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: selectedBodyType == idx
                                        ? Colors.blue
                                        : Colors.black45,
                                    fontWeight: selectedBodyType == idx
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    spacing(h: 15),

                    // 사이즈
                    const Text(
                      '사이즈',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    spacing(h: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: topSizeController,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '상의',
                              border: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: bottomSizeController,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: '하의',
                              border: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacing(h: 24),
                  ],
                ),
              ),
            ),
          ),
          // 하단 고정 버튼
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black38, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  final fit = getFitRecommendation(
                    isMale: isMale,
                    bodyType: selectedBodyType,
                    topSize: topSizeController.text,
                    bottomSize: bottomSizeController.text,
                    height: heightController.text,
                    weight: weightController.text,
                  );
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("AI 추천 핏"),
                      content: Text("어울리는 핏은 '$fit' 입니다!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("확인"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  '나만의 핏 추천받기',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
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

// ----------------------
// 체형 피토그램 위젯 구현
// ----------------------
class BodyShapeIcon extends StatelessWidget {
  final int type; // 0:역삼각, 1:사각, 2:삼각, 3:모래시계
  final bool selected;
  const BodyShapeIcon({super.key, required this.type, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: selected ? Colors.blue[50] : Colors.white,
        border: Border.all(
          color: selected ? Colors.blue : Colors.black26,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: _ShapePainter(type, selected ? Colors.blue : Colors.black54),
      ),
    );
  }
}

class _ShapePainter extends CustomPainter {
  final int type;
  final Color color;
  _ShapePainter(this.type, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    switch (type) {
      case 0: // 역삼각형
        canvas.drawPolygon([
          Offset(size.width * 0.1, size.height * 0.8),
          Offset(size.width * 0.9, size.height * 0.8),
          Offset(size.width * 0.5, size.height * 0.2),
        ], paint);
        break;
      case 1: // 사각형
        canvas.drawRRect(
          RRect.fromLTRBR(
            size.width * 0.18,
            size.height * 0.2,
            size.width * 0.82,
            size.height * 0.8,
            const Radius.circular(6),
          ),
          paint,
        );
        break;
      case 2: // 삼각형(하체비만)
        canvas.drawPolygon([
          Offset(size.width * 0.5, size.height * 0.8),
          Offset(size.width * 0.1, size.height * 0.2),
          Offset(size.width * 0.9, size.height * 0.2),
        ], paint);
        break;
      case 3: // 모래시계
        final path = Path()
          ..moveTo(size.width * 0.25, size.height * 0.2)
          ..cubicTo(
            size.width * 0.5,
            size.height * 0.4,
            size.width * 0.5,
            size.height * 0.6,
            size.width * 0.25,
            size.height * 0.8,
          )
          ..moveTo(size.width * 0.75, size.height * 0.2)
          ..cubicTo(
            size.width * 0.5,
            size.height * 0.4,
            size.width * 0.5,
            size.height * 0.6,
            size.width * 0.75,
            size.height * 0.8,
          );
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ShapePainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.color != color;
}

extension CanvasExt on Canvas {
  void drawPolygon(List<Offset> points, Paint paint) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    path.close();
    drawPath(path, paint);
  }
}

// ----------------------
// AI 추천 핏 함수
// ----------------------
String getFitRecommendation({
  required bool? isMale,
  required int? bodyType,
  required String topSize,
  required String bottomSize,
  required String height,
  required String weight,
}) {
  // 예시 로직: 실제 AI/머신러닝, 또는 복잡한 룰로 확장 가능!
  if (bodyType == 0) return "레귤러핏";
  if (bodyType == 1) return "슬림핏";
  if (bodyType == 2) return "와이드핏";
  if (bodyType == 3) return "루즈핏";
  // 예외, 기본값
  return "레귤러핏";
}
