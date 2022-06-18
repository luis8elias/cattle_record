
class Animal{

  final int id;
  final String label;
  final int sex;
  final String age;
  final String category;
  final String annotations;


  Animal({
    required this.id,
    required this.label,
    required this.sex,
    required this.age,
    required this.category,
    required this.annotations
  });

  Map<String,dynamic> toJson() =>{
    "id"          : id,
    "label"       : label,
    "sex"         : sex,
    "age"         : age,
    "category"    : category,
    "annotations" : annotations
  };

  factory Animal.fromJson(Map<String,dynamic> json) => Animal(
    id          : json["id"],
    label       : json["label"],
    sex         : json["sex"],
    age         : json["age"],
    category    : json["category"],
    annotations : json["annotations"],
  );


  


}