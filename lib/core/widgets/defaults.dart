import 'package:flutter/material.dart';

import '../const/const.dart';

class Defaults {
  static Widget defaultTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    Widget suffixIcon = const SizedBox.shrink(),
    ValueChanged<String>? onChanged,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    Widget prefixIcon = const SizedBox.shrink(),
  }) {
    return TextFormField(
      validator: validator,
      style: Theme.of(context).textTheme.titleMedium,
      cursorColor: Theme.of(context).iconTheme.color,
      keyboardType: keyboardType,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r16),
          borderSide: BorderSide(
            color: Theme.of(context).iconTheme.color!,
          ),
        ),
        labelText: title,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r16),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r16),
            borderSide: BorderSide(
              color: Theme.of(context).iconTheme.color!,
            )),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).iconTheme.color!,
          ),
        ),
      ),
    );
  }

  static Widget defaultButton({
    required BuildContext context,
    required String title,
    required VoidCallback onPressed,
    double width = double.infinity,
    double height = AppHeight.h46,
    Color? color,
    Color? textColor,
  }) {
    return MaterialButton(
      minWidth: width,
      height: height,
      color: color ?? Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r25),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor ?? Colors.white,
            ),
      ),
    );
  }
}
