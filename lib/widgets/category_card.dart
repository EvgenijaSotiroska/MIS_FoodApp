
import 'package:flutter/material.dart';

import '../models/category_model.dart' show Category;

class CategoryCard extends StatelessWidget{
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       Navigator.pushNamed(context, "/details", arguments: category.name);
     },
     child: Card(
       margin: const EdgeInsets.only(bottom: 12),
       elevation: 3,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12),
       ),
       child: ListTile(
         contentPadding: const EdgeInsets.all(12),
         leading: ClipRRect(
           borderRadius: BorderRadius.circular(8),
           child: Image.network(
             category.img,
             width: 65,
             height: 65,
             fit: BoxFit.cover,
           ),
         ),
         title: Text(
           category.name,
           style: const TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 18,
           ),
         ),
         subtitle: Text(
           category.description,
           maxLines: 2,
           overflow: TextOverflow.ellipsis,
         ),
         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
       ),
     ),
   );
  }
}