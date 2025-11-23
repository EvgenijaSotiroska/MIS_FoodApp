import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labaratoriska2/widgets/recipe_image.dart';

import '../models/food_model.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';
import '../widgets/recipe_ingredients.dart';
import '../widgets/recipe_title.dart';

class RecipePage extends StatefulWidget {
  const RecipePage();

  @override
  State<RecipePage> createState() => _RecipeState();
}
class _RecipeState extends State<RecipePage>{
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  late Food food;
  late Recipe recipe;

  @override void didChangeDependencies() {
    super.didChangeDependencies();
    food = ModalRoute.of(context)!.settings.arguments as Food;
    _loadRecipe();
  }


  @override
  Widget build(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as Food;

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RecipeImage(image: recipe.img),
            const SizedBox(height: 20),
            RecipeTitle(name: recipe.name),
            const SizedBox(height: 20),
            DetailsGrid(ingredients: recipe.ingredients, instructions: recipe.instructions,),
          ],
        ),
      ),
    );
  }

  void _loadRecipe() async{
  final Recipe recipetmp = await _apiService.loadRecipe(id: food.id);

  setState(() {
    recipe = recipetmp;
    _isLoading = false;
  });
  }

}