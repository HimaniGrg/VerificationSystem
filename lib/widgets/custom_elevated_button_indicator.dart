import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

class CustomElevatedButtonIndicator extends BaseButton {
  const CustomElevatedButtonIndicator({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Stack(children: [
        Container(
          height: this.height,
          width: this.width,
          margin: margin,
          decoration: decoration,
        ),
        ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: buttonTextStyle ??
                        CustomTextStyles.titleLargeKameronOnPrimary,
                  ),
                ),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
        if (isDisabled ?? false)
          const Positioned(
            child: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 7, 125, 221))),
            ),
          ),
      ]);
}
