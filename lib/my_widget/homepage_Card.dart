// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/detailes_Car/carDetails.dart';
import 'package:shopapp/homepage/homepage_contoller.dart';

Widget detailsCard(id, title, desc, price, String imageUrl, ctx) {
  return FlatButton(
    onPressed: () {
      BuildContext context;
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (_) => CarDetails(id)),
      ).then((value) => Provider.of<HomePageController>(context, listen: false)
          .delete(value));
    },
    child: Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 10,
          color: Colors.orange[900],
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  width: 100,
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        desc,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                      '\$${price.toString()}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
