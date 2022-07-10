import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_teori_app/pages/update_data_page.dart';
import 'package:project_teori_app/repository/user_repository.dart';
import 'package:project_teori_app/widgets/user_item.dart';

class DataPage extends StatefulWidget {
  bool isUser;
  DataPage({Key? key, this.isUser = false}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<dynamic> users = [];
  UserRepository userRepository = UserRepository();
  bool isLoading = true;

  loadData() async {
    users = await userRepository.getAllUserData();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(18),
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
                          'Daftar User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
              isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: users.map((e) {
                        return UserItem(
                          nama: e.nama,
                          alamat: e.alamat,
                          kategori: e.kategori,
                          jenisKelamin: e.jenisKelamin,
                          isUser: widget.isUser,
                          onDelete: () async {
                            try {
                              isLoading = true;

                              await userRepository
                                  .deleteUserData(e.id)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Data berhasil dihapus',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );

                                return loadData();
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                            setState(() {});
                          },
                          onUpdate: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UpdateDataPage(
                                    id: e.id,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
