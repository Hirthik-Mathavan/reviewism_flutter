class Book {
  int id;
  String name;

  Book({this.id, this.name});
  factory Book.fromJson(Map<String, dynamic> parsedJson) {
    return Book(
      id: parsedJson["id"],
      name: parsedJson["name"] as String,
    );
  }
}
