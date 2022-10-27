class ProductModel {
  num? id;
  String? title;
  num? price;
  num?soluong=1;
  String? description;
  String? category;
  String? image;
  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image});
}
