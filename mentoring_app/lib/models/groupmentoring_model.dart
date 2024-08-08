class GroupMentoring {
  final int id;
  final String namaKelompok;
  final String namaMentor;
  final String noHpMentor;
  final String namaMente;
  final String jurusanMente;

  GroupMentoring({
    required this.id,
    required this.namaKelompok,
    required this.namaMentor,
    required this.noHpMentor,
    required this.namaMente,
    required this.jurusanMente,
  });

  factory GroupMentoring.fromJson(Map<String, dynamic> json) {
    return GroupMentoring(
      id: json['id'],
      namaKelompok: json['nama_kelompok'] ?? '',
      namaMentor: json['nama_mentor'] ?? '',
      noHpMentor: json['no_hpmentor'] ?? '',
      namaMente: json['nama_mente'] ?? '',
      jurusanMente: json['jurusan_mente'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_kelompok': namaKelompok,
      'nama_mentor': namaMentor,
      'no_hpmentor': noHpMentor,
      'nama_mente': namaMente,
      'jurusan_mente': jurusanMente,
    };
  }
}
