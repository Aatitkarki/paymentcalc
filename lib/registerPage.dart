import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterPageController registerPageController =
      Get.put(RegisterPageController());
  String location;
  String destination;

  List<String> places = [
    "BIRATNAGAR",
    "DHARAN",
    "KAKARVITTA",
    "JHAPA",
    "KATHMANDU",
  ];

  Widget build(BuildContext context) {
    final backDecorator = BoxDecoration(
        color: Color.fromRGBO(233, 230, 230, 1.0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(11, 149, 135, 1.0),
          width: 5,
        ));
    final frontDecorator = BoxDecoration(
        color: Color.fromRGBO(32, 59, 89, 1.0),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        border: Border.all(
          color: Color.fromRGBO(11, 149, 135, 1.0),
          width: 5,
        ));
    return Scaffold(
      body: ListView(children: <Widget>[
        Container(
            decoration: frontDecorator,
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Text(
                  "Vehicle Details",
                  style: TextStyle(
                    color: Color.fromRGBO(11, 149, 135, 1),
                    fontSize: 30.0,
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(right: 220.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            color: Color.fromRGBO(11, 149, 135, 1),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 300.0,
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: backDecorator,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(right: 130.0),
                        child: Text(
                          "Vehicle Number",
                          style: TextStyle(
                              color: Color.fromRGBO(11, 149, 135, 1),
                              fontSize: 20.0),
                        ),
                      ),
                      Container(
                        decoration: backDecorator,
                        width: 300.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Vehicle Number',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(right: 130.0),
                        child: Text(
                          "Contact Number",
                          style: TextStyle(
                              color: Color.fromRGBO(11, 149, 135, 1),
                              fontSize: 20.0),
                        ),
                      ),
                      Container(
                        decoration: backDecorator,
                        width: 300.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text("Routes",
                      style: TextStyle(
                        color: Color.fromRGBO(11, 149, 135, 1),
                        fontSize: 20.0,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(32, 59, 89, 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Color.fromRGBO(11, 149, 135, 1.0),
                        width: 2,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "From",
                          style: TextStyle(
                              color: Color.fromRGBO(11, 149, 135, 1),
                              fontSize: 20.0),
                        ),
                      ),
                      Container(
                          decoration: backDecorator,
                          child: Container(
                            width: 300,
                            child: Center(
                              child: DropdownButton<String>(
                                value: location,
                                hint: Text("Location"),
                                onChanged: (String value) {
                                  setState(() {
                                    location = value;
                                  });
                                },
                                style: TextStyle(
                                  color: Color.fromRGBO(32, 59, 89, 1),
                                  fontSize: 20.0,
                                ),
                                items: places.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "To",
                          style: TextStyle(
                              color: Color.fromRGBO(11, 149, 135, 1),
                              fontSize: 20.0),
                        ),
                      ),
                      Container(
                          decoration: backDecorator,
                          child: Container(
                            width: 300,
                            child: Center(
                              child: DropdownButton<String>(
                                value: destination,
                                hint: Text("Destination"),
                                onChanged: (String value) {
                                  setState(() {
                                    destination = value;
                                  });
                                },
                                style: TextStyle(
                                  color: Color.fromRGBO(32, 59, 89, 1),
                                  fontSize: 20.0,
                                ),
                                items: places.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Image",
                      style: TextStyle(
                        color: Color.fromRGBO(11, 149, 135, 1),
                        fontSize: 20.0,
                      ),
                    )),
                GetBuilder<RegisterPageController>(
                  builder: (_) {
                    return Container(
                      height: 900,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: _.selectImages,
                            child: Text(
                              "Select Images",
                            ),
                          ),
                          _.finalImages.length == 0
                              ? Container()
                              : Expanded(
                                  child: GridView.count(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    children: List.generate(
                                        _.finalImages.length, (index) {
                                      Asset asset = _.finalImages[index];
                                      return AssetThumb(
                                        asset: asset,
                                        width: 300,
                                        height: 300,
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )),
      ]),
    );
  }
}

class RegisterPageController extends GetxController {
  List<Asset> finalImages = List<Asset>();

  Future<void> selectImages() async {
    List<Asset> selectedImages = List<Asset>();
    try {
      selectedImages = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: finalImages,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
      finalImages = selectedImages;
      print("The length is as : ${selectedImages.length}");
      update();
    } on Exception catch (e) {
      print(e);
    }
  }
}
