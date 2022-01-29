// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use, avoid_unnecessary_containers, missing_required_param

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'add_Car_controler.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var isloding = false;
  var titleController = TextEditingController()..text = '';

  var descriptionController = TextEditingController()..text = '';

  var priceController = TextEditingController()..text = '';

  @override
  Widget build(BuildContext context) {
    String _image =
        Provider.of<AddProductController>(context, listen: true).url;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Add Cars'),
        ),
        body: isloding
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 215,
                      width: 215,
                      child: Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(child: Image.asset('asset/images/car3.png')),
                          Positioned(
                            right: 60,
                            bottom: 90,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                ),
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add_a_photo_outlined),
                                    onPressed: () {
                                      var ad = AlertDialog(
                                        title: Text('Choese Image From'),
                                        content: Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Builder(
                                                builder: (innerContext) =>
                                                    Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: ListTile(
                                                    leading: Icon(Icons.image),
                                                    title: Text('Gallery'),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AddProductController>()
                                                          .getImage(ImageSource
                                                              .gallery)
                                                          .then((pickedFile) =>
                                                              pickedFile);
                                                      Navigator.of(innerContext)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Builder(
                                                builder: (innerContext) =>
                                                    Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: ListTile(
                                                    leading: Icon(Icons.camera),
                                                    title: Text('Camera'),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AddProductController>()
                                                          .getImage(ImageSource
                                                              .camera)
                                                          .then((pickedFile) =>
                                                              pickedFile.path);
                                                      Navigator.of(innerContext)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      showDialog(
                                          context: context, builder: (_) => ad);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Title', hintText: 'Add Title'),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Add Description'),
                      controller: descriptionController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Prics', hintText: 'Add Prics'),
                      controller: priceController,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                    ),
                    Consumer<AddProductController>(
                        builder: (ctx, value, _) => RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.black,
                            child: Text('Add Car'),
                            onPressed: () async {
                              var price = double.tryParse(priceController.text);
                              if (titleController.text == "" ||
                                  descriptionController.text == "" ||
                                  priceController.text == "") {
                                Toast.show('Please enter all Fieles', ctx,
                                    duration: Toast.LENGTH_LONG);
                              } else if (_image == null) {
                                Toast.show('Please choese Image', ctx,
                                    duration: Toast.LENGTH_LONG);
                              } else {
                                setState(() {
                                  isloding = true;
                                });
                                {
                                  value
                                      .add(
                                    titleController.text,
                                    descriptionController.text,
                                    price,
                                  )
                                      .catchError((error) {
                                    showDialog(
                                      context: context,
                                      builder: (innerContext) => AlertDialog(
                                        title: Text('An error accurred'),
                                        content: Text('Something went wrong'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(),
                                              child: Text('Ok'))
                                        ],
                                      ),
                                    );
                                  }).then((_) {
                                    setState(() {
                                      isloding = false;
                                    });
                                  });
                                  value.deletImage();
                                  Navigator.pop(context);
                                }
                              }
                            }))
                  ],
                ),
              ),
      ),
    );
  }
}
