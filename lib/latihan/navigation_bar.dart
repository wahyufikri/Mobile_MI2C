import 'package:flutter/material.dart';
import 'package:project1/latihan/list_berita.dart';
import 'package:project1/latihan/profil.dart';
//import 'package:mi2c_mobile/latihan/page_latihan/lat_list_pegawai.dart';
import '../../utils/session_manager.dart';
import 'package:project1/latihan/login_api.dart';

import 'list_pegawai.dart';
//import 'lat_profile.dart';

class PageBottomNavigationBar2 extends StatefulWidget {
  const PageBottomNavigationBar2({Key? key});

  @override
  State<PageBottomNavigationBar2> createState() =>
      _PageBottomNavigationBar2State();
}

class _PageBottomNavigationBar2State extends State<PageBottomNavigationBar2>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Color? containerColor;
  late SessionManager sessionManager;

  @override
  void initState() {
    super.initState();
    sessionManager = SessionManager();
    sessionManager.getSession();
    tabController = TabController(length: 3, vsync: this);
    containerColor = Colors.transparent;
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      containerColor = Colors.grey;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Berita'),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            TextButton(
                onPressed: () {}, child: Text('Welcome ${session.userName}')),
            //logout
            IconButton(
              onPressed: () {
                //clear session
                setState(() {
                  session.clearSession();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PageLoginApi2()),
                          (route) => false);
                });
              },
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Logout',
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              containerColor = Colors.grey;
            });
          },
          child: TabBarView(
            controller: tabController,
            children: [
              // content
              PageListBerita2(),
             PageKaryawan(),
             PageProfileUser()
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TabBar(
                controller: tabController,
                labelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: "Berita",
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    text: "Karyawan",
                    icon: Icon(Icons.person_add),
                  ),
                  Tab(
                    text: "Profil",
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}
