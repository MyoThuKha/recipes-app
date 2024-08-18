import 'package:flutter/material.dart';
import 'package:recipes/animations/opacity_animation.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  const AppBarWidget({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: OpacityAnimation(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
      leading: leading,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 140,
      backgroundColor: Colors.transparent,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(140);
}