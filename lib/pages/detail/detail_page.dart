import 'package:basepack/basepack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes/consts/assets_icons.dart';
import 'package:recipes/extensions/str_extension.dart';
import 'package:recipes/pages/detail/widgets/detail_actions_widget.dart';
import 'package:recipes/pages/detail/widgets/ingredients_page.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/widgets/app_buttons.dart';
import 'package:recipes/widgets/background_widget.dart';
import 'package:recipes/widgets/fab_btn.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";
  final String mealId;
  const DetailPage({super.key, required this.mealId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  Future<void> callAPIRequest() async {
    final provider = context.read<DetailPageProvider>();
    if (widget.mealId == "random") {
      provider.getRandomMeal();
      return;
    }

    await provider.getMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<DetailPageProvider>(
              builder: (context, provider, _) {
                return SliverAppBar(
                  pinned: true,
                  collapsedHeight: 65,
                  leadingWidth: 70,
                  leading: BackBtn(
                    onClick: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                  expandedHeight: context.screenSize.height / 3.5,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 70),
                    title: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10,right: 5),
                        child: FittedBox(
                          child: Text(
                            provider.meal?.strMeal ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: context.theme.appBarTheme.titleTextStyle?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    collapseMode: CollapseMode.parallax,
                    background: CachedNetworkImage(
                      imageUrl: provider.meal?.strMealThumb ?? "",
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.4),
                      colorBlendMode: BlendMode.darken,
                      placeholder: (context, url) =>
                          Container(color: context.colorScheme.secondary),

                      errorWidget: (context, _, _) =>
                          Container(color: context.colorScheme.secondary),
                    ),
                  ),
                );
              },
            ),

            // Info
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Consumer<DetailPageProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: <Widget>[
                        const DetailActionsWidget(),

                        Text(
                          provider.currentContent.name.toCapitalize(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                                        
                        // ContentPage(current: currentContent),
                        AnimatedSwitcher(
                          layoutBuilder: (currentChild, previousChildren) {
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: [...previousChildren, ?currentChild],
                            );
                          },
                          duration: const Duration(milliseconds: 800),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: switch (provider.currentContent) {
                            Content.ingredients => Column(
                              children: provider.ingredients.map((e) => IngredientTile(ingredient: e)).toList(),
                            ),
                            _ => Text(
                              provider.meal?.strInstructions ?? "",
                              style: GoogleFonts.inter(
                                textStyle:
                                    context.theme.textTheme.bodyMedium,
                                color: context.colorScheme.onSurface.opaque(
                                  0.7,
                                ),
                              ),
                            ),
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 150)),
          ],
        ),

        floatingActionButton: Consumer<DetailPageProvider>(
          builder: (context, provider, _) {
            return FABButton(
              current: provider.currentContent,
              items: [
                FabItem(
                  value: Content.instructions,
                  onClick: onContentChanged,
                  child: const Icon(Icons.abc, color: Colors.white, size: 40),
                ),
                FabItem(
                  value: Content.ingredients,
                  onClick: onContentChanged,
                  child: Image.asset(
                    AssetsIcons.carrot,
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }


  void onContentChanged(Content content) {
    context.read<DetailPageProvider>().updateContent = content;
  }
}
