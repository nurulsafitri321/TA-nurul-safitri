enum StatusMentoring {
  lulus,
  tidakLulus,
}

enum UjianPraktek {
  solatWajib,
  solatJenazah,
}

class Mentee {
  final int id; // Tambahan id sebagai primary key
  final int idMentor;
  final String nama;
  final String nim;
  final String kelas;
  final String jurusan;
  final String prodi;
  final String jenisKelamin;
  final StatusMentoring statusMentoring;
  final List<bool> pertemuan;
  final UjianPraktek ujianPraktek;
  final bool ujianTulis;
  final double kehadiran;
  final double amalan;
  final double keaktifan;
  final double pengetahuan;
  final double nilaiAkhir;
  final String? catatan;

  Mentee({
    required this.id, // Id juga perlu diinisialisasi
    required this.idMentor,
    required this.nama,
    required this.nim,
    required this.kelas,
    required this.jurusan,
    required this.prodi,
    required this.jenisKelamin,
    required this.statusMentoring,
    required this.pertemuan,
    required this.ujianPraktek,
    required this.ujianTulis,
    required this.kehadiran,
    required this.amalan,
    required this.keaktifan,
    required this.pengetahuan,
    required this.nilaiAkhir,
    this.catatan,
  });

  factory Mentee.fromJson(Map<String, dynamic> json) {
    return Mentee(
      id: json['id'], // Parsing id dari JSON
      idMentor: json['id_mentor'],
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      kelas: json['kelas'] ?? '',
      jurusan: json['jurusan'] ?? '',
      prodi: json['prodi'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      statusMentoring: StatusMentoring.values.firstWhere(
        (e) => e.toString().split('.').last == json['status_mentoring'],
        orElse: () => StatusMentoring.tidakLulus,
      ),
      pertemuan: List.generate(10, (i) => json['pertemuan_${i + 1}'] == true),
      ujianPraktek: UjianPraktek.values.firstWhere(
        (e) => e.toString().split('.').last == json['ujian_praktek'],
        orElse: () => UjianPraktek.solatWajib,
      ),
      ujianTulis: json['ujian_tulis'] == true || json['ujian_tulis'] == 1,
      kehadiran: parsePercentage(json['kehadiran']),
      amalan: parsePercentage(json['amalan']),
      keaktifan: parsePercentage(json['keaktifan']),
      pengetahuan: parsePercentage(json['pengetahuan']),
      nilaiAkhir: parsePercentage(json['nilai_akhir']),
      catatan: json['catatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Menambahkan id ke dalam map JSON
      'id_mentor': idMentor,
      'nama': nama,
      'nim': nim,
      'kelas': kelas,
      'jurusan': jurusan,
      'prodi': prodi,
      'jenis_kelamin': jenisKelamin,
      'status_mentoring': statusMentoring.toString().split('.').last,
      'pertemuan_1': pertemuan[0] ? 1 : 0,
      'pertemuan_2': pertemuan[1] ? 1 : 0,
      'pertemuan_3': pertemuan[2] ? 1 : 0,
      'pertemuan_4': pertemuan[3] ? 1 : 0,
      'pertemuan_5': pertemuan[4] ? 1 : 0,
      'pertemuan_6': pertemuan[5] ? 1 : 0,
      'pertemuan_7': pertemuan[6] ? 1 : 0,
      'pertemuan_8': pertemuan[7] ? 1 : 0,
      'pertemuan_9': pertemuan[8] ? 1 : 0,
      'pertemuan_10': pertemuan[9] ? 1 : 0,
      'ujian_praktek': ujianPraktek.toString().split('.').last,
      'ujian_tulis': ujianTulis ? 1 : 0,
      'kehadiran': kehadiran,
      'amalan': amalan,
      'keaktifan': keaktifan,
      'pengetahuan': pengetahuan,
      'nilai_akhir': nilaiAkhir,
      'catatan': catatan,
    };
  }

  static double parsePercentage(dynamic value) {
    if (value is String) {
      value = value.replaceAll('%', '');
      return double.tryParse(value) ?? 0.0;
    } else if (value is num) {
      return value.toDouble();
    } else {
      return 0.0;
    }
  }
}
