import 'package:project1/latihan/detail_berita1.dart';
import 'package:project1/latihan/login_api.dart';
import 'package:project1/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../detail_berita2.dart';
import '../model/model_berita2.dart';

class PageListBerita2 extends StatefulWidget {
  const PageListBerita2({super.key});

  @override
  State<PageListBerita2> createState() => _PageListBerita2State();
}

class _PageListBerita2State extends State<PageListBerita2> {
  TextEditingController searchController = TextEditingController();
  List<Datum>? beritaList;
  String? userName;
  List<Datum>? filteredBeritaList; // List berita hasil filter

  @override
  void initState() {
    super.initState();
    session.getSession();
    getDataSession();
  }

  //untuk mendapatkan sesi
  Future getDataSession() async {
    await Future.delayed(const Duration(seconds: 1), () {
      session.getSession().then((value) {
        print('Data sesi .. ' + value.toString());
        userName = session.userName;
      });
    });
  }

  //method untuk get berita
  //async = syncronize
  Future<List<Datum>?> getBerita() async {
    try {
      // Berhasil
      http.Response response = await http.get(
        Uri.parse("http://192.168.35.167/edukasi_server/getBerita.php"),
      );

      // List<Datum>? fetchedBeritaList = modelBeritaLatihanFromJson(response.body).data;
      // setState(() {
      //   beritaList = fetchedBeritaList;
      //   filteredBeritaList = fetchedBeritaList; // Set filteredBeritaList ke nilai beritaList
      // });
      return modelBerita2FromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Berita Edukasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredBeritaList = beritaList
                      ?.where((element) =>
                  element.judul!
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                      element.berita!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  beritaList = snapshot.data;
                  if (filteredBeritaList == null) {
                    filteredBeritaList = beritaList;
                  }
                  return ListView.builder(
                    itemCount: filteredBeritaList!.length,
                    itemBuilder: (context, index) {
                      Datum data = filteredBeritaList![index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailBerita2(data)));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'http://192.168.35.167/edukasi_server/gambar_berita/${data.gambar}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '${data.judul}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    '${data.berita}',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  if (filteredBeritaList == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}