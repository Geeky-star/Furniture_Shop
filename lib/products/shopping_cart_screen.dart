import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  CartScreen({this.productName, this.productImage, this.productPrice});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;

  Future _addToCart() {
    return _usersRef
        .doc(_user.uid)
        .collection("Cart")
        .doc(widget.productName)
        .set({
      "product": widget.productName,
      "price": widget.productPrice,
      "image": widget.productImage
    });
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added To Cart"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
    );
  }
}
