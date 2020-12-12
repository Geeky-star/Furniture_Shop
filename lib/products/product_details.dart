import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/products/shopping_cart_screen.dart';
import 'package:furniture_app/widgets/text.dart';

class ProjectDetails extends StatefulWidget {
  final String productImage;
  final int price;
  final String name;

  ProjectDetails({@required this.productImage, this.price, this.name});
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  bool isFavorite = false;
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;

  Future _addToCart() {
    return _usersRef.doc(_user.uid).collection("Cart").doc(widget.name).set({
      "product": widget.name,
      "price": widget.price,
      "image": widget.productImage
    });
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added To Cart"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _addToCart();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 50,
                    color: Colors.black,
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          Card(
            child: Image.network(widget.productImage),
          ),
          Text(
            widget.name,
            style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w800,
                fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Price: ",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                widget.price.toString() + " " + "USD",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Container(
                    width: 50,
                    height: 40,
                    color: Colors.black,
                    child: isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                color: Colors.black,
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
              ),
            ],
          )
        ],
      ),
    ));
  }
  /* final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Chairs");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product description"),
      ),
      body: FutureBuilder(
          future: _productsRef.doc(widget.productId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "error",
                style: TextStyle(fontSize: 30),
              ));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData = snapshot.data.data();
              print(snapshot.data.data());
              return Container(
                child: Image.network(documentData["image"]),
              );
            }
            return CircularProgressIndicator();
          }),
    );

  }
  */
}
