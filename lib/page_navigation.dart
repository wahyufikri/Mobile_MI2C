
import 'package:project1/page_passing_data.dart';
import 'package:flutter/material.dart';
import 'package:project1/page_column.dart';
import 'package:project1/page_search_list.dart';

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Navigation Bar'),
      ),

      //drawer untuk menu samping
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Muhammad Fauzan Mualana'),
                accountEmail: Text('muhammadfauzanmaulana24@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  radius: 55,
                  child: Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 65,
                  ),
                ),
              ),
              ListTile(
                //untuk di klik itemnya
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageRow()));
                },
                title: Text("Row Widget"),
              ),
              Divider(),
              ListTile(
                title: Text("Column Widget"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageColumn()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("Row & Column"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageColumnRow()));
                },
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageListHorizontal()));
                },
                title: Text("List Horizontal"),
              ),
              Divider(),
              ListTile(
                title: Text("Passing Data"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PagePassingData()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("Login"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageLogin()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("List"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageSearchList()));
                },
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: MaterialButton(
          onPressed: () {
            //back ke page sebelumnya
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}

class PageRow extends StatelessWidget {
  const PageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Row'),
      ),

      //Row, Column, List
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.add_business_sharp),
            Icon(Icons.person),
            Icon(
              Icons.add_call,
              color: Colors.orange,
              size: 64,
            ),
          ],
        ),
      ),
    );
  }
}
