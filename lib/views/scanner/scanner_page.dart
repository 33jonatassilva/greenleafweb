import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool isScanComplete = false;
  String scannedProduct = '';
  int pointsEarned = 0;
  String co2Saved = '';
  int recycledCount = 0;

  void closeScreen() {
    setState(() {
      isScanComplete = false;
    });
  }

  void simulateScan() {
    setState(() {
      isScanComplete = true;
      scannedProduct = 'Plastic Bottle';
      pointsEarned = 2;
      co2Saved = 'SAVED CO2';
      recycledCount = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.store, color: Colors.green, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Scan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: isScanComplete
          ? buildScanCompleteScreen()
          : buildScannerScreen(),
    );
  }

  Widget buildScannerScreen() {
    return Stack(
      children: [
        // Simulação do scanner na web
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_scanner, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                'Scanner não disponível na web',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: simulateScan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('SIMULAR SCAN'),
              ),
            ],
          ),
        ),
        if (!kIsWeb) // Mantém o overlay original para mobile
          QRScannerOverlay(
            overlayColor: Colors.black.withOpacity(0.5),
          ),
      ],
    );
  }

  Widget buildScanCompleteScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 20),
          Text(
            scannedProduct,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '$pointsEarned POINTS',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('RECEIVED'),
          const SizedBox(height: 20),
          Text(
            co2Saved,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '$recycledCount + RECYCLED',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: closeScreen,
            child: const Text(
              'SCAN AGAIN',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// Mantido para compatibilidade com mobile
class QRScannerOverlay extends StatelessWidget {
  final Color overlayColor;

  const QRScannerOverlay({
    Key? key,
    required this.overlayColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scanArea = MediaQuery.of(context).size.width - 80;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColor,
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: scanArea,
                    height: scanArea,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size(scanArea, scanArea),
            painter: BorderPainter(),
          ),
        ),
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}