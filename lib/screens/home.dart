import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labaratoriska2/models/category_model.dart';
import 'package:labaratoriska2/services/api_service.dart';

import '../widgets/category_grid.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Permission: ${settings.authorizationStatus}");
  }


  @override
  void initState(){
    super.initState();
    _loadCategoires();
    requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground notification: ${message.notification?.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped notification");
      Navigator.pushNamed(context, "/random_recipe");
    });
  }

  @override
  Widget build(BuildContext context){
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
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: "Random Recipe",
            onPressed: () {
              Navigator.pushNamed(context, "/random_recipe"
              );
            },
          ),
        ],
      ),
      body: _isLoading
        ? const Center(child : CircularProgressIndicator())
          : Column(
        children: [
          Padding(padding: EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for a category...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            onChanged: (value){
              setState(() {
                _searchQuery = value;
              });
              _filterCategories(value);
            },
          ),
          ),
          Expanded(
              child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 64, color: Colors.grey,),
                      SizedBox(height: 16,),
                      const Text('No categories found.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                )
              )
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: CategoryGrid(categories: _filteredCategories),
              ),
          )
        ],
      )
    );
  }

  void _loadCategoires() async{
    final categoriesList = await _apiService.loadCategoryList();

    setState(() {
      _categories = categoriesList;
      _filteredCategories = categoriesList;
      _isLoading = false;
    });
  }

  void _filterCategories(String query){
    setState(() {
      _searchQuery = query;
      if(query.isEmpty){
        _filteredCategories = _categories;
      }else{
        _filteredCategories = _categories
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}