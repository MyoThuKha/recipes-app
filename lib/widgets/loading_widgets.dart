import 'package:flutter/material.dart';

class GridViewLoading extends StatelessWidget {
  const GridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Loading ...",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
