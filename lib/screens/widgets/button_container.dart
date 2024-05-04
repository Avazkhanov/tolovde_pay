import 'package:flutter/material.dart';

import '../../../utils/colors/app_colors.dart';


enum IconPosition { left, top, right, bottom }

class ButtonContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLoading;
  final Widget? icon;
  final IconPosition iconPosition;
  final String title;
  final double? width;
  final Color? background;
  final Color? borderColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const ButtonContainer({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.background,
    this.borderColor,
    this.textColor,
    this.fontSize = 16,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.isLoading = false,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: (borderColor ?? background) ?? Colors.transparent,
            ),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        overlayColor: MaterialStateProperty.all(
            AppColors.mainColor.withOpacity(.4)
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return background ?? AppColors.secondaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey.withOpacity(0.3);
            }
            return background ?? AppColors.secondaryColor;
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: icon != null && iconPosition == IconPosition.left
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              if (icon != null && iconPosition == IconPosition.left)
                SizedBox(width: MediaQuery.of(context).size.width * 0.28),
              if (icon != null && iconPosition == IconPosition.left)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 10),
                  child: icon!,
                ),
              Container(
                height: 56,
                width: width,
                alignment: Alignment.center,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    :

                Text(
                  title,
                  textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
                ),
              ),
              if (icon != null && iconPosition == IconPosition.right)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: icon!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}