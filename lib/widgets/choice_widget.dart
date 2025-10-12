import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChoiceWidget extends StatefulWidget {
  final String? label;
  final VoidCallback onClick;
  final int index;
  final int activeIndex;
  const ChoiceWidget({
    super.key,
    required this.label,
    required this.onClick,
    required this.index,
    required this.activeIndex,
  });

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(width: 1, color: context.colorScheme.outline),
          ),
          gradient: RadialGradient(
            center: AlignmentGeometry.centerLeft,
            radius: widget.index == widget.activeIndex ? 10 : 0,
            colors: <Color>[
              context.colorScheme.surface,
              context.colorScheme.surface,
              Colors.transparent,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label ?? "",
          style: GoogleFonts.inter(
            textStyle: context.textTheme.labelMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
