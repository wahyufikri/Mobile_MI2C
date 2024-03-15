import 'package:flutter/material.dart';
import 'package:project1/latihansatu2015.dart';
class PageManajemen extends StatelessWidget { const PageManajemen({super.key});
@override
Widget build(BuildContext context)
{ return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.orange,
    title: Text(
      'Manajemen Informatika',
      style: TextStyle( color: Colors.white, fontSize: 20,
      ),
    ), centerTitle: true,
  ), body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20), // Beri jarak dari atas
      Center( // Tambahkan widget Center di sini
        child: Text(
          'Deskripsi dan Profil',
          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16,
          ),
        ),
      ),
      SizedBox(height: 15),
      Padding( padding: EdgeInsets.symmetric(horizontal: 20),
        // Beri padding horizontal
        child: Align( alignment: Alignment.center,
          child: Text( 'Program Studi D3 Manajemen Informatika didirikan pada tahun 2005, dan terakreditasi dengan peringkat '
              'B berdasarkan Surat Keputusan Badan Akreditasi nasional Perguruan Tinggi (BAN-PT) Departemen Pendidikan '
              'dan kebudayaan republik Indonesia Surat Keputusan Nomor :1196/SK/BAN- PT/Akred/Dpl-III/XII/2015 dengan '
              'nilai akreditasi 338. Arah kajian keilmuan dari program studi ini mencakup disiplin, proses, teknik dan '
              'alat bantu yang dibutuhkan dalam rekayasa perangkat lunak yang meliputi tahap perencanaan, pembangunan dan '
              'implementasi. Program studi D3 Manajemen Informatika yang merupakan kesatuan rencana belajar yang mengkaji, '
              'menerapkan, dan mengembangkan ilmu manajemen informatika yang melandasi rancang bangun sebuah sistem maupun '
              'aplikasi yang berdasarkan sistem informasi.',
            style: TextStyle( fontSize: 14, ),
          ),
        ),
      ),
      SizedBox(height: 100),
      Container(
         height: 40, //tinggi button
         width: double.infinity,
        child: Center( // Tambahkan widget Center di sini
          child:MaterialButton( onPressed: () { //code untuk pindah page
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageLatihan() )
            );
          },
            child: Text( 'Back',
              style: TextStyle( fontWeight: FontWeight.bold, fontSize: 15, ),
            ),
            color: Colors.orange,
            textColor: Colors.white,
          ),
        ),
      ),
    ],
  ),
),
);
}
}