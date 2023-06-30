import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  class GetUserEmail extends StatelessWidget {
    final String documentId;

    GetUserEmail({required this.documentId});

    @override
    Widget build(BuildContext context) {

      // get data from firebase collection
      CollectionReference email = FirebaseFirestore.instance.collection('users');

      // display the data by email
      return FutureBuilder<DocumentSnapshot>(
        future: email.doc(documentId).get(),
        builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('Email: ${data['email']}');
        }
        return Text('Getting data...');
      }),
      );
    }
  }