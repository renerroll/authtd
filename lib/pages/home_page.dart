import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import '../router.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
    // ignore: unused_field
    final AppRouter _appRouter = AppRouter();


  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Тест аутентифікації');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,   
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             CircleAvatar(backgroundColor: const Color.fromARGB(255, 82, 82, 82), radius: 150,child: Text(user?.email ?? 'User email'),),
            _userUid(),
            _signOutButton(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/posts');
              },
              child: const Text('перехід до постів'),),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Введіть свій логін'),)
          ],
        ),
      ),
    );
  }
}
