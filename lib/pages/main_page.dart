import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_teori_app/pages/add_data_page.dart';
import 'package:project_teori_app/pages/data_page.dart';
import 'package:project_teori_app/widgets/data_diri.dart';

class MainPage extends StatelessWidget {
  String? username;
  MainPage({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
            decoration: BoxDecoration(
              color: Colors.purple[800],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: DataDiri(
              username: username,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPage(),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/lihat-data.png',
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Lihat Data',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDataPage(),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'images/tambah-user.png',
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tambah Data',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
