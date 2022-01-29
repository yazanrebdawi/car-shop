// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, missing_required_param, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/homepage/homepage_contoller.dart';
import 'package:shopapp/models/car.dart';

class CarDetails extends StatelessWidget {
  final String id;

  const CarDetails(this.id);

  @override
  Widget build(BuildContext context) {
    List<Car> prodList = Provider.of<HomePageController>(context).productList;
    var filterItem =
        prodList.firstWhere((element) => element.id == id, orElse: () => null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: filterItem == null ? null : Text(filterItem.title),
      ),
      body: filterItem == null
          ? null
          : ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                buildContainer(filterItem.imageUrl, filterItem.description),
                const SizedBox(
                  height: 10,
                ),
                buildCard(
                    filterItem.title, filterItem.description, filterItem.price),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context, filterItem.description);
        },
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
    );
  }

  Container buildContainer(String image, String desc) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
            tag: id,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: Colors.black,
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const Divider(
              color: Colors.black,
            ),
            Text(
              price.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
