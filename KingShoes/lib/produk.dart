import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'detail.dart';

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  var produk_list = [
    {
      "name": "Adidas",
      "picture": "assets/images/adds.jpg",
      "price": "35.000",
    },
    {
      "name": "Ventela",
      "picture": "assets/images/ventela.jpg",
      "price": "50.000",
    },
    {
      "name": "Puma",
      "picture": "assets/images/puma.png",
      "price": "29.000",
    },
    {
      "name": "Fila",
      "picture": "assets/images/fila.jpg",
      "price": "20.000",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              itemCount: snapshot.data['data'].length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Hero(
                      tag: snapshot.data['data'][index]['gambar'],
                      child: Material(
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                              //untuk memanggil detail produk
                              builder: (context) => new DetailProduk(
                                    detail_produk_name: snapshot.data['data'][index]['nama_sepatu'],
                                    detail_produk_new_price: snapshot.data['data'][index]
                                        ['harga_sepatu'],
                                    detail_produk_picture: snapshot.data['data'][index]['gambar'],
                                  ))),
                          child: GridTile(
                              footer: Container(
                                height: 60,
                                color: Colors.grey[200],
                                child: ListTile(
                                  leading: Text(
                                    snapshot.data['data'][index]['nama_sepatu'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  title: Text(
                                    "Rp. " + snapshot.data['data'][index]['harga_sepatu'],
                                    style:
                                        TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              child: Image.network(
                                snapshot.data['data'][index]['gambar'],
                                fit: BoxFit.cover, //grid gambar
                              )),
                        ),
                      )),
                );
              });
        }
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //untuk memanggil detail produk
                  builder: (context) => new DetailProduk(
                        detail_produk_name: prod_name,
                        detail_produk_new_price: prod_price,
                        detail_produk_picture: prod_picture,
                      ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "Rp. $prod_price",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover, //grid gambar
                  )),
            ),
          )),
    );
  }
}
