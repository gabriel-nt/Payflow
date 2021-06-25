import 'package:camera/camera.dart';

class BarCodeScannerStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;

  CameraController? cameraController;

  BarCodeScannerStatus({
    this.isCameraAvailable = false,
    this.cameraController,
    this.error = '',
    this.barcode = ''
  });

  factory BarCodeScannerStatus.available(CameraController controller) => 
    BarCodeScannerStatus(isCameraAvailable: true, cameraController: controller);

  factory BarCodeScannerStatus.error(String message) => 
    BarCodeScannerStatus(error: message);

  factory BarCodeScannerStatus.barcode(String message) => 
    BarCodeScannerStatus(barcode: message);

  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  bool get hasBarCode => barcode.isNotEmpty;
}