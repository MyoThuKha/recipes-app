
import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:recipes/consts/assets_icons.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/widgets/snack_bar_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailActionsWidget extends StatefulWidget {
  const DetailActionsWidget({super.key});

  @override
  State<DetailActionsWidget> createState() => _DetailActionsWidgetState();
}

class _DetailActionsWidgetState extends State<DetailActionsWidget> {

  bool _showTags = false;

  void toggleTagsVisibility(bool val){
    setState(() {
      _showTags = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(
      builder: (context, provider, _) {
        if (provider.meal == null) return const SizedBox();
        return SizedBox(
          height: 100,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _showTags
                ? TagsLists(toggleTagsVisibility: toggleTagsVisibility)
                : MainActionsGroup(toggleTagsVisibility: toggleTagsVisibility),
          ),
        );
      },
    );
  }


}


// MARK: UI of the single Action
class ActionWidget extends StatelessWidget {
  final Widget child;
  const ActionWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      margin: const .only(right: 8),
      padding: const .symmetric(horizontal: 20),
      alignment: .center,
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            width: 1,
            color: context.colorScheme.surface.opaque(0.6),
          ),
        ),
      ),
      child: child,
    );
  }
}


// MARK: MAIN ACTIONS
class MainActionsGroup extends StatelessWidget {
  final void Function(bool) toggleTagsVisibility;
  const MainActionsGroup({super.key, required this.toggleTagsVisibility});

  final iconsSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(
      builder: (context, provider, _) {
        return ListView(
          scrollDirection: .horizontal,
          children: [

            if (provider.tags.isNotEmpty)
              GestureDetector(
                onTap: () => toggleTagsVisibility(true),
                child: ActionWidget(
                  child: Image.asset(AssetsIcons.tag, width: iconsSize),
                ),
              ),

            TapAnimate(
              onClick: () => addToCollection(context),
              child: ActionWidget(
                child: Image.asset(AssetsIcons.fridge, width: iconsSize),
              ),
            ),


            if (provider.meal?.strYoutube?.isNotEmpty ?? false)
              TapAnimate(
                onClick: () => openYouTube(provider.meal?.strYoutube ?? ""),
                child: ActionWidget(
                  child: Image.asset(AssetsIcons.television, width: iconsSize),
                ),
              ),


          ],
        );
      },
    );
  }

  void openYouTube(String url) async {
    final success = await launchUrlString(url);

    if (!success) {
      // copy url to the clipboard
      await Clipboard.setData(ClipboardData(text: url));
    }
  }

  void addToCollection(BuildContext context) async {
    showSnackBarWidget(context: context, message: "Adding...");

    final result = await context.read<DetailPageProvider>().addToCollection();

    if (!context.mounted) return;
    showSnackBarWidget(context: context, message: result.message);
  }
}




// MARK: TAGS LISTS
class TagsLists extends StatelessWidget {
  final ValueChanged<bool> toggleTagsVisibility;
  const TagsLists({super.key, required this.toggleTagsVisibility});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(
      builder: (context, provider, _) {
        return ListView(
          scrollDirection: .horizontal,
          children:
              [
                    GestureDetector(
                      onTap: () => toggleTagsVisibility(false),
                      child: ActionWidget(
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),

                    ...List.generate(
                      provider.tags.length,
                      (index) => ActionWidget(
                        child: Text(
                          provider.tags[index],
                          style: TextStyle(
                            color: context.colorScheme.tertiary,
                            fontSize: 12,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ),
                  ]
                  .animate(interval: const Duration(milliseconds: 200))
                  .scale(duration: const Duration(milliseconds: 400)),
        );
      },
    );
  }
}
