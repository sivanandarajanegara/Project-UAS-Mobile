import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruang_loak/ui/editpenjualan.dart';

class Promo extends StatefulWidget {
  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://192.168.1.2/api/inputs/" + dataId;
    var response = await http.delete(Uri.parse(url));

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Produk"),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data['data'].length,
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      elevation: 4,
                      child: Row(
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  snapshot.data['data'][index]['gambar'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Expanded(
                                child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['nama_sepatu'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  Text(
                                    "Ukuran : " + snapshot.data['data'][index]['ukuran_sepatu'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 15),
                                  ),
                                  Text(
                                    "Rp. " + snapshot.data['data'][index]['harga_sepatu'],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditPenjualan(
                                                        input: snapshot.data['data'][index])));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            deleteData(
                                                    snapshot.data['data'][index]['id'].toString())
                                                .then((value) {
                                              setState(() {});
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text("Data sudah berhasil di hapus")));
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
