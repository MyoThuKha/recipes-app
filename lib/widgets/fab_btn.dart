import 'package:flutter/material.dart';
import 'package:recipes/styles/colors.dart';

class FabButton extends StatefulWidget {
  final List<FabItem> items;
  final dynamic current;

  const FabButton({super.key, required this.items, this.current});

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> with SingleTickerProviderStateMixin {
  late double fullItemSize;
  late double totalHeight;

  late AnimationController _controller;
  late Animation _heightAnimation;
  late CurvedAnimation _bounce;

  late FabItem currentItem;
  List<FabItem> choiceItems = [];

  bool isOpen = false;

  @override
  void initState() {
    initCalculation();
    initAnimation();
    super.initState();
  }

  void initCalculation() {
    fullItemSize = 80;
    totalHeight = (80 * widget.items.length) + 10;
  }

  void initAnimation() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _bounce = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _heightAnimation = Tween<double>(begin: fullItemSize, end: totalHeight).animate(_bounce);

    _controller.addListener(() {
      switch (_controller.status) {
        case AnimationStatus.completed:
          isOpen = true;
        default:
          isOpen = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleAnimation() {
    if (!isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {

    /* 
    can improve performance by reducing double looping appear in here. but considering app bar 
    items not exceeding more than 5, I will leave it as it is for now.
    */
    currentItem = widget.items.firstWhere((each) => each.value == widget.current);
    choiceItems = widget.items.where((each) => each.value != widget.current).toList();

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: fullItemSize,
            height: _heightAnimation.value,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: List.generate(
                    choiceItems.length,
                    (index) {
                      final newIndex = index + 1;
                      final positionAnimation = Tween<double>(begin: 0, end: (newIndex * 80) + (newIndex * 20)).animate(_bounce);
                      return Positioned(
                        bottom: positionAnimation.value,
                        child: GestureDetector(
                          onTap: () async {
                            toggleAnimation();
                            await Future.delayed(const Duration(milliseconds: 500));
                            choiceItems[index].onClick();
                          },
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: fabGrayColor,
                            child: choiceItems[index].child,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: toggleAnimation,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: currentItem.child,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class FabItem {
  final Widget child;
  final Object value;
  final VoidCallback onClick;

  FabItem({required this.value, required this.child, required this.onClick});
}
