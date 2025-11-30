import 'package:flutter/material.dart';
import 'package:labaratoriska2/screens/details.dart';
import 'package:labaratoriska2/screens/favorites.dart';
import 'package:labaratoriska2/screens/home.dart';
import 'package:labaratoriska2/screens/random.dart';
import 'package:labaratoriska2/screens/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const MyHomePage(title: 'Food App'),
        "/details" : (context) => const DetailsPage(title: 'FoodApp'),
        "/recipe" : (context) => const RecipePage(),
        "/random_recipe" : (context) => const RandomPage(),
        "/favorite_recipes" : (context) => const FavoritesPage()
      },
    );
  }
}

