import 'package:flutter/material.dart';

class BouncingAnimation extends StatefulWidget {
  final Widget child;
  const BouncingAnimation({super.key, required this.child});

  @override
  State<BouncingAnimation> createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _bouncing;
  late CurvedAnimation _curve;

  final animationTime = const Duration(milliseconds: 500);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: animationTime);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _bouncing = TweenSequence(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(tween: Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -20)), weight: 50),
        TweenSequenceItem(tween: Tween<Offset>(begin: const Offset(0, -20), end: const Offset(0, 0)), weight: 50),
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
        return Transform.translate(
          offset: _bouncing.value,
          child: GestureDetector(
            onTap: () async {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}
