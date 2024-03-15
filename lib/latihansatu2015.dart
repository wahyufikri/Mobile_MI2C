import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:project1/Manajemen.dart';
import 'package:project1/Tekom.dart';

class PageLatihan extends StatelessWidget {
  const PageLatihan({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //biar bisa scroll kalau widget panjang ke bawah
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'gambar/logo.png',
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Selamat Datang di Politeknik Negeri Padang',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Limau Manih,Padang,Sumbar'),
              
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 280,
                child: MaterialButton(
                  onPressed: () {
                    showToast('ini manajemen informatika',
                        context: context,
                        animation: StyledToastAnimation.slideFromBottomFade,
                        reverseAnimation: StyledToastAnimation.slideToBottomFade,
                        position: StyledToastPosition.bottom,
                        startOffset: Offset(1.0, 0.0),
                        reverseEndOffset: Offset(1.0, 0.0),
                        animDuration: Duration(seconds: 1),
                        duration: Duration(seconds: 4),
                        curve: Curves.linearToEaseOut,
                        reverseCurve: Curves.fastOutSlowIn);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PageManajemen() ));
                  },
                  child: Text('Manajemen Informatika',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  color: Colors.orange,
                  textColor: Colors.white,
                ),

              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 280,
                child:  MaterialButton(
                  onPressed: () {
                    showToast('ini teknik komputer',
                        context: context,
                        animation: StyledToastAnimation.slideFromTopFade,
                        reverseAnimation: StyledToastAnimation.slideToTopFade,
                        position: StyledToastPosition.top,
                        startOffset: Offset(1.0, 0.0),
                        reverseEndOffset: Offset(1.0, 0.0),
                        animDuration: Duration(seconds: 1),
                        duration: Duration(seconds: 4),
                        curve: Curves.linearToEaseOut,
                        reverseCurve: Curves.fastOutSlowIn);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PageTekom() ));
                  },
                  child: Text('Teknik Komputer',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  color: Colors.orange,
                  textColor: Colors.white,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
