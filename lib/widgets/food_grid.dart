import 'package:labaratoriska2/widgets/food_card.dart';

import '../models/food_model.dart';
import 'package:flutter/material.dart';

class FoodGrid extends StatefulWidget {
  final List<Food> foods;

  const FoodGrid({super.key, required this.foods});

  @override
  State<StatefulWidget> createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 200/244
      ),
      itemCount: widget.foods.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return FoodCard(food: widget.foods[index]);
      },
    );
  }
}
