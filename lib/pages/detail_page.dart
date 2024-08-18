import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";
  final String mealId;
  const DetailPage({super.key, required this.mealId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    callAPIRequest();
    super.initState();
  }

  void callAPIRequest(){
    context.read<DetailPageProvider>().getMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Detail",
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DetailPageProvider>(
            builder: (context,model, _) {
              return Column(
                children: [
                  Image.network(model.meal?.strMealThumb ?? "")
                ],
              );
            }
          ),
        ),
      ),

    );
  }
}