class Offer {
  final String name, type, description, photo;
  final int id, points;

  Offer({
    this.id,
    this.name,
    this.type,
    this.points,
    this.description,
    this.photo,
  });

  Offer.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.type = data['type'],
        this.description = data['description'],
        this.points = int.parse(data['points'].toString()),
        this.photo = data['photo'];
}
