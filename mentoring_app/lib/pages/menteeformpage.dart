import 'package:flutter/material.dart';
import 'package:mentoring_app/models/mente_model.dart';
import 'package:mentoring_app/service/mente_service.dart';

class MenteeFormPage extends StatefulWidget {
  final Mentee? mentee;
  final int idMentor; // Ubah idMentor menjadi int

  const MenteeFormPage({Key? key, this.mentee, required this.idMentor}) : super(key: key);

  @override
  _MenteeFormPageState createState() => _MenteeFormPageState();
}

class _MenteeFormPageState extends State<MenteeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final MenteeService _menteeService = MenteeService();

  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _kelasController;
  late TextEditingController _jurusanController;
  late TextEditingController _prodiController;
  late TextEditingController _catatanController;
  late TextEditingController _idMentorController; // Tambahkan controller untuk idMentor

  late String _jenisKelamin;
  late String _statusMentoring;
  late List<bool> _pertemuan;
  late String _ujianPraktek;
  late bool _ujianTulis;
  late double _kehadiran;
  late double _amalan;
  late double _keaktifan;
  late double _pengetahuan;
  late double _nilaiAkhir;

  List<String> _jenisKelaminItems = ['Laki-laki', 'Perempuan'];
  List<String> _statusMentoringItems = ['lulus', 'tidakLulus'];
  List<String> _ujianPraktekItems = ['solat wajib', 'solat jenazah'];

  @override
void initState() {
  super.initState();

  _namaController = TextEditingController(text: widget.mentee?.nama ?? '');
  _nimController = TextEditingController(text: widget.mentee?.nim ?? '');
  _kelasController = TextEditingController(text: widget.mentee?.kelas ?? '');
  _jurusanController = TextEditingController(text: widget.mentee?.jurusan ?? '');
  _prodiController = TextEditingController(text: widget.mentee?.prodi ?? '');
  _catatanController = TextEditingController(text: widget.mentee?.catatan ?? '');
  _idMentorController = TextEditingController(text: widget.idMentor.toString());

  // Pastikan nilai dropdown valid
  _jenisKelamin = _jenisKelaminItems.contains(widget.mentee?.jenisKelamin)
      ? widget.mentee?.jenisKelamin ?? _jenisKelaminItems.first
      : _jenisKelaminItems.first;

  _statusMentoring = _statusMentoringItems.contains(widget.mentee?.statusMentoring.toString().split('.').last)
      ? widget.mentee?.statusMentoring.toString().split('.').last ?? _statusMentoringItems.first
      : _statusMentoringItems.first;

  _ujianPraktek = _ujianPraktekItems.contains(widget.mentee?.ujianPraktek.toString().split('.').last)
      ? widget.mentee?.ujianPraktek.toString().split('.').last ?? _ujianPraktekItems.first
      : _ujianPraktekItems.first;

  _pertemuan = widget.mentee?.pertemuan ?? List.generate(10, (_) => false);
  _ujianTulis = widget.mentee?.ujianTulis ?? false;
  _kehadiran = widget.mentee?.kehadiran ?? 0.0;
  _amalan = widget.mentee?.amalan ?? 0.0;
  _keaktifan = widget.mentee?.keaktifan ?? 0.0;
  _pengetahuan = widget.mentee?.pengetahuan ?? 0.0;
  _nilaiAkhir = widget.mentee?.nilaiAkhir ?? 0.0;
}

