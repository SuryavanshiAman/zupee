import 'package:flutter/material.dart';
import 'package:zupee/res/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration = const InputDecoration();
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign = TextAlign.start;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly = false;
  final int? maxLines;
  final int? minLines;
  final bool expands = false;
  final int? maxLength;
  final bool obscureText = false;
  final TextInputType? keyboardType;
  final Widget? icon;
  final Color? iconColor;
  final String? label;
  final bool? filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final void Function(String)? onChanged;
  final double? height;
  final double? width;
  final double? hintSize;
  final double? fontSize;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorHeight;
  final Color? cursorColor;
  final Widget? prefix;
  final Widget? suffix;
  final BorderRadius? fieldRadius;
  final bool? enabled;
  final void Function()? onTap;
  final bool? autofocus;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final Color? hintColor;
  final String? errorText;
  final BorderSide? borderSide;
  final Color? textColor;
  final TextInputAction? textInputAction;
  final bool outLineBorderEnabled;
  final BorderSide? borderSideFocus;

  const CustomTextField({
    super.key,
    this.controller,
    this.style,
    this.strutStyle,
    this.textAlignVertical,
    this.textDirection,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.icon,
    this.iconColor,
    this.label,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.onChanged,
    this.height,
    this.width,
    this.hintSize,
    this.fontSize,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.contentPadding,
    this.cursorHeight,
    this.cursorColor,
    this.prefix,
    this.suffix,
    this.fieldRadius,
    this.enabled,
    this.maxLines,
    this.onTap,
    this.autofocus,
    this.onSaved,
    this.validator,
    this.margin,
    this.hintColor,
    this.errorText,
    this.borderSide,
    this.textColor,
    this.textInputAction,
    this.outLineBorderEnabled =false,
    this.borderSideFocus,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height ?? 55,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          autofocus: autofocus ?? false,
          textAlignVertical: TextAlignVertical.center,
          enabled: enabled,
          controller: controller,
          cursorColor: cursorColor,
          cursorHeight: cursorHeight,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          expands: expands,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: style ?? TextStyle(
                    fontSize: fontSize ?? 15,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: textColor ?? black),

          decoration: InputDecoration(
            errorText: errorText,
            counterText: "",
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: filled ?? true,
            fillColor: fillColor ?? lightGray,
            hintText: label,
            hintStyle:TextStyle(
                  fontSize: hintSize ?? 15,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: hintColor ?? lightGray),

            contentPadding: contentPadding ??
                const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
            disabledBorder:outLineBorderEnabled?OutlineInputBorder(
                borderSide:borderSide??BorderSide.none,
                borderRadius:fieldRadius== null? const BorderRadius.all(Radius.circular(4.0)):fieldRadius!
            ) :UnderlineInputBorder(
                borderSide: borderSide ?? BorderSide.none,
                borderRadius: fieldRadius??const BorderRadius.all(Radius.circular(4.0))
            ),
            border:outLineBorderEnabled?OutlineInputBorder(
                borderSide:borderSide??BorderSide.none,
                borderRadius:fieldRadius== null? const BorderRadius.all(Radius.circular(4.0)):fieldRadius!
            ) :UnderlineInputBorder(
                borderSide: borderSide ?? BorderSide.none,
                borderRadius: fieldRadius??const BorderRadius.all(Radius.circular(4.0))
            ),
            enabledBorder:outLineBorderEnabled? OutlineInputBorder(
                borderSide:borderSide??BorderSide.none,
                borderRadius:fieldRadius== null? const BorderRadius.all(Radius.circular(4.0)):fieldRadius!
            ):UnderlineInputBorder(
                borderSide: borderSide ?? BorderSide.none,
                borderRadius: fieldRadius??const BorderRadius.all(Radius.circular(4.0))

            ),
            focusedBorder:outLineBorderEnabled? OutlineInputBorder(
                borderSide:borderSide??BorderSide.none,
                borderRadius:fieldRadius== null? const BorderRadius.all(Radius.circular(4.0)):fieldRadius!
            ):UnderlineInputBorder(
                borderSide: borderSideFocus ?? BorderSide.none,
                borderRadius: fieldRadius??const BorderRadius.all(Radius.circular(4.0))

            ),
          ),
        ),
      ),
    );
  }
}