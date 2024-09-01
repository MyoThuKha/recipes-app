import 'package:flutter/material.dart';

class GridViewLoading extends StatelessWidget {
  const GridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5,color: Colors.black.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(300),
      ),
      padding: const EdgeInsets.all(5),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: CircularProgressIndicator.adaptive(backgroundColor: Colors.deepPurple,),

          ),
          SizedBox(width: 10),
          Text(
            "Please wait ...",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Fearless",
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
