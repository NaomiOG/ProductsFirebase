class ProductDAO{
  String name;
  String description;
  String image;

  ProductDAO({this.name, this.description, this.image});

  Map<String, dynamic> toMap(){
    return {
      'name'       : name,
      'description': description,
      'image'      : image 
    };
  } 
}