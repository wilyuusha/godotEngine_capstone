import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/auth.dart';
import 'package:flutter_firebase/getDataFromFirebase/get_Email.dart';
import 'package:flutter_firebase/forms/update_data.dart';
import 'package:flutter_firebase/forms/create_data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
    getDocID();
  }

  Future<void> refreshData() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      docIDs = snapshot.docs.map((document) => document.reference.id).toList();
    });
  }


  Future<void> getDocID() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      docIDs = snapshot.docs.map((document) => document.reference.id).toList();
    });
  }

  Future<void> deleteDocument(String docID) async {
    await FirebaseFirestore.instance.collection('users').doc(docID).delete();
    setState(() {
      docIDs.remove(docID);
    });
  }

  Future<void> updateDocument(String docID) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDocumentPage(docID: docID), // Pass the docID to the UpdateDocumentPage
      ),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Row(
      children: [
        const Text('Firebase Activity 1 & 2'),
        const Spacer(),
        IconButton(
        icon: const Icon(Icons.refresh), 
        onPressed: () {
          refreshData();
        },
      ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateDataPage(),
            ),
          ).then((result) {
            if (result == true) {
              // Document created successfully, perform any desired actions
            }
          });
          },
        ),
      ],
    );
  }


  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Log Out'),
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
            _userUid(),
            _signOutButton(),
            Expanded(
              child: ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GetUserEmail(documentId: docIDs[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => updateDocument(docIDs[index]),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteDocument(docIDs[index]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
