import 'package:basepack/basepack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes/injector.dart';
import 'package:recipes/pages/detail/detail_page.dart';
import 'package:recipes/pages/home/home_page.dart';
import 'package:recipes/pages/landing/landing_page.dart';
import 'package:recipes/providers/collections_page_provider.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/providers/home_page_provider.dart';
import 'package:recipes/providers/landing_page_provider.dart';
import 'package:recipes/storage/perferences_manager.dart';
import 'package:recipes/storage/storage_manager.dart';
import 'package:recipes/storage/storage_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUpStorageService() async {
  try {
    final storagePath = await getIt<PathService>().getStoragePath();
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt<StorageManager>().init(storagePath);
    getIt<PerferencesManager>().init(sharedPreferences);
  } catch (e) {
    if (kDebugMode) {
      print('Warning: StorageService failed to initialize: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Future.wait([setUpStorageService(), GoogleFonts.pendingFonts()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LandingPageProvider(
            perferencesManager: getIt<PerferencesManager>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => CollectionsPageProvider()),
        ChangeNotifierProvider(create: (context) => DetailPageProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Recipes',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ).copyWith(outline: Colors.black.opaque(0.4)),
          tabBarTheme: const TabBarThemeData(
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: ShapeDecoration(
              color: Color(0xFFFBE9B5),
              shape: CircleBorder(),
            ),
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
              fontSize: 50,
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
            displayLarge: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
              fontFamily: "Fearless",
            ),
            // titleMedium: GoogleFonts.inter(
            //   fontWeight: FontWeight.bold,
            //   fontSize: 25,
            // ),
            titleMedium: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.black.opaque(0.7),
              fontSize: 25,
            ),
            bodyLarge: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            bodyMedium: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 2,

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

final router = GoRouter(
  initialLocation: '/',
  

  redirect: (context, state) {

    final perferencesManager = getIt<PerferencesManager>();
    final isFirstTime = perferencesManager.checkFirstTimeUser();
    if (isFirstTime) {
      return '/landing';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
      routes: const [],
       pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: "/landing",
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: "/detail/:mealId",
      builder: (context, state) =>
          DetailPage(mealId: state.pathParameters['mealId'] ?? ""),
    ),
]);
