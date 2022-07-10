import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  String? nama;
  String? alamat;
  String? kategori;
  String? jenisKelamin;
  Function? onDelete;
  Function? onUpdate;
  bool? isUser;

  UserItem({
    Key? key,
    this.nama,
    this.alamat,
    this.kategori,
    this.jenisKelamin,
    this.onDelete,
    this.onUpdate,
    this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Image.asset(
                    jenisKelamin == 'pria' ||
                            jenisKelamin == 'laki-laki' ||
                            jenisKelamin == 'Pria' ||
                            jenisKelamin == 'Laki-laki' ||
                            jenisKelamin == 'Laki-Laki'
                        ? 'images/man.png'
                        : 'images/woman.png',
                    height: 80,
                    width: 80,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        jenisKelamin == 'pria' ||
                                jenisKelamin == 'laki-laki' ||
                                jenisKelamin == 'Pria' ||
                                jenisKelamin == 'Laki-laki' ||
                                jenisKelamin == 'Laki-Laki'
                            ? 'images/male.png'
                            : 'images/female.png',
                        height: 15,
                        width: 15,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.grey[350],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            alamat!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      !isUser!
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () => onUpdate!(),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => onDelete!(),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          : const Text(''),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  kategori!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
