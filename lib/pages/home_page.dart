import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes/main.dart';
import 'package:recipes/pages/detail_page.dart';
import 'package:recipes/providers/home_page_provider.dart';
import 'package:recipes/styles/main_app_style.dart';
import 'package:recipes/widgets/app_bar.dart';
import 'package:recipes/widgets/background_widget.dart';
import 'package:recipes/widgets/choice_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  void callAPIRequest()async{
    final model = context.read<HomePageProvider>();
    await model.getCategories();
    model.getMealsByCategory(model.categories[0]);
  }


  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const AppBarWidget(title: "Home Screen"),
        body: Padding(
          padding: appContentMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Consumer<HomePageProvider>(
                builder: (context,model,_) {
                  return SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.categories.length,
                    itemBuilder: (context, index) {
                      return ChoiceWidget(
                        label: model.categories[index],
                        onClick: () {
                          model.getMealsByCategory(model.categories[index]);

                        },
                      );
                    },
                  ),
                  );
                }
              ),


              Consumer<HomePageProvider>(
                builder: (context, model, _) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: model.meals.length,
                    itemBuilder: (context, index) {
                      final meal = model.meals[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            context.push("/detail");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber[300],
                              borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(image: NetworkImage(meal.strMealThumb ?? "")),
                            ),
                            alignment: Alignment.center,
                            child: Text(meal.strMeal?? ""),
                          ),
                        ),
                      );
                    },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}