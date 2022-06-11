import 'dart:io';
import 'package:extimation_app/dashBoard.dart';
import 'package:extimation_app/upadematerial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'Choice.dart';
import 'MobileDataBase/databaseHealper.dart';
import 'addCategory.dart';

class EditMaterial {
  final cost;
  final materialName;
  final materialType;

  EditMaterial({this.cost, this.materialName, this.materialType});
}

class ViewMaterial extends StatefulWidget {
  @override
  _ViewMaterialState createState() => new _ViewMaterialState();
}

class _ViewMaterialState extends State<ViewMaterial> {
  var _isLoading = false, _isempty = false;
  List<Map> result;
  List materials = new List();

  List<Widget> _buildList(int keyIndex) {
    List<Widget> list = [];

    for (int i = 0; i < 1; i++) {
      list.add(new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 50,
            child: new RawMaterialButton(
              onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new UpdateMaterial(
                      editMaterial: EditMaterial(
                          cost: materials[keyIndex][DatabaseHelper.cost],
                          materialName: materials[keyIndex]
                              [DatabaseHelper.material],
                          materialType: materials[keyIndex]
                              [DatabaseHelper.materialCategory])),
                );
                Navigator.of(context).push(route);
              },
              child: new Icon(
                Icons.mode_edit,
                color: Colors.white,
                size: 15.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.orangeAccent,
              padding: const EdgeInsets.all(14.0),
            ),
          ),
          SizedBox(),
          RawMaterialButton(
            onPressed: () {
              deleteMaterials(materials[keyIndex][DatabaseHelper.materialId]);
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
    return new WillPopScope(
        onWillPop: exitapp,
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              "Materials",
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
                            style: TextStyle(
                                color: Color(0xffe46b10), fontSize: 30),
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
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.deepOrange),
                      ),
                    )
                  : Padding(
                      padding: new EdgeInsets.only(top: 10, left: 0, right: 0),
                      child: new Container(
                          height: MediaQuery.of(context).size.height * .80,
                          child: _isempty
                              ? Text('No Categry Added')
                              : new ListView.builder(
                                  itemCount: materials.length,
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
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    size: 36.0,
                                                  ),
                                                  title: new Padding(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            top: 12,
                                                            bottom: 12),
                                                    child: new Text(
                                                      materials[
                                                                  keyIndex][
                                                              DatabaseHelper
                                                                  .material] +
                                                          "\n\nType : " +
                                                          materials[
                                                                  keyIndex][
                                                              DatabaseHelper
                                                                  .materialCategory] +
                                                          '\nCost : ' +
                                                          materials[keyIndex][
                                                              DatabaseHelper
                                                                  .cost] +
                                                          ' Rs' +
                                                          '\nUnit  : Pr/' +
                                                          materials[keyIndex][
                                                              DatabaseHelper
                                                                  .unitperPrice],
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  children: <Widget>[
                                                    new Padding(
                                                        padding:
                                                            new EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 12),
                                                        child: new Column(
                                                            children:
                                                                _buildList(
                                                                    keyIndex))),
                                                  ]),
                                            ),
                                          ],
                                        ));
                                  }))),
            ],
          ),
        ));
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
    result = await db.query(DatabaseHelper.materialTable);
    result.forEach((row) => {
          materials.add(row),
          print(row),
        });
    if (materials.length == 0) {
      setState(() {
        _isLoading = false;
      });
    } else {
      print(materials.length);
      setState(() {
        _isLoading = false;
        _isempty = false;
      });
    }
  }

  Future<bool> exitapp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoard()));
  }

  Future<int> deleteMaterials(int id) async {
    Database db = await DatabaseHelper.instance.database;
    var result = await db.delete(DatabaseHelper.materialTable,
        where: '_id = ?', whereArgs: [id]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => ViewMaterial()));

    return result;
  }
}
