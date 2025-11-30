import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labaratoriska2/services/api_service.dart';
import '../models/food_model.dart';
import '../widgets/food_grid.dart';

class FavoritesPage extends StatefulWidget{
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();

}

class _FavoritesPageState extends State<FavoritesPage>{
  bool _isLoading = true;
  late final List<Food> _favoriteFood;
  late final List<Food> _food;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _food = (ModalRoute.of(context)!.settings.arguments as List<Food>)
        .where((food) => food.isFavorite)
        .toList();
    setState(() {
      _favoriteFood = _food;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.red.shade400,
       title: const Text("Favorites", style: TextStyle(color: Colors.white),),
       centerTitle: true,
     ),
     body: _isLoading
       ? const Center(child: CircularProgressIndicator())
        : Column(
       children: [
         Expanded(child: _favoriteFood.isEmpty
         ? Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.search_off, size: 64, color: Colors.grey),
                 const SizedBox(height: 16),
                 const Text(
                   'Nothing to show in Favorite Food',
                   style: TextStyle(fontSize: 18, color: Colors.grey),
                 ),
               ],
             )
         )
         : Padding(
           padding: EdgeInsets.symmetric(horizontal: 12),
           child: FoodGrid(foods: _favoriteFood),
         ),),
       ],
     )
   );
  }

}