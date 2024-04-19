import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project1/page_login_api.dart';
import 'package:project1/utils/session_manager.dart';

import '../model/model_berita.dart';
import 'package:http/http.dart' as http;

import 'detail_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {

  String? userName;

  Future getDataSession() async{
    await Future.delayed(const Duration(seconds: 5),(){
     session.getSession().then((value) {
       print('data sesi .. ' + value.toString());
       userName = session.userName;
     });
    });
  }



  //method untuk get berita
  Future<List<Datum>?> getBerita() async {
    try {
      //berhasil
      http.Response response = await
      http.get(Uri.parse('http://192.168.221.167/beritaDb/getBerita.php'));

      return modelBeritaFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aplikasi berita'),
        backgroundColor: Colors.cyan,
        actions: [
          TextButton(onPressed: (){}, child: Text('Hi .. ${session.userName}')),
          //logout
          IconButton(onPressed: (){
            //clear session
            setState(() {
              session.clearSession();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
              => PageLoginApi()
              ),
                      (route) => false);
            });
          },
            icon: Icon(Icons.exit_to_app), tooltip: 'Logout',)
          ],
      ),
        body: FutureBuilder(
            future: getBerita(),
            builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Datum? data = snapshot.data?[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                          //   //ini untuk ke detail
                           Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (_) => DetailBerita(data)));
                           },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'http://192.168.221.167/beritaDb/gambar_berita/${data?.gambarBerita}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${data?.judul}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "${data?.isiBerita}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
            },
            ),
        );
    }
}