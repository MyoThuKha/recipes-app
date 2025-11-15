import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/landing/views/collections_landing_view.dart';
import 'package:recipes/pages/landing/views/details_landing_view.dart';
import 'package:recipes/pages/landing/views/done_landing_view.dart';
import 'package:recipes/pages/landing/views/greet_landing_view.dart';
import 'package:recipes/pages/landing/views/intro_landing_view.dart';
import 'package:recipes/pages/landing/views/video_landing_view.dart';
import 'package:recipes/providers/landing_page_provider.dart';
import 'package:recipes/widgets/background_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


const _pages = [
  GreetLandingView(),
  IntroLandingView(),
  CollectionsLandingView(),
  DetailsLandingView(),
  VideoLandingView(),
  DoneLandingView(),
];

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _pageController;
  bool isLastPage = false;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                if (value != _pages.length - 1 || isLastPage) {
                  return;
                }
                setState(() => isLastPage = true);
              },
              controller: _pageController,
              children: _pages,
            ),

            Align(
              alignment: .topRight,
              child:
                  BottomControlBar(
                    pageController: _pageController,
                    isLastPage: isLastPage,
                  ).animate().fadeIn(
                    delay: const Duration(milliseconds: 2000),
                    duration: const Duration(milliseconds: 800),
                  ),
            ),

            Align(
              alignment: .bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const .only(bottom: 8.0),
                  child: SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 4,
                      dotColor: context.colorScheme.primary.opaque(0.6),
                      activeDotColor: context.colorScheme.primary,
                    ),
                    controller: _pageController,
                    count: _pages.length,
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}

class BottomControlBar extends StatelessWidget {
  final PageController pageController;
  final bool isLastPage;
  const BottomControlBar({super.key, required this.pageController, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .symmetric(horizontal: 20),
        child: TextButton.icon(
          iconAlignment: .end,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: isLastPage
                ? const Icon(Icons.check_rounded, key: ValueKey("checked"))
                : const Icon(Icons.arrow_forward_rounded, key: ValueKey("arrow")),
          ),
          onPressed: () {
            if (isLastPage) return goToApp(context);
            nextPage(context);
          },
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              context.colorScheme.onPrimary,
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.dmSerifText(
                fontSize: 16,
                fontStyle: .italic,
                decoration: .underline,
                fontWeight: .w500,
              ),
            ),
          ),
          label: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: isLastPage
                ? const Text("Done", key: ValueKey("done"))
                : const Text("Skip", key: ValueKey("skip")),
          ),
        ),
      ),
    );
  }


  void nextPage(BuildContext context){
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }


  void goToApp(BuildContext context){
    context.read<LandingPageProvider>().toggleFirstTimeStatus();
    context.go('/');
  }
}
