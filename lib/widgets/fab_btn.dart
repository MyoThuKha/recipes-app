import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:recipes/styles/colors.dart';

enum Content { instructions, ingredients }

class FABButton extends StatefulWidget {
  final List<FabItem> items;
  final Content current;
  const FABButton({super.key, required this.items, required this.current});

  @override
  State<FABButton> createState() => _FABButtonState();
}

class _FABButtonState extends State<FABButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;
  final Tween<double> _animateTween = Tween(begin: 0, end: 1);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _animation = _animateTween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      ),
    );

    _updateItems();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  FabItem? _activeItem;
  final List<FabItem> _inactiveItems = [];

  void _updateItems() {
    _inactiveItems.clear();
    for (var item in widget.items) {
      if (item.value == widget.current) {
        _activeItem = item;
      } else {
        _inactiveItems.add(item);
      }
    }
  }

  @override
  void didUpdateWidget(covariant FABButton oldWidget) {
    _updateItems();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 80,
          height: _animation.value * (40 * (_inactiveItems.length + 1)) + 80,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: StadiumBorder(
              // side: BorderSide(
              //   color: context.colorScheme.outline.opaque(0.4),
              //   width: 0.4,
              // ),
            ),
          ),
          alignment: Alignment.bottomRight,
          child: child,
        );
      },

      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // MARK: Inactive FAB Items
          ...List.generate(_inactiveItems.length, (index) {
            final item = _inactiveItems[index];

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  // (0 or 1) * (index (up by 1 for active item) * (size + spacing)) + (spacing for active item)
                  bottom: _animation.value * (index + 1) * (60 + 10) + 20,
                  // bottom: 100,
                  child: child!,
                );
              },
              child: GestureDetector(
                onTap: () {
                  if (_controller.isAnimating) return;
                  _controller.reverse();
                  item.onClick?.call(item.value);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.gray,
                  child: item.child,
                ),
              ),
            );
          }),

          // MARK: Active FAB Item
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: onToggle,
              behavior: HitTestBehavior.translucent,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: context.colorScheme.onSurface,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _activeItem?.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onToggle() {
    if (_controller.isAnimating) {
      return;
    }
    if (_controller.value == 0) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

class FabItem {
  final Widget child;
  final Content value;
  final ValueChanged<Content>? onClick;

  FabItem({required this.value, required this.child, this.onClick});
}
