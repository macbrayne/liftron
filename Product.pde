class Product {
  int number;
  float sellPrice;
  PImage productImage;
  String name;
  int inStorage;
  int salesNumber;
  String imageLocation;

  Product(int number, float sellPrice, PImage productImage, String name, String imageLocation, int inStorage) {
    this.number = number;
    this.sellPrice = sellPrice;
    this.productImage = productImage;
    this.name = name;
    this.imageLocation = imageLocation;
    this.inStorage = inStorage;
    salesNumber = 0;
  }

  String toString() {
    return name + " " + number;
  }
}
