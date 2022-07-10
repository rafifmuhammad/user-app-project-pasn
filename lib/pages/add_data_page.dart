import 'package:flutter/material.dart';
import 'package:project_teori_app/repository/user_repository.dart';
import 'package:project_teori_app/widgets/button.dart';
import 'package:project_teori_app/widgets/text_input.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String? nama;
  String? alamat;
  String? jenisKelamin;
  String kategori = 'user';
  String? password;
  bool isLoading = false;

  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    Container(
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
                                'Tambah Pengguna Baru',
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
                            kategori.isEmpty ||
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
                            bool response = await userRepository.postUserData(
                              nama!,
                              alamat!,
                              jenisKelamin!,
                              kategori,
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
                      title: 'Tambah Data',
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
