import 'package:flutter/material.dart';
import 'package:recipes/pages/detail/detail_page.dart';
import 'package:recipes/pages/detail/widgets/ingredients_page.dart';
import 'package:recipes/pages/detail/widgets/instruction_page.dart';

class ContentPage extends StatefulWidget {
  final Content current;
  const ContentPage({super.key, required this.current});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: widget.current == Content.instructions ? const InstructionPage() : const IngredientsPage(),
    );
  }
}
