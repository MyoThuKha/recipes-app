import 'package:flutter/material.dart';
import 'package:recipes/animations/opacity_animation.dart';

class ChoiceWidget extends StatefulWidget {
  final String? label;
  final VoidCallback onClick;
  final int index;
  final int active;
  const ChoiceWidget({super.key, required this.label, required this.onClick, required this.index, required this.active});

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation alignAnimation;
  late Animation colorAnimation;
  late Animation textMoveAnimation;
  late CurvedAnimation curve;

  @override
  void initState() {
    initAnimationValues();
    super.initState();
  }

  void initAnimationValues (){
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    alignAnimation = Tween<Alignment>(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(curve);
    colorAnimation = ColorTween(begin: Colors.white, end: Colors.black).animate(curve);
    textMoveAnimation = Tween<double>(begin: 0, end: 30).animate(curve);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = widget.index == widget.active;

    if (isActive) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return OpacityAnimation(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return GestureDetector(
                onTap: () {
                  widget.onClick();
                },
                child: Container(
                        width: 120,
                  decoration: BoxDecoration(
                    color: colorAnimation.value,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: alignAnimation.value,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                      ),

                      // check mark
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.check_rounded,
                            color: colorAnimation.value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: textMoveAnimation.value),
                        child: Text(
                          widget.label ?? "",
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
