import 'package:flutter/material.dart';
import 'package:recipes/styles/colors.dart';

class FabButton extends StatefulWidget {
  final List<FabItem> items;

  const FabButton({super.key, required this.items});

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> with SingleTickerProviderStateMixin {

  late FabItem currentItem;

  late double fullItemSize;
  late double totalHeight;

  late AnimationController _controller;
  late Animation _heightAnimation;
  late CurvedAnimation _bounce;

  bool isOpen = false;

  @override
  void initState() {
    currentItem = widget.items[0];
    initCalculation();
    initAnimation();
    super.initState();
  }


  void initCalculation(){
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
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: fullItemSize,
            height: _heightAnimation.value,
            // height: 170,
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
                    widget.items.length,
                    (index) {
                      final positionAnimation = Tween<double>(begin: 0, end: (index * 80) + (index * 20)).animate(_bounce);
                      return Positioned(
                        bottom: positionAnimation.value,
                        child: GestureDetector(
                          onTap: () async {
                            toggleAnimation();
                            await Future.delayed(const Duration(milliseconds: 500));
                            final temporaryItem = currentItem;
                            setState(() {
                              currentItem = widget.items[index];
                              widget.items[index] = temporaryItem;
                            });

                            currentItem.onClick();
                          },
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: fabGrayColor,
                            child: widget.items[index].child,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    toggleAnimation();
                  },
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
  final VoidCallback onClick;

  FabItem({required this.child, required this.onClick});
}
