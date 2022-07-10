class User {
  late final String id;
  late final String nama;
  late final String alamat;
  late final String jenisKelamin;
  late final String kategori;
  late final String password;

  User({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.jenisKelamin,
    required this.kategori,
    required this.password,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      jenisKelamin: json['jenis_kelamin'],
      kategori: json['kategori'],
      password: json['password'],
    );
  }
}
