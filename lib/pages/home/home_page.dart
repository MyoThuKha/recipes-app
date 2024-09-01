import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/detail/detail_page.dart';
import 'package:recipes/pages/home/widgets/meal_item.dart';
import 'package:recipes/providers/home_page_provider.dart';
import 'package:recipes/styles/colors.dart';
import 'package:recipes/styles/main_app_style.dart';
import 'package:recipes/widgets/app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(
          title: "Home Screen",
          leading: Container(
            padding: const EdgeInsets.only(left: 2),
            child: CircleBtn(
              background: orangePrimaryColor,
              onClick: () {
                context.push(Uri(path: '/detail/random').toString());
              },
              child: const Text(diceIcon, style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // choice section
            SizedBox(
              height: 50,
              child: Consumer<HomePageProvider>(builder: (context, model, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: model.categories.length,
                  itemBuilder: (context, index) {
                    return ChoiceWidget(
                      index: index,
                      active: currentIndex,
                      label: model.categories[index],
                      onClick: () {
                        if (index == currentIndex) {
                          return;
                        }
        
                        setState(() {
                          currentIndex = index;
                        });
                        model.getMealsByCategory(model.categories[index]);
                      },
                    );
                  },
                );
              }),
            ),
        
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Consumer<HomePageProvider>(
                  builder: (context, model, _) {
                    return model.isLoading
                        ? const Center(
                            child: GridViewLoading(),
                          )
                        : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: model.meals.length,
                          itemBuilder: (context, index) {
                            final meal = model.meals[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MealItem(meal: meal),
                            );
                          },
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
