
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labaratoriska2/models/food_model.dart';
import '../models/category_model.dart';
import '../models/recipe_model.dart';

class ApiService{

  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";
  Future<List<Category>> loadCategoryList() async{
    List<Category> list = [];
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));

    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      List categoriesJson = data['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    }
    else return list;
  }

  Future<List<Food>> loadFoodList({required String category}) async{
    List<Food> foods = [];
    final response = await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      List foodsJson = data['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    }
    else return foods;
  }

  Future<Recipe> loadRecipe({required int id}) async{
    final response = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));

    final data = jsonDecode(response.body);
    final recipeJson= data['meals'][0];
    return Recipe.fromJson(recipeJson);
  }

  Future<Recipe> loadRandomRecipe() async{
    final response = await http.get(Uri.parse("$baseUrl/random.php"));

    final data = jsonDecode(response.body);
    final recipeJson= data['meals'][0];
    return Recipe.fromJson(recipeJson);
  }

  Future<List<Food>> searchFoodByName(String query) async{
    List<Food> foods = [];
    final response = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      List foodsJson = data['meals'];
      return foodsJson.map((json) => Food.fromJson(json)).toList();
    }
    else return foods;
  }
}