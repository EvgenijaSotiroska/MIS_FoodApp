import 'package:flutter/material.dart';

class DetailsGrid extends StatelessWidget {
  final List<String> ingredients;
  final String instructions;

  const DetailsGrid({
    super.key,
    required this.ingredients,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    final half = (ingredients.length / 2).ceil();
    final col1 = ingredients.sublist(0, half);
    final col2 = ingredients.sublist(half);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ingredients Section
          const Text(
            "Ingredients:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: col1.map((ing) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Colors.deepOrange),
                          const SizedBox(width: 6),
                          Expanded(child: Text(ing, style: const TextStyle(fontSize: 16, height: 1.2))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: col2.map((ing) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Colors.deepOrange),
                          const SizedBox(width: 6),
                          Expanded(child: Text(ing, style: const TextStyle(fontSize: 16, height: 1.2))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Instructions Section
          const Text(
            "Instructions:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            instructions,
            style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
