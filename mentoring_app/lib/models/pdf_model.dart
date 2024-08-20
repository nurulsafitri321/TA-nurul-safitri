class Pdf {
  final int id;
  final String? title;
  final String? pdfPath;

  Pdf({required this.id, this.title, this.pdfPath});

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return Pdf(
      id: json['id'] as int, // Pastikan konversi ke int
      title: json['title'] as String?,
      pdfPath: json['pdf_path'] as String?,
    );
  }
}