import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionLatihanManager {
  int? value;
  String? idUser, userName, Nama, email, nohp;

  Future<void> saveSession(int val, String id, String username, String nama, String email, String nohp) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("value", val);
    await sharedPreferences.setString("id", id);
    await sharedPreferences.setString("username", username);
    await sharedPreferences.setString("nama", nama);
    await sharedPreferences.setString("email", email);
    await sharedPreferences.setString("nohp", nohp);
  }

  Future<void> getSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value = sharedPreferences.getInt("value");
    idUser = sharedPreferences.getString("id");
    userName = sharedPreferences.getString("username");
    Nama = sharedPreferences.getString("nama");
    email = sharedPreferences.getString("email");
    nohp = sharedPreferences.getString("nohp");
  }

  Future<void> clearSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}

class PageProfileUser extends StatefulWidget {
  const PageProfileUser({Key? key}) : super(key: key);

  @override
  State<PageProfileUser> createState() => _PageProfileUserState();
}

class _PageProfileUserState extends State<PageProfileUser> {
  late SessionLatihanManager session;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    session = SessionLatihanManager();
    getDataSession();
  }

  Future<void> getDataSession() async {
    await session.getSession();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 55,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${isLoading ? 'Loading...' : session.Nama ?? 'Data tidak tersedia'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              SizedBox(height: 5),
              ListTile(
                title: Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${isLoading ? 'Loading...' : session.userName ?? 'Data tidak tersedia'}',
                ),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${isLoading ? 'Loading...' : session.email ?? 'Data tidak tersedia'}',
                ),
                leading: Icon(Icons.email),
              ),
              ListTile(
                title: Text(
                  'NoHP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${isLoading ? 'Loading...' : session.nohp ?? 'Data tidak tersedia'}',
                ),
                leading: Icon(Icons.phone),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman edit profil ketika tombol "Edit Profile" ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageEditProfile(session: session),
                    ),
                  ).then((_) {
                    // Saat kembali dari halaman edit profil, perbarui tampilan profil
                    setState(() {
                      isLoading = true; // Set isLoading ke true untuk menampilkan "Loading..."
                    });
                    getDataSession(); // Panggil kembali getDataSession untuk memperbarui data profil
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageEditProfile extends StatefulWidget {
  final SessionLatihanManager session;

  const PageEditProfile({Key? key, required this.session}) : super(key: key);

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  late TextEditingController txtNama;
  late TextEditingController txtEmail;
  late TextEditingController txtNoHP;

  @override
  void initState() {
    super.initState();
    txtNama = TextEditingController(text: widget.session.Nama);
    txtEmail = TextEditingController(text: widget.session.email);
    txtNoHP = TextEditingController(text: widget.session.nohp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: txtNama,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txtNoHP,
              decoration: InputDecoration(
                labelText: 'No. HP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan ke sesi dan kembali ke halaman profil
                widget.session.saveSession(
                  widget.session.value ?? 0,
                  widget.session.idUser ?? '',
                  widget.session.userName ?? '',
                  txtNama.text,
                  txtEmail.text,
                  txtNoHP.text,
                ).then((_) {
                  // Update data di database
                  updateDatabase(txtNama.text, txtEmail.text, txtNoHP.text);
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                });
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controller saat widget dihapus
    txtNama.dispose();
    txtEmail.dispose();
    txtNoHP.dispose();
    super.dispose();
  }

  void updateDatabase(String nama, String email, String nohp) {
    // Implementasi logika untuk mengupdate data di database
    // Misalnya, Anda dapat menggunakan package http untuk mengirim permintaan HTTP ke server
    // dan mengirim data yang diperbarui ke endpoint tertentu
    }
}
