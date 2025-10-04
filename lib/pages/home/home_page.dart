import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes/consts/emoji_icons.dart';
import 'package:recipes/pages/home/widgets/meal_item.dart';
import 'package:recipes/providers/home_page_provider.dart';
import 'package:recipes/styles/colors.dart';
import 'package:recipes/widgets/app_buttons.dart';
import 'package:recipes/widgets/background_widget.dart';
import 'package:recipes/widgets/choice_widget.dart';
import 'package:recipes/widgets/loading_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  void callAPIRequest() async {
    final model = context.read<HomePageProvider>();
    await model.getCategories();
    model.getMealsByCategory(model.categories[currentIndex]);
  }

  final mainPagePadding = const EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // MARK: APP BAR
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: mainPagePadding,
                expandedTitleScale: 1.4,
                title: Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleBtn(
                      background: AppColors.orange,
                      onClick: () {
                        context.push(Uri(path: '/detail/random').toString());
                      },
                      child: const Text(
                        EmojiIcons.dice,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      "Dishes",
                      style: context.theme.appBarTheme.titleTextStyle,
                    ),
                  ],
                ),
              ),
            ),

            // MARK: CHOICE SECTION
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 50,
                child: Consumer<HomePageProvider>(
                  builder: (context, model, _) {
                    return ListView.separated(
                      padding: mainPagePadding,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: model.categories.length,
                      itemBuilder: (context, index) {
                        return ChoiceWidget(
                          index: index,
                          activeIndex: currentIndex,
                          label: model.categories[index],
                          onClick: () {
                            if (index == currentIndex) return;
                            setState(() => currentIndex = index);
                            model.getMealsByCategory(model.categories[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        
            // MARK: MEAL GRID
            Consumer<HomePageProvider>(
              builder: (context, provider, _) {

                if (provider.isLoading) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: GridViewLoading()),
                  );
                }

                return SliverPadding(
                  padding: mainPagePadding,
                  sliver: SliverGrid.builder(
                    itemCount: provider.meals.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      final meal = provider.meals[index];
                      return AnimatedScrollViewItem(
                        child: MealItem(meal: meal),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
