import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabs;
  final double height;
  final double paddingSpace;
  const AppTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.height = 80,
    this.paddingSpace = 5,
  });

  @override
  Widget build(BuildContext context) {

    final eachSize = height - (paddingSpace * 2);
    final width = tabs.length * (eachSize) + (paddingSpace * 2);


    return SafeArea(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(5),
        decoration: ShapeDecoration(
          color: context.colorScheme.surface,
          shape: const StadiumBorder(),
          // shadows: ContainerStyles.cardShadows,
        ),
        child: TabBar(
          controller: tabController,
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: tabs,
        ),
      ),
    );
  }
}



class AppTabBarIcon extends StatelessWidget {
  final String icon;
  const AppTabBarIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: 30, height: 30, fit: BoxFit.contain);
  }
}
