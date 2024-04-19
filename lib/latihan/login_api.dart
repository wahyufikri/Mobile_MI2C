import 'package:project1/latihan/list_berita.dart';
import 'package:project1/page_navigation.dart';
import 'package:project1/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/model/model_login2.dart';
import 'package:project1/latihan/register_api.dart';


import 'navigation_bar.dart';

class PageLoginApi2 extends StatefulWidget {
  const PageLoginApi2({Key? key}) : super(key: key);

  @override
  State<PageLoginApi2> createState() => _PageLoginApi2State();
}

class _PageLoginApi2State extends State<PageLoginApi2> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNoHP = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
        Uri.parse('http://192.168.35.167/edukasi_server/login.php'),
        body: {
          "nama": txtNama.text,
          "username": txtUsername.text,
          "password": txtPassword.text,
          "email": txtEmail.text,
          "nohp": txtNoHP.text,
        },
      );

      ModelLogin data = modelLoginFromJson(response.body);

      if (data.value == 1) {
        setState(() {
          isLoading = false;
          session.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "");

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PageBottomNavigationBar2()),
                (route) => false,
          );
        });
      } else if (data.value == 0) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Login"),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  controller: txtUsername,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: txtPassword,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),



                SizedBox(height: 15),
                Center(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MaterialButton(
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        setState(() {
                          loginAccount();
                        });
                      }
                    },
                    child: Text('Login'),
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1, color: Colors.green),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageRegisterApi2()),
            );
          },
          child: Text('Anda belum punya account?? Silahkan Register'),
        ),
      ),
    );
  }
}



