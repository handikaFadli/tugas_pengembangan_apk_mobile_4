import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "Api Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

  void refreshData() {}
}

class _HomeState extends State<Home> {
  List list = [];

  Future<List> getData() async {
    var url = Uri.parse('http://10.128.132.25/restapi/list.php');
    //Api Link
    final response = await http.post(url);
    return jsonDecode(response.body);
  }

  Future<void> refreshData() async {
    final data = await getData();
    if (mounted) {
      setState(() {
        list = data;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("PHP MySQL CRUD - M Handika"),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        automaticallyImplyLeading: false, // icon "arrow left"
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => NewData(),
            ),
          );

          if (result == true) {
            refreshData();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting) {
            // pre loader
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (ss.hasError) {
            // Jika terjadi kesalahan, tampilkan pesan kesalahan.
            return Text('Error: ${ss.error}');
          } else if (ss.hasData) {
            // Jika data tersedia, tampilkan daftar item.
            return Items(list: ss.data!);
          } else {
            // Jika tidak ada data, tampilkan pesan lain atau widget kosong.
            return Text('No Data');
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 30), // Tambahkan margin atas ke ListView
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.deepPurple,
              width: 1.0,
            ),
          ),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                list[i]['title'].split(' ').map((String word) {
                  return word[0].toUpperCase() + word.substring(1);
                }).join(' '),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            subtitle: Text(
              list[i]['content'],
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: Colors.black,
                height: 1.3,
              ),
            ),
            leading: const Icon(
              Icons.text_snippet_outlined,
              size: 24,
              color: Colors.deepPurple,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            dense: true,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Details(list: list, index: i),
            )),
          ),
        );
      },
    );
  }
}
