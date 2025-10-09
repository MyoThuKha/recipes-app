import 'package:flutter/material.dart';
import 'package:recipes/consts/assets_icons.dart';
import 'package:recipes/pages/home/views/collections_view.dart';
import 'package:recipes/pages/home/views/dishes_view.dart';
import 'package:recipes/widgets/app_tab_bar.dart';
import 'package:recipes/widgets/background_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {


  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [DishesView(), CollectionsView()],
          // children: const [Text("Dish View"), Text("Collections View")],

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: AppTabBar(
          height: 75,
          tabController: _tabController,
          tabs: const [
            AppTabBarIcon(icon: AssetsIcons.kitchen),
            AppTabBarIcon(icon: AssetsIcons.fridge),
          ],
        ),
      ),
    );
  }

}
