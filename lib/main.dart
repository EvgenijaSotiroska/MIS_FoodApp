import 'package:flutter/material.dart';
import 'package:labaratoriska2/screens/details.dart';
import 'package:labaratoriska2/screens/favorites.dart';
import 'package:labaratoriska2/screens/home.dart';
import 'package:labaratoriska2/screens/random.dart';
import 'package:labaratoriska2/screens/recipe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

