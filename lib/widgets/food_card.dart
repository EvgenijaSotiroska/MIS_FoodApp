

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/food_model.dart';

class FoodCard extends StatelessWidget{
  final Food food;

  FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/recipe", arguments: food);
      },
      child: Card(
        shape : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.red.shade800, width: 3),
        ),
        child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: Image.network(food.img)),
            Divider(),
            Text(food.name, style: TextStyle(fontSize: 20), maxLines: 2, overflow: TextOverflow.ellipsis,),
          ],
        ),)
      )
    );
  }
}