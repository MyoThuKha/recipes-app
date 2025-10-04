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

class _ChoiceWidgetState extends State<ChoiceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> radiusTween;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 800),
    );

    radiusTween = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChoiceWidget oldWidget) {
    if (widget.index == widget.activeIndex) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: ShapeDecoration(
              // color: widget.index == widget.activeIndex ? Colors.black : Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  width: 1.2,
                  color: context.colorScheme.outline,
                ),
              ),
              gradient: RadialGradient(
                center: AlignmentGeometry.centerLeft,
                radius: radiusTween.value,
                colors: <Color>[
                  context.colorScheme.surface,
                  context.colorScheme.surface,
                  Colors.transparent,
                ],
              ),
            ),
            alignment: Alignment.center,
            child: child,
          );
        },
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
