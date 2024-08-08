class Mentee {
  final String nama;
  final String nim;
  final String kelas;
  final String jurusan;
  final String prodi;
  final String jenisKelamin;
  final String statusMentoring;
  final String kehadiran;
  final String amalan;
  final String keaktifan;
  final String pengetahuan;
  final String nilaiAkhir;

  Mentee({
    required this.nama,
    required this.nim,
    required this.kelas,
    required this.jurusan,
    required this.prodi,
    required this.jenisKelamin,
    required this.statusMentoring,
    required this.kehadiran,
    required this.amalan,
    required this.keaktifan,
    required this.pengetahuan,
    required this.nilaiAkhir,
  });

  factory Mentee.fromJson(Map<String, dynamic> json) {
    return Mentee(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      kelas: json['kelas'] ?? '',
      jurusan: json['jurusan'] ?? '',
      prodi: json['prodi'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      statusMentoring: json['status_mentoring'] ?? '',
      kehadiran: json['kehadiran'] ?? '',
      amalan: json['amalan'] ?? '',
      keaktifan: json['keaktifan'] ?? '',
      pengetahuan: json['pengetahuan'] ?? '',
      nilaiAkhir: json['nilai_akhir'] ?? '',
    );
  }
}
