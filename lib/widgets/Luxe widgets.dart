
import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:flutter/material.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
class LuxeButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const LuxeButton({
    super.key,
    required this.label,
    this.onPressed,
    this.outlined = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? (outlined ? Colors.transparent : dark);
    final fg = textColor ?? (outlined ? dark : Colors.white);

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          side: outlined
              ? const BorderSide(color: dark, width: 1.2)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: AppTextStyles.label(11,
                    color: fg, weight: FontWeight.w700, spacing: 2),
              ),
      ),
    );
  }
}

class LuxeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const LuxeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bg,
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: AppTextStyles.display(28)),
      iconTheme: const IconThemeData(color: dark),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LuxeSectionLabel extends StatelessWidget {
  final String label;

  const LuxeSectionLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyles.label(10, spacing: 2));
  }
}