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

List<Offer> offers = [
  Offer(
    id: 1,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
  Offer(
    id: 2,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
  Offer(
    id: 3,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
  Offer(
    id: 4,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
  Offer(
    id: 5,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
  Offer(
    id: 6,
    name: "Office Code as dasd asdas asdasdsa",
    points: 234,
    description: dummyText,
    photo: "assets/images/placeholder2.jpg",
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
