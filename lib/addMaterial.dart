import 'package:extimation_app/dashBoard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'MobileDataBase/databaseHealper.dart';

class AddMaterial extends StatefulWidget {
  @override
  _AddMaterialState createState() => new _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController materialController = new TextEditingController();
  TextEditingController costController = new TextEditingController();

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
    _query();
  }

  void addMaterial() async {
    repeated = false;
    Database db = await DatabaseHelper.instance.database;
    //DatabaseHelper.deleteCategoryTable(db);
    if (materialController.text.length != 0 && selectedCategory.length != 0 && selectedunit.length != 0 && costController.text.length != 0) {
      var table = DatabaseHelper.materialTable,
          columnName = DatabaseHelper.material,
          category = DatabaseHelper.materialCategory,
          perCost = costController.text,
          cost = DatabaseHelper.cost,
          unitPerPrice = DatabaseHelper.unitperPrice,
          material = materialController.text;
      List<Map> result = await db
          .rawQuery('SELECT * FROM $table WHERE $columnName=?', ['$material']);
      result.forEach((row) => {
            // ignore: sdk_version_ui_as_code
            if (row[columnName].length != 0)
              {
                repeated = true,
              }
          });
      if (!repeated) {

        await db.rawInsert(
            'INSERT INTO $table ($category,$columnName, $cost,$unitPerPrice) VALUES("$selectedCategory", "$material","$perCost","$selectedunit")');


        Fluttertoast.showToast(
            msg: 'Material Added Sucessfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AddMaterial()));
      } else {
        _showSnackBar("Material alredy added");
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
          "Add Materials",
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
                  context, MaterialPageRoute(builder: (_) => AddMaterial()));
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
                            color: Color(0xffe46b10), fontSize: 30),
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
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          hint: Text("-- Select Category --"),
                          items: categorylList.map((item) {
                            return new DropdownMenuItem<String>(
                              value: item['category'].toString(),
                              child: new Text(item['category'].toString()),
                            );
                          }).toList(),
                          onChanged: (item) {
                            setState(() {
                              selectedCategory = item;
                            });
                          },
                          value: selectedCategory,
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          hint: Text("-- Select per/unit --"),
                          items: <String>[
                            "Piece",
                            "Kg",
                            "CFT",
                            "Bag",
                            "Sqft",
                            "Gms",
                            "Length",
                            "Liters",
                            "Pack",
                            "Packet",
                            "Nos"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              selectedunit = newValue;
                            });
                          },
                          value: selectedunit,
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cost per Unit',
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
                          'Add Material',
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
        Fluttertoast.showToast(
            msg: 'Category is empty please add Category first',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
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
