import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _conEmail.text,
        password: _conPassword.text,
        );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _conEmail.text,
        password: _conPassword.text,
        );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Activity 1 &');
  }

  Widget _entryField(
    String title,
    TextEditingController con,
  ) {
    return TextField(
      controller: con,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }
  
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword, 
      child: Text(isLogin ? 'Login' : 'Register'),
      );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      }, 
      child: Text(isLogin ? 'Register' : 'Login Instead'),
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
          children: [
            _entryField('email', _conEmail),
            _entryField('password', _conPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}