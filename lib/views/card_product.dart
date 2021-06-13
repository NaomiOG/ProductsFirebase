import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica4_2021/firebase/firebase_provider.dart';

class CardProduct extends StatelessWidget{
  
  const CardProduct(
    {Key key, @required this.productDocument}
  ) : super(key: key);

  final DocumentSnapshot productDocument;
  

  @override
  Widget build(BuildContext context){
    FirebaseProvider providerFirebase=FirebaseProvider();
    print("name:"+productDocument[ 'name' ]);

    final card = Stack (
       alignment: Alignment .bottomCenter, 
       children: [ 
         Container ( 
           width: MediaQuery . of (context).size.width, 
           child: FadeInImage ( placeholder: AssetImage ( 'assets/loading.gif' ), 
           image: NetworkImage (productDocument["image"]), 
           fit: BoxFit .cover, fadeInDuration: Duration (milliseconds: 100 ), height: 230.0 , ), 
         ), 
         Opacity ( 
           opacity: .6 , 
           child: Container ( 
             height: 55.0 , 
             color: Colors .black, 
             child: Row ( 
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [ 
                 Text (
                   productDocument[ 'name' ], 
                   style: TextStyle (
                     color: Colors .white,
                     fontSize: 17.0,
                     ),
                     
                 ),
                 IconButton(
                   icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.red,
                      size: 24.0,
                   ),
                   onPressed: (){
                    providerFirebase.removeProduct(productDocument.id);
                  })
               ],
             ), 
           ), 
         ) 
       ],
    );

    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(0.0,5.0),
            blurRadius: 1.0
          )
        ]
      ),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: card,
      )
    );
  }
}