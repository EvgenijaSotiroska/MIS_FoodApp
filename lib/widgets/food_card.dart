import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodCard extends StatefulWidget{
  final Food food;
  FoodCard({super.key, required this.food});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/recipe", arguments: widget.food);
      },
      child: Card(
        shape : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.red.shade800, width: 3),
        ),
        child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: Image.network(widget.food.img)),
            Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.food.name,
                style: TextStyle(fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            IconButton(
              icon: Icon(
                widget.food.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.food.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  widget.food.isFavorite = !widget.food.isFavorite;
                });
              },
            )
          ],
        )
          ]
      ),
        )
      )
    );
  }
}