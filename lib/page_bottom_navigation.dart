
import 'package:project1/page_column.dart';
import 'package:project1/page_custome_grid.dart';
import 'package:project1/page_form_register.dart';
import 'package:project1/page_passing_data.dart';
import 'package:flutter/material.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<PageBottomNavigationBar> createState() => _PageBottonNavigationBarState();
}

class _PageBottonNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: TabBarView(
        controller: tabController,
        children: const[
          PageFormRegister(),//PageFormRegister
          PageCustomeGrid(),
          PageColumnRow()
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const[
            Tab(
              text: 'Form Registrasi',
              icon: Icon(Icons.input),
            ),
            Tab(
              text: 'Costum Grid',
              icon: Icon(Icons.grid_3x3),
            ),
            Tab(
              text: 'Search List',
              icon: Icon(Icons.search),
            )

          ],
        ),
      ),
    );
  }
}
