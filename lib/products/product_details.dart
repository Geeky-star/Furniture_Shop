import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/products/shopping_cart_screen.dart';

class ProjectDetails extends StatefulWidget {
  final String productImage;
  final int price;
  final String name;
  final String productId;

  ProjectDetails(
      {@required this.productImage, this.price, this.name, this.productId});
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  bool isFavorite = false;

  var icon = Icons.favorite_border;
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;

  Future _addToWishlist() {
    setState(() {
      if (isFavorite == true) {
        icon = Icons.favorite;
      } else {
        icon = Icons.favorite_border;
      }
    });

    return _usersRef
        .doc(_user.uid)
        .collection("Wishlist")
        .doc(widget.productId)
        .set({
      "product": widget.name,
      "price": widget.price,
      "image": widget.productImage
    });
  }

  Future _addToCart() {
    return _usersRef.doc(_user.uid).collection("Cart").doc(widget.name).set({
      "product": widget.name,
      "price": widget.price,
      "image": widget.productImage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
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
                    onTap: () async {
                      await _addToWishlist();
                      _showScaffold("Product added to Wishlist");
                      setState(() {
                        isFavorite = !isFavorite;
                        if (isFavorite == true) {
                          icon = Icons.favorite;
                        } else {
                          icon = Icons.favorite_border;
                        }
                      });
                    },
                    child: Container(
                        width: 50,
                        height: 40,
                        color: Colors.black,
                        child: Icon(
                          icon,
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
                    onPressed: () async {
                      await _addToCart();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ));
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
