import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica4_2021/firebase/firebase_provider.dart';
import 'package:practica4_2021/models/products_dao.dart';

class NewProductScreen extends StatefulWidget{
  NewProductScreen({Key key}) : super(key:key);
  @override
  _NewProductScreenState createState()=>_NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen>{
  final picker = ImagePicker();
  FirebaseProvider providerFirebase;
  final imagePicker = ImagePicker();
  File imageFile;

  @override
  void initState(){
    super.initState();
    providerFirebase = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {  
    TextEditingController txtNameController=TextEditingController();
    TextEditingController txtDescriptionController=TextEditingController();

    final Image imgFinal = (imageFile != null)
    ? Image.file(
      File(imageFile.path),
      width: 200.0,
      height: 400.0,
    )
    : Image.network("https://commercial.bunn.com/img/image-not-available.png", width: 200.0,
      height: 400.0,);

    final txtName=TextFormField(
    controller: txtNameController,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(
                    Icons.description,
                    color: Colors.cyan[300],
                    size: 24.0,
                    ),
      hintText: 'Product Name',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
      ),
    );
    final txtDescription=TextFormField(
        controller: txtDescriptionController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
                        Icons.description,
                        color: Colors.cyan[300],
                        size: 24.0,
                        ),
          hintText: 'Description',//placeholder
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
          contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
        ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent[400],
        title: Text("New Product"),
      ),
      body: Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: .2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://png.pngtree.com/thumb_back/fw800/background/20190223/ourmid/pngtree-watercolor-blue-background-paintedpastel-bluemint-greenthrough-image_69667.jpg'),
                fit: BoxFit.fill
              )
            ),
          ),
        ),
        
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  FloatingActionButton(  
                    child: Icon(Icons.image_search),
                    elevation: 5.0,
                    heroTag: null,
                    backgroundColor: Colors.cyan[200],
                    onPressed: () async {
                      await imagePicker.getImage(source: ImageSource.gallery).then((image) {
                        setState(() {
                          imageFile = File(image.path);
                        });
                      });
                    }
                  ),
                  imgFinal,
                  FloatingActionButton(
                    child: Icon(Icons.save),
                    heroTag: null,
                    elevation: 20.0,
                    backgroundColor: Colors.cyan[200],
                    onPressed: () async{
                        if(txtNameController.value.text!=null && txtDescriptionController.value.text!=null && imageFile != null ){
                        final _firebaseStorage = FirebaseStorage.instance;
                        var snapshot = await _firebaseStorage.ref()
                          .child("products")
                          .putFile(imageFile);
                        String imageURL = await snapshot.ref.getDownloadURL();
                        ProductDAO product = ProductDAO(
                          name: txtNameController.value.text,
                          description: txtDescriptionController.value.text,
                          image: imageURL.toString()
                        ); 
                        await providerFirebase.saveProduct(product);
                        Navigator.pop(context);
                      }
                    }
                  ),
              ],
            ),
            SizedBox(height:20,),//espacio entre los dos campos
            Card(
              color: Colors.cyan[50],
              elevation: 20.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,//se ajusta al contenido que tiene
                  children: [
                    txtName,
                    SizedBox(height:5,),//espacio entre los dos campos
                    txtDescription,
                  ],
                ),
              ),
          ),
          ],
        )    
      ],
    ),
  );
 
  }
}

  

