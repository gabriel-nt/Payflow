import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarCodeScannerPage extends StatefulWidget {
  BarCodeScannerPage({Key? key}) : super(key: key);
  @override
  _BarCodeScannerPageState createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {

  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarCode) {
        Navigator.pushReplacementNamed(context, '/insert_boleto');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Stack(
          children: [
            ValueListenableBuilder<BarCodeScannerStatus>(
              valueListenable: controller.statusNotifier, 
              builder: (_, status, __) {
                print(status);

                if (status.showCamera) {
                  return Container(
                    color: Colors.blue,
                    child: status.cameraController!.buildPreview()
                  );
                } else {
                  return Container();
                }
              }
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    'Escaneie o código de barras do boleto',
                    style: AppTextStyles.buttonBackground,
                  ),
                  centerTitle: true,
                  leading: BackButton(
                    color: AppColors.background
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.65)
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent
                      )
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.65)
                      )
                    ),
                  ]
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: 'Inserir código do boleto', 
                  primaryOnPressed: (){}, 
                  secondaryLabel: 'Adicionar da galeria', 
                  secondaryOnPressed: (){}
                )
              ),
            ),
            ValueListenableBuilder<BarCodeScannerStatus>(
              valueListenable: controller.statusNotifier, 
              builder: (_, status, __) {
                print(status);
                if (status.hasError) {
                  return BottomSheetWidget(
                    title: 'Não foi possível identificar um código de barras',
                    subtitle: 'Tente escanear novamente ou digite o código do seu boleto',
                    primaryLabel: 'Escanear novamente', 
                    primaryOnPressed: (){
                      controller.getAvailableCameras();
                    }, 
                    secondaryLabel: 'Digitar código', 
                    secondaryOnPressed: (){}
                  );
                } else {
                  return Container();
                }
              }
            ),
          ],
        ),
    );
  }
}