class Merchant {
  final String name,
      description,
      contact,
      category,
      address,
      businessHours,
      link,
      otherInformation,
      photo;
  final int id;
  final double lat, lng;

  Merchant({
    this.id,
    this.name,
    this.category,
    this.description,
    this.contact,
    this.address,
    this.lat,
    this.lng,
    this.businessHours,
    this.link,
    this.otherInformation,
    this.photo,
  });

  Merchant.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.category = data['category'],
        this.description = data['description'],
        this.contact = data['contact'],
        this.address = data['address'],
        this.lat = data['lat'],
        this.lng = data['lng'],
        this.businessHours = data['business_hours'],
        this.link = data['link'],
        this.otherInformation = data['other_information'],
        this.photo = data['photo'];
}
