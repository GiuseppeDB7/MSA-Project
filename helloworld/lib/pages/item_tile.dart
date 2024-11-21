import 'package:flutter/material.dart';
import 'package:helloworld/models/item.dart';

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  Item item;
  void Function()? onTap;
  ItemTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 10),
      child: Container(
        //margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            //Item pic
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(item.imagePath),
              ),
            
            //description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                item.description,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
      
            //price + details
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(
                      fontWeight:FontWeight.bold, 
                      fontSize:20,
                      )
                    ),
              
                    const SizedBox(height: 5),
              
                    Text(
                      item.price,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                //plus button
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                        ) 
                      ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      ),
                    ),
                ),
                ],
              ),
            ),
            //button to add to cart 
        ],)
      ),
    );
  }
}