import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final VoidCallback onPressed;

  const LabelButton({
    Key? key,
    this.style,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.shape,
      child: TextButton(
        onPressed: onPressed, 
        child: Text(label, style: style ?? AppTextStyles.buttonHeading),
      ),
    );
  }
}