import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode = ''}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: 'R\$', 
    decimalSeparator: ','
  );

  final dueDateInputTextController = MaskedTextController(
    mask: '00/00/0000'
  );

  final barCodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null && widget.barcode != 'null') {
      barCodeInputTextController.text = widget.barcode!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 93,
                ),
                child: Text(
                  'Preencha os dados do boleto', 
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleBoldHeading,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputText(
                      label: 'Nome do boleto', 
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                      validator: controller.validateName,
                    ),
                    InputText(
                      label: 'Vencimento', 
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                      controller: dueDateInputTextController,
                      validator: controller.validateDueDate,
                    ),
                    InputText(
                      label: 'Valor', 
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller.onChange(value: moneyInputTextController.numberValue);
                      },
                      controller: moneyInputTextController,
                      validator: (_) => controller.validateValue(moneyInputTextController.numberValue),
                    ),
                    InputText(
                      label: 'Código', 
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                      controller: barCodeInputTextController,
                      validator: controller.validateCode,
                    ),
                  ]
                )
              )
            ]
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: 'Cancelar', 
        primaryOnPressed: (){
          Navigator.pop(context);
        }, 
        secondaryLabel: 'Cadastrar', 
        secondaryOnPressed: () async {
          final instance = await SharedPreferences.getInstance();
          final json = instance.get('user') as String;
          await controller.createBoleto();
          
          Navigator.pushReplacementNamed(
            context, '/home', 
            arguments: UserModel.fromJson(json)
          );
        },
        enableSecondaryColor: true,
      ),
    );
  }
}