class GuideContent {
  final String name, description;
  final int id;

  GuideContent({
    this.id,
    this.name,
    this.description,
  });

  GuideContent.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.description = data['description'];
}
