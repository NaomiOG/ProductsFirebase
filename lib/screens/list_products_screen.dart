import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica4_2021/firebase/firebase_provider.dart';
import 'package:practica4_2021/screens/new_product_screen.dart';
import 'package:practica4_2021/views/card_product.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();

}

class _ListProductsState extends State<ListProducts>{
  FirebaseProvider providerFirebase;
  @override
  void initState(){
    super.initState();
    providerFirebase = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context){
     return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent[400],
          title: Text("Products List"),
          actions: [
            MaterialButton(
              child: Icon(Icons.add_circle,
              color: Colors.white ,),
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> NewProductScreen()));
              },
            )
          ],
        ),
        body: 
        StreamBuilder(
          stream: providerFirebase.getAllProducts(),//aquí va la subscripcion a Firebase
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document){
                  print("document"+document['name']);
                  return CardProduct(productDocument: document);
                }).toList()
              );
          }
        ),
      );     
  }
}