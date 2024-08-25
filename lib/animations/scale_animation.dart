import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onClick;
  const ScaleAnimation({super.key, required this.child, required this.onClick});

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _scale;
  late CurvedAnimation _curve;

  final animationTime = const Duration(milliseconds: 300);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: animationTime);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.6), weight: 50),
        TweenSequenceItem(tween: Tween<double>(begin: 0.6, end: 1), weight: 50),
      ],
    ).animate(_curve);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.scale(
          scale: _scale.value,
          child: GestureDetector(
            onTap: () async{
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              await Future.delayed(const Duration(milliseconds: 500));
              widget.onClick();
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}
