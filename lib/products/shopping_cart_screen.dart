import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  var name;

  CartPage({this.name});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var firebaseData = FirebaseDatabase.instance.reference();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  findData() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(_user.currentUser.uid)
        .collection("Cart")
        .snapshots();
  }

  rejectJob(String jobId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(_user.currentUser.uid)
        .collection("Cart")
        .doc(jobId)
        .delete();
  }

  deleteData() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(_user.currentUser.uid)
        .collection("Cart");

    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs.clear();
  }

  DatabaseReference _userRef =
      new FirebaseDatabase().reference().child("Users");

  FirebaseAuth _user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: "Roboto",
          ),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
      ),
      body: findData().length == null
          ? Text("Your Cart is Empty")
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('Cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Your Cart is Empty");
                        }
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => _buildListItem(
                                    context, snapshot.data.documents[index]),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              RaisedButton(
                                color: Colors.black,
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              )
                            ],
                          );
                        }
                        return Text("Cart is Empty");
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  document['image'],
                  width: 200,
                  height: 250,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Brand : " + document['product'],
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    Text(
                      "Price : " + document['price'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {
                        rejectJob(document.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ])),
      ],
    );
  }
}
