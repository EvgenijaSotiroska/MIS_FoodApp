import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labaratoriska2/models/category_model.dart';
import 'package:labaratoriska2/services/api_service.dart';
import 'package:labaratoriska2/widgets/food_grid.dart';

import '../models/food_model.dart';
import '../widgets/category_grid.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  const DetailsPage({super.key, required this.title});

  @override
  State<DetailsPage> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage>{
  late final List<Food> _foods;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  late String categoryName;
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = true;
  List<Food> _filteredFood = [];
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    categoryName = ModalRoute.of(context)!.settings.arguments as String;

    _loadFoods();
  }

  @override
  Widget build(BuildContext context){
    String categoryName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.red[800],
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? const Center(child : CircularProgressIndicator())
          : Column(
        children: [
          Padding(padding: EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search food by name...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value){
              setState(() {
                _searchQuery = value;
                _searchFoodByName(value);
              });
            },
          ),),
          Expanded(
            child: _filteredFood.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Food found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: FoodGrid(foods: _filteredFood),
            ),
          ),

        ],
      )
    );
  }

  void _loadFoods() async{
    final foodsList = await _apiService.loadFoodList(category: categoryName);

    setState(() {
      _foods = foodsList;
      _isLoading = false;
      _filteredFood = foodsList;
    });
  }

  Future<void> _searchFoodByName(String name) async {
    if (name.isEmpty) return;

    setState(() {
      isSearching = true;
    });

    final result = await _apiService.searchFoodByName(name);

    setState(() {
      isSearching = false;
      if (result != null) {
        _filteredFood = result;
      } else {
        _filteredFood = [];
      }
    });
  }

}