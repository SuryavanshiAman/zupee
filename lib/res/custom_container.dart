import 'package:flutter/material.dart';
import '../main.dart';

class CustomContainer extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? widths;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final BlurStyle? blurStyle;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;
  final BoxBorder? border;
  final DecorationImage? image;
  final Clip? clipBehavior;
  const CustomContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.widths,
    this.height,
    this.margin,
    this.gradientColorOne,
    this.gradientColorTwo,
    this.shadowColor,
    this.dx,
    this.dy,
    this.gradient,
    this.label,
    this.style,
    this.icon,
    this.fontWeight,
    this.fontStyle,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.begin,
    this.end,
    this.blurRadius,
    this.spreadRadius,
    this.child,
    this.borderRadius,
    this.blurStyle,
    this.boxShadow,
    this.onTap,
    this.border,
    this.image,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: clipBehavior ?? Clip.none,
        alignment: alignment,
        margin: margin,
        padding: padding,
        height: height,
        width: widths ?? width,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color,
            gradient: gradient,
            boxShadow: boxShadow,
            border: border,
            image: image),
        child: child ??
            Row(
              children: [
                Text(
                  label == null ? "" : label!,
                  style: TextStyle(color: textColor, fontSize: fontSize),
                ),
                Icon(
                  icon,
                  color: iconColor,
                )
              ],
            ),
      ),
    );
  }
}
