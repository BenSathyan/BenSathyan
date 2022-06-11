import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import 'MobileDataBase/databaseHealper.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => new _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController categoryController = new TextEditingController();
  var repeated = false;

  _showSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: new Duration(seconds: 2),
      backgroundColor: Colors.orangeAccent,
    );
    //How to display Snackbar ?
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {}

  void addCategory() async {
    repeated = false;
    Database db = await DatabaseHelper.instance.database;
    //DatabaseHelper.deleteCategoryTable(db);
    if (categoryController.text.length != 0) {
      var table = DatabaseHelper.table,
          columnName = DatabaseHelper.category,
          category = categoryController.text;
      List<Map> result = await db
          .rawQuery('SELECT * FROM $table WHERE $columnName=?', ['$category']);
      result.forEach((row) => {
            if (row[columnName].length != 0)
              {
                repeated = true,
              }
          });
      if (!repeated) {
        await db
            .rawInsert('INSERT INTO $table ($columnName) VALUES("$category")');
        Fluttertoast.showToast(
            msg: 'Category Added Sucessfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AddCategory()));
      } else {
        _showSnackBar("category alredy added");
      }
    } else {
      _showSnackBar("Empty Field Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Text(
          "Add Category",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 23,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => AddCategory()));
              // _projectListApiLoad();
            },
          ),
          /* : SizedBox(),*/
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new Container(
                child: new Padding(
                  padding: new EdgeInsets.only(top: 5, left: 40, right: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Es',
                        style: TextStyle(
                            color: Color(0xffe46b10), fontSize: 30),                        children: [
                          TextSpan(
                            text: 'tima',
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          TextSpan(
                            text: 'tion',
                            style: TextStyle(
                                color: Color(0xffe46b10), fontSize: 30),
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, bottom: 0, top: 150),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          //Add th Hint text here.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xfffbb448),
                                  Color(0xfff7892b)
                                ])),
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        addCategory();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
