class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? status;
  String? picUrl;

  Contact(
      {int? id,
      String? name,
      String? email,
      String? phone,
      String? status,
      String? picUrl});

  Contact.empty(
      [this.id, this.name, this.email, this.phone, this.status, this.picUrl]);

  static const NORMAL = "NORMAL";
  static const FAVORITO = "FAVORITO";
  static const BLOQUEADO = "BLOQUEADO";

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact.empty(json['id'], json['name'], json['email'], json['phone'],
        json['status'], json['image_url']);
  }
}
