class Promocode {
  final String name, code, qrCode;
  final int id;

  Promocode({
    this.id,
    this.name,
    this.code,
    this.qrCode,
  });

  Promocode.fromJson(Map<String, dynamic> data)
      : this.id = int.parse(data['id'].toString()),
        this.name = data['name'],
        this.code = data['code'],
        this.qrCode = data['qr_code'];
}
