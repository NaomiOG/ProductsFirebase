import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica4_2021/models/products_dao.dart';

class FirebaseProvider{

  FirebaseFirestore _firestore;
  CollectionReference _productsCollection;

  FirebaseProvider(){
    _firestore = FirebaseFirestore.instance;
    _productsCollection = _firestore.collection('products');
  }
  //CRUD
   //insertar un producto en la coleccion de products
  Future<void> saveProduct(ProductDAO product){
    //le pasamos un mapa construido a partir de un objeto de tipo ProductDAO
    _productsCollection.add(product.toMap());
  }

  Future<void> updateProduct(ProductDAO product, String documentID){
    //le pasamos un mapa construido a partir de un objeto de tipo ProductDAO
    return _productsCollection.doc(documentID).update(product.toMap());
  }
  Future<void> removeProduct(String documentID){
    return _productsCollection.doc(documentID).delete();
  }
  //trae todos los productos
  Stream<QuerySnapshot> getAllProducts(){
    return _productsCollection.snapshots();
  }
}