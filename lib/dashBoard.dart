import 'dart:io';
import 'package:extimation_app/addMaterial.dart';
import 'package:extimation_app/newEstimation.dart';
import 'package:extimation_app/viewCategory.dart';
import 'package:extimation_app/viewMaterial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Choice.dart';
import 'addCategory.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => new _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {


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
                new RawMaterialButton(
                  onPressed: () {

                  },
                  child: Text('View',style: TextStyle(color: Colors.white),),

                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(14.0),
                ),
                SizedBox(
                  width: 50,
                  child: new RawMaterialButton(
                    onPressed: () {},
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

        ],
      )
      );
    }

    return list;
  }

  @override
  void initState() {
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
          title: Text("DashBoard", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return ConstantsUserDash.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Icon(
                                  choice == "Add Materials"
                                      ? Icons.add
                                      : choice == "Add Category"
                                      ?  Icons.category
                                      :choice == "View Category"? Icons.panorama_fish_eye:Icons.remove_red_eye,
                                  size: 20,
                                )),
                            Text(choice),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.black54),
                      ],
                    ),
                  );
                }).toList();
              },
            )

          ],
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
                          style: TextStyle(color: Color(0xffe46b10),
                              fontSize: 30),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Padding(
                padding: new EdgeInsets.only(top: 10, left: 0, right: 0),
                child: new Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .80,
                    child: new ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int keyIndex) {
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
                                            "Estimation " +
                                                keyIndex.toString() +
                                                "\n\n14-03-2020",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        children: <Widget>[

                                          new Padding(
                                              padding: new EdgeInsets.only(
                                                  top: 0, bottom: 12),
                                              child: new Column(
                                                  children: _buildList(
                                                      keyIndex))),
                                        ]),
                                  ),
                                ],
                              )
                          );
                        }))),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewEstimation()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange,
        ),
      ),
    );
  }

  Future<bool> exitapp() {
    showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Exit?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              // RepositoryServiceTodo.deleteLoginTodo();
              exit(0);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ;
  }
  void choiceAction(String choice) {
    if (choice == ConstantsUserDash.AddMaterial) {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddMaterial()));
    }else if(choice == ConstantsUserDash.AddCategory){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddCategory()));
    }else if(choice == ConstantsUserDash.ViewMaterial){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewMaterial()));
    }else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewCategory()));
    }
  }
}
