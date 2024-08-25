import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/extensions/str_extension.dart';
import 'package:recipes/pages/detail/widgets/content_page.dart';
import 'package:recipes/pages/detail/widgets/ingredient_tile.dart';
import 'package:recipes/pages/detail/widgets/ingredients_page.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/styles/main_app_style.dart';
import 'package:recipes/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/widgets/app_buttons.dart';
import 'package:recipes/widgets/background_widget.dart';
import 'package:recipes/widgets/fab_btn.dart';

enum Content { instructions, ingredients }

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";
  final String mealId;
  const DetailPage({super.key, required this.mealId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  Content currentContent = Content.instructions;

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  void callAPIRequest() {
    context.read<DetailPageProvider>().getMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
          children: [
            BackBtn(onClick: () {
              context.pop();
            }, child: const Icon(Icons.arrow_back_rounded)),

            SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Consumer<DetailPageProvider>(builder: (context, model, _) {
                  return
                      // TODO implement loading
                      model.meal == null
                          ? const SizedBox()
                          : Column(
                              children: [
                                // upper section
                                Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                                        child: Text(
                                          model.meal?.strMeal ?? "",
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.sizeOf(context).height / 2.6,
                                      // child: ColorFiltered(
                                      //   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                                      //   child: CachedNetworkImage(
                                      //     imageUrl: model.meal!.strMealThumb ?? "",
                                      //     placeholder: (context, url) => const Text("Loading pls wait"),
                                      //     imageBuilder: (context, imageProvider) => Container(
                                      //       decoration: BoxDecoration(
                                      //         image: DecorationImage(
                                      //           image: imageProvider,
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ].reversed.toList(),
                                ),
            
                                // info

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentContent.name.toCapitalize(),
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 30),
                                      ContentPage(current: currentContent),
                                    ],
                                  ),
                                )
                              ],
                            );
                }),
              ),
            ),
          ].reversed.toList(),
        ),
        floatingActionButton: FabButton(
          current: currentContent,
          items: [
            DetailFabItem(
              value: Content.instructions,
              onClick: () {
                setState(() {
                  currentContent = Content.instructions;
                });
              },
              child: const Icon(
                Icons.abc,
                color: Colors.white,
                size: 40,
              ),
            ),
            DetailFabItem(
              value: Content.ingredients,
              onClick: () {
                setState(() {
                  currentContent = Content.ingredients;
                });
              },
              child: const Text(
                ingredientIcon,
                style: TextStyle(fontSize: 25),
              ), 
            )
          ],
        ),
      ),
    );
  }
}


class DetailFabItem extends FabItem {
  final Content value;
  DetailFabItem({required this.value, required super.child, required super.onClick}) : super(value: value);
}
