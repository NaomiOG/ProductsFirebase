import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica4_2021/screens/list_products_screen.dart';
import 'package:practica4_2021/screens/new_product_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/newProduct': (BuildContext context) => NewProductScreen(),
      } ,
      home: ListProducts()
    );
  }
}