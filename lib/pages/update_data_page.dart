import 'package:flutter/material.dart';
import 'package:project_teori_app/repository/user_repository.dart';
import 'package:project_teori_app/widgets/button.dart';
import 'package:project_teori_app/widgets/text_input.dart';

class UpdateDataPage extends StatefulWidget {
  String? id;

  UpdateDataPage({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String? nama;
  String? alamat;
  String? jenisKelamin;
  String? kategori;
  String? password;
  bool isLoading = true;

  UserRepository userRepository = UserRepository();

  var user;

  loadSingleData() async {
    user = await userRepository.loadUserSingleData(widget.id!);

    controllerNama.text = user['nama'];
    controllerAlamat.text = user['alamat'];
    controllerPassword.text = user['password'];
    kategori = user['kategori'];
    jenisKelamin = user['jenis_kelamin'];

    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    loadSingleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.purple[800],
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const Flexible(
                            child: Center(
                              child: Text(
                                'Ubah Data Pengguna',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
              TextInput(
                controller: controllerNama,
                title: 'Nama',
                icon: Icons.person,
              ),
              TextInput(
                controller: controllerAlamat,
                title: 'Alamat',
                icon: Icons.maps_home_work_sharp,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'Pria',
                              groupValue: jenisKelamin,
                              onChanged: (String? value) {
                                setState(() {
                                  jenisKelamin = value;
                                });
                              },
                            ),
                            title: const Text('Pria'),
                          ),
                        ),
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'Wanita',
                              groupValue: jenisKelamin,
                              onChanged: (String? value) {
                                setState(() {
                                  jenisKelamin = value;
                                });
                              },
                            ),
                            title: const Text('Wanita'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'user',
                              child: Text('user'),
                            ),
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text('admin'),
                            ),
                          ],
                          value: kategori,
                          onChanged: (String? value) {
                            setState(() {
                              kategori = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextInput(
                controller: controllerPassword,
                title: 'Password',
                icon: Icons.lock,
                obsecureText: true,
              ),
              const SizedBox(
                height: 32,
              ),
              Button(
                onPressed: () async {
                  nama = controllerNama.text;
                  alamat = controllerAlamat.text;
                  password = controllerPassword.text;
                  isLoading = true;
                  setState(() {});

                  if (nama!.isEmpty ||
                      nama == null ||
                      alamat!.isEmpty ||
                      alamat == null ||
                      jenisKelamin!.isEmpty ||
                      jenisKelamin == null ||
                      kategori == null ||
                      kategori!.isEmpty ||
                      password!.isEmpty ||
                      password == null) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Text field tidak boleh kosong!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    isLoading = false;
                    setState(() {});
                  } else {
                    try {
                      await userRepository.postUserData(
                        nama!,
                        alamat!,
                        jenisKelamin!,
                        kategori!,
                        password!,
                      );

                      controllerNama.text = '';
                      controllerAlamat.text = '';
                      controllerPassword.text = '';

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Data Berhasil ditambahkan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      isLoading = false;
                      setState(() {});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Data Gagal ditambahkan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      isLoading = false;
                      setState(() {});
                    }
                  }
                },
                title: 'Ubah Data',
              )
            ],
          ),
        ),
      ),
    );
  }
}
