import 'dart:io';
import 'package:extimation_app/newEstimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'Choice.dart';
import 'MobileDataBase/databaseHealper.dart';
import 'addCategory.dart';

class ViewCategory extends StatefulWidget {
  @override
  _ViewCategoryState createState() => new _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  var _isLoading = false, _isempty = false;
  List<Map> result;
  List category = new List();

  List<Widget> _buildList(int keyIndex) {
    List<Widget> list = [];

    for (int i = 0; i < 1; i++) {
      list.add(new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 10),
            child: Row(
              children: <Widget>[
                SizedBox(),
                RawMaterialButton(
                  onPressed: () {

                    Fluttertoast.showToast(
                        msg: 'You dont have permission to remove',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: new Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                  padding: const EdgeInsets.all(14.0),
                ),
                SizedBox(),
              ],
            ),
          ),

          /*new CircleAvatar(
                child: new Icon(Icons.verified_user),
                radius: 20.0,
              ),*/
        ],
      ));
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    _query();
  }

  Future<String> Doctorname() async {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Padding(
              padding: new EdgeInsets.only(top: 5, left: 40, right: 40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Es',
                    style: GoogleFonts.portLligatSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffe46b10),
                    ),
                    children: [
                      TextSpan(
                        text: 'tima',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      TextSpan(
                        text: 'tion',
                        style:
                            TextStyle(color: Color(0xffe46b10), fontSize: 30),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                )
              : Padding(
                  padding: new EdgeInsets.only(top: 10, left: 0, right: 0),
                  child: new Container(
                      height: MediaQuery.of(context).size.height * .80,
                      child: _isempty
                          ? Text('No Categry Added')
                          : new ListView.builder(
                              itemCount: category.length,
                              itemBuilder:
                                  (BuildContext context, int keyIndex) {
                                return new Padding(
                                    padding: new EdgeInsets.only(
                                        top: 12, left: 15, right: 15),
                                    child: Column(
                                      children: <Widget>[
                                        new Card(
                                          child: new ExpansionTile(
                                              leading: Icon(
                                                Icons.view_module,
                                                color: Colors.deepOrangeAccent,
                                                size: 36.0,
                                              ),
                                              title: new Padding(
                                                padding: new EdgeInsets.only(
                                                    top: 12, bottom: 12),
                                                child: new Text(
                                                  category[keyIndex][
                                                          DatabaseHelper
                                                              .category],
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              children: <Widget>[
                                                new Padding(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            top: 0, bottom: 12),
                                                    child: new Column(
                                                        children: _buildList(
                                                            keyIndex))),
                                              ]),
                                        ),
                                      ],
                                    ));
                              }))),
        ],
      ),
    );
  }

  // DataBase value Getting

  // ignore: missing_return

  _query() async {
    // get a reference to the database
    setState(() {
      _isLoading = true;
    });
    Database db = await DatabaseHelper.instance.database;

    // get all rows
    result = await db.query(DatabaseHelper.table);

    // print the results
    result.forEach((row) => category.add(row));
    // {_id: 1, name: Bob, age: 23}
    // {_id: 2, name: Mary, age: 32}
    // {_id: 3, name: Susan, age: 12}
    if (category.length == 0) {
      setState(() {
        _isLoading = false;
        _isempty = true;
      });
    } else {
      print(category.length);
      setState(() {
        _isLoading = false;
        _isempty = false;
      });
    }
  }
}
