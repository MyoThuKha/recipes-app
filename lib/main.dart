import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/detail_page.dart';
import 'package:recipes/pages/home_page.dart';
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
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true, fontFamily: "HelveticaNeue"),
        // home: const HomePage()
      ),
    );
  }
}

final router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomePage(), routes: []),
  GoRoute(
    path: "/detail/:mealId",
    builder: (context, state) => DetailPage(mealId: state.pathParameters['mealId'] ?? ""),
  ),
]);
