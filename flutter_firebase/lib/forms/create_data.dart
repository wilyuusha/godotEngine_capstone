import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/forms/home_page.dart';

class CreateDataPage extends StatefulWidget {
  @override
  _CreateDataPageState createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {
  TextEditingController _textFieldController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_checkInput);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _checkInput() {
    String inputValue = _textFieldController.text;
    bool isValidEmail = EmailValidator.validate(inputValue);

    setState(() {
      _isButtonDisabled = inputValue.isEmpty || !isValidEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Data'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isButtonDisabled ? null : createDocument,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createDocument() async {
    try {
      String newValue = _textFieldController.text;

      await FirebaseFirestore.instance.collection('users').add({
        'email': newValue,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Document created successfully'),
        ),
      );
      

      Navigator.pop(context, true); // Navigate back to the previous screen with a success result
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to create document'),
        ),
      );
    }
  }
}
