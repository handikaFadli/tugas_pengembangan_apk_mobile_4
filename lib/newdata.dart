import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:tugas_pertemuan_4/main.dart';
import 'package:http/http.dart' as http;

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Future<void> addData() async {
    if (title.text.isNotEmpty && content.text.isNotEmpty) {
      var url = Uri.parse(
          'http://10.128.132.25/restapi/create.php'); // Inserting API Calling
      final response = await http.post(url, body: {
        "title": title.text,
        "content": content.text,
      }); // parameter passed

      if (response.statusCode == 200) {
        // Jika data berhasil ditambahkan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil ditambahkan'),
          ),
        );

        // Kosongkan teks setelah berhasil menambahkan data
        title.clear();
        content.clear();

        // Kembali ke halaman sebelumnya
        Navigator.pop(context, true);
      } else {
        // Jika ada kesalahan dalam permintaan API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat menambahkan data'),
          ),
        );
      }
    } else {
      // Jika inputan kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi semua inputan tersebut'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add New Blog',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: title,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Title',
                hintText: 'Enter Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: content,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Content',
                hintText: 'Enter Content',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              child: Text(
                "Add Data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.deepPurple,
              onPressed: () {
                addData();
              },
              height: 45,
            ),
          )
        ],
      ),
    );
  }
}
