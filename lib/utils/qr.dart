import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String) onScan;

  QRScannerWidget({required this.onScan});

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      color: Colors.white.withOpacity(0),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        cameraFacing: CameraFacing.back,
        overlay: QrScannerOverlayShape(
          borderColor: toColor("d4d4d4"),
          cutOutSize: 300,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      widget.onScan(scanData.code ?? "");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
