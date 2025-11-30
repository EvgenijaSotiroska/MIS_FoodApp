class Food{
  int id;
  String name;
  String img;
  bool isFavorite;

  Food({required this.id, required this.name, required this.img, this.isFavorite = false});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'img' : img
  };

  Food.fromJson(Map<String, dynamic> data)
  : id = int.parse(data['idMeal']),
    img = data['strMealThumb'],
    name = data['strMeal'],
    isFavorite = data['isFavorite'] ?? false;

}