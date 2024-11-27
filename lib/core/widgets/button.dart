import 'package:expense_bud/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final double? width;
  final double? height;
  final Color? color;

  /// if child is not null, we want to use it instead of the label
  final Widget? child;

  const Button(this.label,
      {this.onTap, this.color, this.child, this.width, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height ?? 49,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStateProperty.all(color),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            )),
      ),
    );
  }
}
