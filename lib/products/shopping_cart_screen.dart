import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/widgets/text.dart';
import 'package:furniture_app/widgets/firebase_services.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  DatabaseReference _userRef = new FirebaseDatabase().reference().child("Users");
  

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
      body: Padding(
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
                    return CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => _buildListItem(
                            context, snapshot.data.documents[index]),
                      ),
                    );
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {},
              )
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
                        onPressed: () async {
                          await _userRef
                              .child(FirebaseAuth.instance.currentUser.uid)
                              .remove()
                              .then((_) {
                            _showScaffold("Product removed from Cart");
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ]))
        ]);
  }
}
