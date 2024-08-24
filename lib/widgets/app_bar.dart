import 'package:flutter/material.dart';
import 'package:recipes/animations/opacity_animation.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  const AppBarWidget({super.key, required this.title, this.leading,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: OpacityAnimation(
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      centerTitle: false,
      toolbarHeight: 100,
      forceMaterialTransparency: true,
      leading: leading,
      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(100);
}