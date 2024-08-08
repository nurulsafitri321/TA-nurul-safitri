class Mentor {
  final int id;
  final int? userId;
  final String nama;
  final String nim;
  final String jurusan;
  final String prodi;
  final String jenisKelamin;
  final String noTelepon;
  final String divisi;
  final String alamat;

  Mentor({
    required this.id,
    this.userId, // Nullable
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.prodi,
    required this.jenisKelamin,
    required this.noTelepon,
    required this.divisi,
    required this.alamat,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['id'],
      userId: json['user_id'], // Nullable
      nama: json['nama'],
      nim: json['nim'],
      jurusan: json['jurusan'],
      prodi: json['prodi'],
      jenisKelamin: json['jenis_kelamin'],
      noTelepon: json['no_telepon'],
      divisi: json['divisi'],
      alamat: json['alamat'],
    );
  }
}
