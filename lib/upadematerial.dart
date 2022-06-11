import 'package:extimation_app/viewMaterial.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'MobileDataBase/databaseHealper.dart';

class UpdateMaterial extends StatefulWidget {

  final EditMaterial editMaterial;

  const UpdateMaterial({Key key, this.editMaterial}) : super(key: key);
  @override
  _UpdateMaterialState createState() => new _UpdateMaterialState();
}

class _UpdateMaterialState extends State<UpdateMaterial> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController materialController = new TextEditingController();
  TextEditingController costController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();

  var repeated = false, _isLoading = false, _isEmpty = false;
  List<Map> result;
  List categorylList = new List();
  String selectedCategory, selectedunit;

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
  void initState() {
    super.initState();
    materialController.text=widget.editMaterial.materialName;
    typeController.text= widget.editMaterial.materialType;
    _query();
  }

  void addMaterial() async {

    Database db = await DatabaseHelper.instance.database;
    var newCost= costController.text,
        columnname=DatabaseHelper.material,
        tableName=DatabaseHelper.materialTable,
        materialName=widget.editMaterial.materialName,
        costColum = DatabaseHelper.cost;

    if(newCost.length != 0){
      await db.rawUpdate(''' UPDATE $tableName SET $costColum = ? WHERE $columnname = ? ''', ['$newCost','$materialName']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewMaterial()));

    }else{
      _showSnackBar("Enter New Cost");
    }
    // do the update and get the number of affected rows

    // show the results: print all rows in the db
    print(await db.query(DatabaseHelper.table));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Text(
          "Update Materials",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
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
                    right: 10, left: 10, bottom: 0, top: 100),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Material Name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        enabled:false,
                        controller: materialController,
                        decoration: InputDecoration(
                          //Add th Hint text here.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Material Type',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        enabled:false,
                        controller: typeController,
                        decoration: InputDecoration(
                          //Add th Hint text here.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cost per Unit (Rs)',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: costController,
                        decoration: InputDecoration(
                          //Add th Hint text here.
                          hintText: widget.editMaterial.cost,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                          'Update',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        addMaterial();
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

  _query() async {
    // get a reference to the database
    setState(() {
      _isLoading = true;
    });
    Database db = await DatabaseHelper.instance.database;

    // get all rows
    result = await db.query(DatabaseHelper.table);

    // get the mobile db results
    result.forEach((row) => categorylList.add(row));
    if (categorylList.length == 0) {
      setState(() {
        _isLoading = false;
        _isEmpty = true;
      });
    } else {
      print(categorylList.length);
      setState(() {
        _isLoading = false;
        _isEmpty = false;
      });
    }
  }
}
