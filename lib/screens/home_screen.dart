import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Types of Robots"),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 25, 181, 155),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'logout',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Disconnected..."),
                  ),
                );
                 FirebaseAuth.instance.signOut();
                } 
              ),
            ]),
        body: Column(children: [
           Padding(
            padding: const EdgeInsets.all(15),
            child: Row(children: [
              const Text("Hello, " , style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text(user.email!, style: const TextStyle(fontSize: 16 , color: Color.fromARGB(255, 25, 181, 155),fontWeight: FontWeight.bold),)
            ],)
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('robot').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(snapshot.data!.docs[index]['nom']),
                          ],
                        )),
                  ),
                );
              },
            ),
          )
        ]));
  }
}
