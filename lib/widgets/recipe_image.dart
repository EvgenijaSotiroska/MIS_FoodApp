import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labaratoriska2/models/recipe_model.dart';

class RecipeImage extends StatelessWidget{
  final String image;
  RecipeImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 5
          ),
        ],
      ),
      child: Padding(padding: EdgeInsets.all(5),
      child: Image.network(image, fit: BoxFit.contain),),
    );
  }


}