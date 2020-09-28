class Guide {
  final String name,
      category,
      photo,
      description,
      recyclable,
      photoUpcycling,
      descriptionUpcycling;
  final int id;

  Guide({
    this.id,
    this.name,
    this.category,
    this.photo,
    this.description,
    this.recyclable,
    this.photoUpcycling,
    this.descriptionUpcycling,
  });

  Guide.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.category = data['category'],
        this.photo = data['photo'],
        this.description = data['description'],
        this.recyclable = data['recyclable'],
        this.photoUpcycling = data['photo_upcycling'],
        this.descriptionUpcycling = data['description_upcycling'];
}
