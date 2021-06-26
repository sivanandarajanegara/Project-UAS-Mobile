import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:ruang_loak/Pembelian/pembelian_screen.dart';
import 'package:ruang_loak/produk.dart';
import 'package:http/http.dart' as http;
import 'package:ruang_loak/ui/home.dart';
import 'package:ruang_loak/ui/inputproduk.dart';
import 'auth/auth.dart';
import 'detail.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String url = "http://192.168.1.2:80/api/inputs"; //Ip cek pakai Ipconfig

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/futsal.jpg'),
          AssetImage('assets/images/sneaker.jpg'),
          AssetImage('assets/images/basket.jpg'),
          AssetImage('assets/images/converse.jpg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
      ),
    );
    return Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: new AppBar(
          backgroundColor: Colors.yellow.shade700,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(
              "KING SHOES",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PembelianScreen();
                  }));
                }),
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  "Sivananda",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                accountEmail: new Text(
                  "king@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "https://scontent-sin6-4.xx.fbcdn.net/v/t1.6435-1/c0.0.200.200a/p200x200/87043657_2559419930936483_2257547643863433216_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=7206a8&_nc_eui2=AeG_ALFdxeGQEQ0jhXso4y0anq1d0qrtUyaerV3Squ1TJryN9xbvg6-MB163pU9YnF59IIh1vUaBW85W5vi17DTN&_nc_ohc=erC-eD3QMgoAX8Bjjxa&_nc_ht=scontent-sin6-4.xx&tp=27&oh=235047646f7634679aba2b547847a7c6&oe=60DC9260"),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1487180144351-b8472da7d491?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1052&q=80"),
                        fit: BoxFit.cover)),
              ),
              new ListTile(
                leading: new Icon(Icons.person),
                title: new Text("Account"),
                onTap: () {},
              ),
              new ListTile(
                leading: new Icon(Icons.add_shopping_cart_sharp),
                title: new Text("Jual Barang"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InputScreen();
                  }));
                },
              ),
              new ListTile(
                leading: new Icon(Icons.info_outline),
                title: new Text("About"),
                onTap: () {},
              ),
              new ListTile(
                leading: new Icon(Icons.exit_to_app),
                title: new Text("Logout"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow.shade800,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FormInput()));
          },
        ),
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              //image carousel mulai
              imageCarousel,
              //padding widget

              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text('Produk Baru'),
              ),

              //grid view
              Container(height: 380, child: Produk()),
            ],
          ),
        ));
  }
}
