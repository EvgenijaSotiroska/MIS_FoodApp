class Food{
  int id;
  String name;
  String img;

  Food({required this.id, required this.name, required this.img});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'img' : img
  };

  Food.fromJson(Map<String, dynamic> data)
  : id = int.parse(data['idMeal']),
    img = data['strMealThumb'],
    name = data['strMeal'];
}