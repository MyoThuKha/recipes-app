import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes/consts/assets_icons.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/pages/home/widgets/meal_item.dart';
import 'package:recipes/providers/home_page_provider.dart';
import 'package:recipes/styles/colors.dart';
import 'package:recipes/widgets/app_buttons.dart';
import 'package:recipes/widgets/choice_widget.dart';
import 'package:recipes/widgets/dynamic_blur_appbar.dart';
import 'package:recipes/widgets/empty_widget.dart';
import 'package:recipes/widgets/loading_widgets.dart';
import 'package:recipes/widgets/snack_bar_widget.dart';

const mainPagePadding = EdgeInsets.symmetric(horizontal: 16.0);

class DishesView extends StatefulWidget {
  const DishesView({super.key});

  @override
  State<DishesView> createState() => _DishesViewState();
}

class _DishesViewState extends State<DishesView> {

  int currentIndex = 0;

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  Future<void> callAPIRequest() async {
    final model = context.read<HomePageProvider>();
    await model.getCategories();
    model.loadAllLocalDishes();
    model.getMealsByCategory(model.categories[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // MARK: APP BAR
        DynamicBlurAppbar(
          titleHeight: 100,
          bottomHeight: 50,
          scrollScaling: 0.6,
          pinned: true,
          title: Padding(
            padding: mainPagePadding,
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleBtn(
                  background: AppColors.orange,
                  onClick: () {
                    context.push(Uri(path: '/detail/random').toString());
                  },
                  child: Image.asset(AssetsIcons.dice, width: 25, height: 25),
                ),
                Text("Dishes", style: context.theme.appBarTheme.titleTextStyle),
              ],
            ),
          ),
          // MARK: CHOICE SECTION
          bottom: Consumer<HomePageProvider>(
            builder: (context, model, _) {
              return ListView.separated(
                padding: mainPagePadding,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
                itemCount: model.categories.length,
                itemBuilder: (context, index) {
                  return AnimatedScrollViewItem(
                    child: ChoiceWidget(
                      index: index,
                      activeIndex: currentIndex,
                      label: model.categories[index],
                      onClick: () {
                        if (index == currentIndex) return;
                        setState(() => currentIndex = index);
                        model.getMealsByCategory(model.categories[index]);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // MARK: MEAL GRID
        Consumer<HomePageProvider>(
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
                    icon: AssetsIcons.spices,
                    title: "Seem like our chef is out of town\n for this category.",
                    endSpacing: 250,
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
                        icon: AssetsIcons.fridge,
                        onClick: (_) => addToCollection(meal),
                      ),
                    ),
                  );
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

  void addToCollection(Meal meal) async {
    showSnackBarWidget(context: context, message: "Adding...");

    final result = await context.read<HomePageProvider>().addToCollection(meal);

    if (!mounted) return;
    showSnackBarWidget(context: context, message: result.message);
  }
}
