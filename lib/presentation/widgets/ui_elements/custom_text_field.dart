import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:currency_converter/presentation.dart';

class CustomTextField extends StatelessWidget {
  final bool autofocus;
  final Color borderColor;
  final double borderRadius;
  final TextEditingController? controller;
  final Color? cursorColor;
  final bool enabled;
  final String? errorText;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final FocusNode? focusNode;
  final double height;
  final double horizPad;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String hint;
  final TextStyle hintStyle;
  final bool showCursor;
  final TextStyle? style;
  final Widget suffix;
  final Widget? suffixIcon;
  final double suffixPadding;
  final TextAlignVertical textAlignVertical;
  final TextInputAction textInputAction;
  final double? width;
  final Iterable<String>? autofillHints;

  const CustomTextField({
    super.key,
    this.autofocus = false,
    this.borderColor = ColorPalette.grey,
    this.borderRadius = 10,
    this.controller,
    this.cursorColor = ColorPalette.greenLight,
    this.enabled = true,
    this.errorText = '',
    this.errorStyle,
    this.fillColor = ColorPalette.white,
    this.focusNode,
    this.height = 45,
    this.horizPad = 12,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.hint = 'Hint',
    required this.hintStyle,
    this.showCursor = true,
    this.style,
    this.suffix = const SizedBox(),
    this.suffixIcon,
    this.suffixPadding = 12,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.width,
    this.autofillHints,
  }) : assert(initialValue == null || controller == null);

  @override
  Widget build(BuildContext context) {
    final vertPad = ((height - style!.fontSize!) / 2) - 2;

    return Material(
      color: ColorPalette.transparent,
      child: SizedBox(
        width: width,
        child: Stack(
          children: <Widget>[
            TextFormField(
              autofocus: autofocus,
              controller: controller,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: height),
                contentPadding:
                    EdgeInsets.symmetric(
                      horizontal: horizPad,
                      vertical: vertPad,
                    ).copyWith(
                      right: suffixPadding,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: borderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: const BorderSide(color: ColorPalette.redLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: const BorderSide(color: ColorPalette.greenLight),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: const BorderSide(color: ColorPalette.redLight),
                ),
                errorText: errorText,
                errorStyle: errorStyle,
                fillColor: fillColor,
                filled: true,
                hintStyle: hintStyle,
                hintText: hint,
                suffixIcon: suffixIcon != null
                    ? Focus(
                        canRequestFocus: false,
                        descendantsAreFocusable: false,
                        child: suffixIcon!,
                      )
                    : null,
              ),
              enabled: enabled,
              focusNode: focusNode,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              maxLines: maxLines,
              obscureText: obscureText,
              onChanged: onChanged,
              onTap: onTap,
              showCursor: showCursor,
              style: style,
              textAlignVertical: textAlignVertical,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
            ),
            suffix,
          ],
        ),
      ),
    );
  }
}
