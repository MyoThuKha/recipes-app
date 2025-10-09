import 'package:basepack/basepack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/consts/emoji_icons.dart';
import 'package:recipes/models/meal_list_model.dart';


class MealItemAction {
  final String label;
  final String icon;
  final ValueChanged onClick;
  const MealItemAction({required this.label, required this.icon, required this.onClick});
}

class MealItem extends StatelessWidget {
  final Meal meal;
  final bool disableAction;
  final MealItemAction action;
  const MealItem({super.key, required this.meal, this.disableAction = false, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Uri(path: '/detail/${meal.idMeal}').toString());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    // Image
                    Card(
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: meal.strMealThumb ?? "",
                        // imageUrl: '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        color: Colors.black.withValues(alpha: 0.3),
                        colorBlendMode: BlendMode.darken,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Text(
                            EmojiIcons.pan,
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: ()=> action.onClick(meal),
                        child: CircleAvatar(
                          child: Image.asset(
                            action.icon,
                            width: 20,
                            semanticLabel: action.label,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meal.strMeal ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: context.textTheme.labelMedium,
                            height: 1.5,
                          ),
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 6,
                      //     vertical: 4,
                      //   ),
                      //   decoration: ShapeDecoration(
                      //     color: Colors.grey[200],
                      //     shape: const StadiumBorder(),
                      //   ),
                      //   child: Text(
                      //     "3 min",
                      //     style: GoogleFonts.inter(
                      //       fontSize: 11,
                      //       color: Colors.grey[600],
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Stack(
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //       color: Colors.deepPurple[400],
      //         borderRadius: BorderRadius.circular(30),
      //         // image: DecorationImage(
      //         //   image: NetworkImage(
      //         //     meal.strMealThumb ?? "",
      //         //   ),
      //         // ),
      //         image: DecorationImage(
      //           image: CachedNetworkImageProvider(
      //             meal.strMealThumb ?? "",
      //           ),
      //         ),
      //       ),
      //       alignment: Alignment.center,
      //     ),

      //     Positioned(
      //       top: 0,
      //       right: 0,
      //       bottom: 0,
      //       left: 0,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(30),
      //         ),
      //         alignment: Alignment.bottomCenter,
      //         child: ClipPath(
      //           clipper: const ShapeBorderClipper(shape:
      //           RoundedRectangleBorder(
      //             borderRadius: BorderRadius.vertical(
      //               bottom: Radius.circular(30),
      //               top: Radius.circular(10),
      //             )
      //           )),
      //           child: Container(
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //                 gradient: LinearGradient(
      //               begin: Alignment.bottomCenter,
      //               end: Alignment.topCenter,
      //               colors: [
      //                 Colors.black.withOpacity(0.9),
      //                 Colors.black.withOpacity(0.05),
      //               ],
      //             )),
      //             height: 80,
      //             alignment: Alignment.center,
      //             child: Text(
      //               meal.strMeal ?? "",
      //               textAlign: TextAlign.left,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: GoogleFonts.inter(
      //                 fontSize: 13,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

}
