import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class MyBoletosPage extends StatefulWidget {
  const MyBoletosPage({Key? key}) : super(key: key);

  @override
  _MyBoletosPageState createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ValueListenableBuilder<List<BoletoModel>>(
                  valueListenable: controller.boletosNotifier, 
                  builder: (_, boletos, __) => 
                    AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfo(size: boletos.length
                    )
                  ),
                )
              )
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              children: [
                Text(
                  'Meus boletos', 
                  style: AppTextStyles.titleBoldHeading
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoList(
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}