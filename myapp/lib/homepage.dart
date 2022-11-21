import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/sharedPreference_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'others/drawer.dart';

class HomePage extends StatefulWidget {
  static const String path = "homepage";
  var user;

  HomePage({
    super.key,
    this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _discriptionController;
  @override
  void initState() {
    _titleController = TextEditingController();
    _discriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  late String docId;

  void toast(msg) {
    Fluttertoast.showToast(
      msg: "$msg",
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  getUsers() {
    return FirebaseFirestore.instance.collection('users').get();
  }

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  void addUsers() {
    if (_formKey.currentState!.validate()) {
      users.add({
        'title': _titleController.text,
        'discription': _discriptionController.text,
      }).then((value) {
        setState(() {});
        _titleController.clear();
        _discriptionController.clear();
        FocusScope.of(context).unfocus();
        toast("Successfully added");
      });
    }
  }

  void updateUsers() {
    if (_formKey.currentState!.validate()) {
      users.doc(docId).update({
        'title': _titleController.text,
        'discription': _discriptionController.text
      }).then((e) {
        setState(() {});
        _titleController.clear();
        _discriptionController.clear();
        FocusScope.of(context).unfocus();

        toast("Successfully updated");
      });
    }
  }

  void deleteUsers(id) {
    docId = id;

    users.doc(docId).delete().then((value) {
      setState(() {});
      toast("Successfully deleted");
    });
  }

  void editUsers(id, title, discription) {
    docId = id;
    _titleController.text = title;
    _discriptionController.text = discription;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 31, 30, 30),
    ));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 30, 30),
          title: Text("Home"),
          // leading: Icon(Icons.menu),
          centerTitle: true,
        ),
        drawer: drawer,
        body: Center(
            child: Column(
          children: [
            // Text("${widget.user}"),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Field must not be empty";
                          }
                        },
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                      ),
                      TextFormField(
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Field must not be empty";
                          }
                        },
                        controller: _discriptionController,
                        decoration: InputDecoration(
                          labelText: "Discription",
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: addUsers, child: Text("Add")),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: updateUsers,
                                  child: Text("Update"))),
                        ],
                      )
                    ],
                  )),
            ),
            FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          "Loading...",
                          style: TextStyle(fontFamily: "Raleway", fontSize: 15),
                        )
                      ],
                    ));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("Data not found"));
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    List<QueryDocumentSnapshot> user = snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: ClipOval(
                                child: Image.asset(
                              "assets/icons/icon1.png",
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            )),
                            title: Text(user[index]['title']),
                            subtitle: Text(user[index]['discription']),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        deleteUsers(user[index].id);
                                      },
                                      icon: Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        editUsers(
                                            user[index].id,
                                            user[index]['title'],
                                            user[index]['discription']);
                                      },
                                      icon: Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return Text("nothing");
                })
          ],
        )),
      ),
    );
  }
}
