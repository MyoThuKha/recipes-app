import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/detail_page_provider.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.read<DetailPageProvider>().meal?.strInstructions ?? "",
      maxLines: null,
    );
  }
}
