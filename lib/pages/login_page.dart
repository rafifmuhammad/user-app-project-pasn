import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_teori_app/pages/data_page.dart';
import 'package:project_teori_app/pages/main_page.dart';
import 'package:project_teori_app/pages/register_page.dart';
import 'package:project_teori_app/repository/user_repository.dart';
import 'package:project_teori_app/widgets/button.dart';
import 'package:project_teori_app/widgets/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  UserRepository userRepository = UserRepository();

  List<dynamic> users = [];
  String username = '';
  bool isLoading = false;
  bool isUser = false;
  bool isAdmin = false;

  getAllUserData() async {
    users = await userRepository.getAllUserData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/logo.png',
                            width: 80,
                            height: 80,
                          ),
                          const Text(
                            'Users App',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Text(
                          'Let\'s get started.',
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
                          'Tambah, ubah, lihat, dan hapus data\nPengguna untuk memudahkan pekerjaan Anda',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextInput(
                        controller: controllerUsername,
                        title: 'Username',
                        icon: Icons.person,
                      ),
                      TextInput(
                        controller: controllerPassword,
                        title: 'Password',
                        icon: Icons.lock,
                        obsecureText: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'Don\'t have an account yet? Sign Up',
                              style: TextStyle(
                                color: Colors.purple[800],
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Button(
                        title: 'Sign In',
                        onPressed: () {
                          isLoading = true;
                          setState(() {});

                          if (controllerUsername.text.isEmpty ||
                              controllerPassword.text.isEmpty) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Username dan Password tidak boleh kosong!',
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
                              for (var element in users) {
                                username = element.nama;
                                if (element.nama == controllerUsername.text &&
                                    element.password ==
                                        controllerPassword.text) {
                                  if (element.kategori ==
                                      'ADMIN'.toLowerCase()) {
                                    isAdmin = true;
                                  } else if (element.kategori ==
                                      'USER'.toLowerCase()) {
                                    isUser = true;
                                  }
                                  break;
                                }
                              }

                              if (isAdmin) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(
                                      username: username,
                                    ),
                                  ),
                                );
                                isLoading = false;
                                setState(() {});
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DataPage(
                                        isUser: isUser,
                                      );
                                    },
                                  ),
                                );
                                isLoading = false;
                                setState(() {});
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
