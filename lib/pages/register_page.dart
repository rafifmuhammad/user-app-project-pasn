import 'package:flutter/material.dart';
import 'package:project_teori_app/pages/data_page.dart';
import 'package:project_teori_app/pages/main_page.dart';
import 'package:project_teori_app/repository/user_repository.dart';
import 'package:project_teori_app/widgets/button.dart';
import 'package:project_teori_app/widgets/text_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String? nama;
  String? alamat;
  String? jenisKelamin;
  String kategori = 'user';
  String? password;
  bool isLoading = false;
  bool isUser = false;

  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Register Account',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.purple[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Text(
                          'Buat akun untuk melanjutkan\nlengkapi data diri Anda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
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
                        height: 16,
                      ),
                      Button(
                        title: 'Sign Up',
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
                              await userRepository.postUserData(
                                nama!,
                                alamat!,
                                jenisKelamin!,
                                kategori,
                                password!,
                              );

                              if (kategori == 'admin') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(
                                      username: nama,
                                    ),
                                  ),
                                );
                                isLoading = false;
                                setState(() {});
                              } else if (kategori == 'user') {
                                isUser = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DataPage(
                                      isUser: true,
                                    ),
                                  ),
                                );
                                isLoading = false;
                                setState(() {});
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Gagal melakukan registrasi!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                              isLoading = false;
                              setState(() {});
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
