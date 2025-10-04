import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/detail/detail_page.dart';
import 'package:recipes/pages/home/home_page.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/providers/home_page_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => DetailPageProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Recipes',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            outline: Colors.black.opaque(0.4),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: false,
            // titleTextStyle: TextStyle(
            //     fontWeight: FontWeight.w700,
            //     fontSize: 35,
            //     fontFamily: "Fearless",
            //   ),
            titleTextStyle: GoogleFonts.instrumentSerif(
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
          cardTheme: CardThemeData(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Colors.white,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
          textTheme: TextTheme(
            titleMedium: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            displayLarge: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
              fontFamily: "Fearless",
            ),
            bodyLarge: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            bodyMedium: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.5,
            ),
            labelMedium: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.black.opaque(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // home: const HomePage()
      ),
    );
  }
}

final router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomePage(), routes: const []),
  GoRoute(
    path: "/detail/:mealId",
    builder: (context, state) => DetailPage(mealId: state.pathParameters['mealId'] ?? ""),
  ),
]);
