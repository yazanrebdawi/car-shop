// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/add_Car/add_Car.dart';
import 'package:shopapp/models/car.dart';
import 'package:shopapp/my_widget/homepage_Card.dart';

import 'homepage_contoller.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Car> prodList = Provider.of<HomePageController>(context).productList;
    Provider.of<HomePageController>(context, listen: false).fetch();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Cars'),
      ),
      body: prodList.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  Provider.of<HomePageController>(context, listen: false)
                      .fetch(),
              child: ListView(
                children: prodList
                    .map((item) => Builder(
                        builder: (ctx) => detailsCard(item.id, item.title,
                            item.description, item.price, item.imageUrl, ctx)))
                    .toList(),
              ),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).canvasColor,
        ),
        child: FlatButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Cars'),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AddProduct())),
        ),
      ),
    );
  }
}
