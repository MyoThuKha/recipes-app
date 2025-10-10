import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/consts/assets_icons.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/pages/home/widgets/meal_item.dart';
import 'package:recipes/providers/collections_page_provider.dart';
import 'package:recipes/styles/colors.dart';
import 'package:recipes/widgets/dynamic_blur_appbar.dart';
import 'package:recipes/widgets/empty_widget.dart' show EmptyWidget;
import 'package:recipes/widgets/loading_widgets.dart';

const mainPagePadding = EdgeInsets.symmetric(horizontal: 16.0);

class CollectionsView extends StatefulWidget {
  const CollectionsView({super.key});

  @override
  State<CollectionsView> createState() => _CollectionsViewState();
}

class _CollectionsViewState extends State<CollectionsView> {

  int currentIndex = 0;

  @override
  void initState() {
    fetchLocalDishes();
    super.initState();
  }

  void fetchLocalDishes() async {
    context.read<CollectionsPageProvider>().getLocalDishes();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // MARK: APP BAR

        DynamicBlurAppbar(
          titleHeight: 80,
          bottomHeight: 0,
          scrollScaling: 0.6,
          pinned: true,
          title: Padding(
            padding: mainPagePadding,
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.orange,
                  child: Image.asset(AssetsIcons.fridge, width: 35, height: 35),
                ),
                Text(
                  "Your Collections",
                  style: context.theme.appBarTheme.titleTextStyle,
                ),
              ],
            ),
          ),
          // bottom: Consumer<HomePageProvider>(
          //   builder: (context, model, _) {
          //     return ListView.separated(
          //       padding: mainPagePadding,
          //       separatorBuilder: (context, index) => const SizedBox(width: 8),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: model.categories.length,
          //       itemBuilder: (context, index) {
          //         return AnimatedScrollViewItem(
          //           child: ChoiceWidget(
          //             index: index,
          //             activeIndex: currentIndex,
          //             label: model.categories[index],
          //             onClick: () {
          //               if (index == currentIndex) return;
          //               setState(() => currentIndex = index);
          //               model.getMealsByCategory(model.categories[index]);
          //             },
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // MARK: MEAL GRID
        Consumer<CollectionsPageProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: GridViewLoading()),
              );
            }
            if (provider.meals.isEmpty) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: EmptyWidget(
                    icon: AssetsIcons.dishDrying,
                    // title: "Nothing in your collection yet.",
                    title: "Very Clean Collection.\nReady to add some dishes.",
                    endSpacing: 200,
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: mainPagePadding,
              sliver: SliverGrid.builder(
                itemCount: provider.meals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final meal = provider.meals[index];
                  return AnimatedScrollViewItem(
                    child: MealItem(
                      meal: meal,
                      action: MealItemAction(
                        label: "Add to Collection",
                        icon: AssetsIcons.trash,
                        onClick: (_) => removeFromCollection(meal),
                      ),
                  ));
                },
              ),
            );
          },
        ),

        // Spacing for bottom
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }

  void removeFromCollection(Meal meal) async {
    context.read<CollectionsPageProvider>().remove(meal);
  }
}
