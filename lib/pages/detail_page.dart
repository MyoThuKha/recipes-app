import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipes/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Detail",
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            ],
          ),
        ),
      ),

    );
  }
}