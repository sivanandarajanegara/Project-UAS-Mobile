import 'dart:convert';

import 'package:flutter/material.dart';
import 'editpenjualan.dart';
import 'inputproduk.dart';
import 'package:http/http.dart' as http;

class InputScreen extends StatefulWidget {
  const InputScreen({
    Key key,
  }) : super(key: key);
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://192.168.1.2:80/api/inputs/" + dataId; //Ip cek pakai Ipconfig
    var response = await http.delete(Uri.parse(url));

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade700,
          title: Text("Daftar Penjualan"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Container(
          color: Colors.lightGreen[100],
          child: Column(
            children: [
              FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 180,
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                                      padding: EdgeInsets.all(5),
                                      height: 120,
                                      width: 120,
                                      child: Image.network(
                                        snapshot.data['data'][index]['image_url'],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(snapshot.data['data'][index]['namabrg'],
                                                  style: TextStyle(
                                                      fontSize: 20.0, fontWeight: FontWeight.bold)),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child:
                                                  Text(snapshot.data['data'][index]['deskripsi']),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                    icon: Icon(Icons.edit),
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => EditPenjualan(
                                                                  input: snapshot.data['data']
                                                                      [index])));
                                                    }),
                                                Text("Rp. " +
                                                    snapshot.data['data'][index]['harga']
                                                        .toString()),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    deleteData(snapshot.data['data'][index]['id']
                                                            .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                              content: Text("Sudah di hapus")));
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Text('Error');
                    }
                  }),
            ],
          ),
        ));
  }
}
