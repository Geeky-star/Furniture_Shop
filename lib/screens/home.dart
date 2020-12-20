import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/products/product_details.dart';
import 'package:furniture_app/products/shopping_cart_screen.dart';
import 'package:furniture_app/products/wishlist.dart';
import 'package:furniture_app/screens/login.dart';
import 'package:furniture_app/screens/profile_screen.dart';
import 'package:furniture_app/widgets/text.dart';

class HomePage extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  HomePage({this.selectedTab, this.tabPressed});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.black,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              hoverColor: Colors.red,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
                child: Text(
                  "Account",
                  style: Textstyle.normalheading,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              hoverColor: Colors.red,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ));
                },
                child: Text(
                  "Cart",
                  style: Textstyle.normalheading,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              hoverColor: Colors.red,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistScreen(),
                      ));
                },
                child: Text(
                  "Wishlist",
                  style: Textstyle.normalheading,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              hoverColor: Colors.red,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Text(
                  "LogOut",
                  style: Textstyle.normalheading,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Furniture in",
                style: Textstyle.heading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Unique Style",
                style: Textstyle.heading,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "We have wide range of Furniture",
                style: Textstyle.normalheading,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Chairs").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print("You clicked me");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetails(
                                      productImage: snapshot
                                          .data.documents[index]["image"],
                                      price: snapshot.data.documents[index]
                                          ["price"],
                                      name: snapshot.data.documents[index]
                                          ["name"],
                                    ),
                                  ));
                            },
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    snapshot.data.documents[index]["image"],
                                    height: 200,
                                    width: 200,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                snapshot.data.documents[index]
                                                    ["name"],
                                                style: Textstyle.normalheading),
                                          ),
                                          Text(
                                            "\$${snapshot.data.documents[index]["price"].toString()}",
                                            style: Textstyle.normalheading,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