Widget _buildDropdown<T>(String label, List<T> items, T value, Function(T) onChanged) {
  return DropdownButtonFormField<T>(
    decoration: InputDecoration(labelText: label),
    value: items.contains(value) ? value : null,  // Validasi value agar pasti ada di items
    items: items.map((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()),
      );
    }).toList(),
    onChanged: (T? newValue) {
      if (newValue != null) {
        onChanged(newValue);
      }
    },
    validator: (value) {
      if (value == null) {
        return 'Field ini tidak boleh kosong';
      }
      return null;
    },
  );
}


  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    _jurusanController.dispose();
    _prodiController.dispose();
    _catatanController.dispose();
    _idMentorController.dispose(); // Pastikan untuk dispose idMentorController
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Simpan data setelah validasi
      Map<String, dynamic> data = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'kelas': _kelasController.text,
        'jurusan': _jurusanController.text,
        'prodi': _prodiController.text,
        'jenis_kelamin': _jenisKelamin,
        'status_mentoring': _statusMentoring,
        'ujian_praktek': _ujianPraktek,
        'ujian_tulis': _ujianTulis,
        'kehadiran': _kehadiran,
        'amalan': _amalan,
        'keaktifan': _keaktifan,
        'pengetahuan': _pengetahuan,
        'nilai_akhir': _nilaiAkhir,
        'catatan': _catatanController.text,
        'id_mentor': int.parse(_idMentorController.text), // Konversi dari String ke int
      };

      // Menambahkan data pertemuan
      for (int i = 0; i < _pertemuan.length; i++) {
        data['pertemuan_${i + 1}'] = _pertemuan[i];
      }

      try {
        Mentee savedMentee;
        if (widget.mentee == null) {
          // Membuat mentee baru
          savedMentee = await _menteeService.createMentee(data);
        } else {
          // Mengupdate mentee yang sudah ada menggunakan NIM
          await _menteeService.updateMentee(widget.mentee!.nim, data);
          savedMentee = Mentee.fromJson(data);
        }

        // Navigasi kembali ke layar sebelumnya dengan mentee yang disimpan
        Navigator.pop(context, savedMentee);
      } catch (e) {
        // Tampilkan pesan error jika penyimpanan gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal untuk menyimpan data mentee: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mentee == null ? 'Tambah Mentee' : 'Edit Mentee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Nama', _namaController),
              _buildTextField('NIM', _nimController),
              _buildTextField('Kelas', _kelasController),
              _buildTextField('Jurusan', _jurusanController),
              _buildTextField('Prodi', _prodiController),
              _buildDropdown<String>('Jenis Kelamin', _jenisKelaminItems, _jenisKelamin, (value) => setState(() => _jenisKelamin = value)),
              _buildDropdown<String>('Status Mentoring', _statusMentoringItems, _statusMentoring, (value) => setState(() => _statusMentoring = value)),
              _buildDropdown<String>('Ujian Praktek', _ujianPraktekItems, _ujianPraktek, (value) => setState(() => _ujianPraktek = value)),
              _buildCheckboxList('Pertemuan', _pertemuan),
              _buildSwitch('Ujian Tulis', _ujianTulis, (value) => setState(() => _ujianTulis = value)),
              _buildNumberField('Kehadiran (%)', _kehadiran.toString(), (value) => setState(() => _kehadiran = double.parse(value))),
              _buildNumberField('Amalan (%)', _amalan.toString(), (value) => setState(() => _amalan = double.parse(value))),
              _buildNumberField('Keaktifan (%)', _keaktifan.toString(), (value) => setState(() => _keaktifan = double.parse(value))),
              _buildNumberField('Pengetahuan (%)', _pengetahuan.toString(), (value) => setState(() => _pengetahuan = double.parse(value))),
              _buildNumberField('Nilai Akhir (%)', _nilaiAkhir.toString(), (value) => setState(() => _nilaiAkhir = double.parse(value))),
              _buildTextField('Catatan', _catatanController),
              _buildTextField('ID Mentor', _idMentorController), // Tampilkan ID Mentor
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.mentee == null ? 'Simpan' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildNumberField(String label, String initialValue, Function(String) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      onChanged: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Widget _buildDropdown<T>(String label, List<T> items, T value, Function(T) onChanged) {
  //   return DropdownButtonFormField<T>(
  //     decoration: InputDecoration(labelText: label),
  //     value: value,
  //     items: items.map((T item) {
  //       return DropdownMenuItem<T>(
  //         value: item,
  //         child: Text(item.toString()),
  //       );
  //     }).toList(),
  //     onChanged: (T? newValue) {
  //       if (newValue != null) {
  //         onChanged(newValue);
  //       }
  //     },
  //     validator: (value) {
  //       if (value == null) {
  //         return 'Field ini tidak boleh kosong';
  //       }
  //       return null;
  //     },
  //   );
  // }
  

  Widget _buildCheckboxList(String label, List<bool> values) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Column(
          children: List.generate(values.length, (index) {
            return CheckboxListTile(
              title: Text('Pertemuan ${index + 1}'),
              value: values[index],
              onChanged: (bool? value) {
                setState(() {
                  values[index] = value!;
                });
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
