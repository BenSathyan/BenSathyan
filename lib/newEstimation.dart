import 'package:flutter/material.dart';

class NewEstimation extends StatefulWidget {
  @override
  _NewEstimationState createState() => new _NewEstimationState();
}

class _NewEstimationState extends State<NewEstimation> {


  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        title: Text("Add Estimation",style: TextStyle(color:Colors.black),),
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
                  context, MaterialPageRoute(builder: (_) => NewEstimation()));
              // _projectListApiLoad();
            },
          ),
          /* : SizedBox(),*/
        ],
      ),
      body:  SafeArea(
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
                            style: TextStyle(color: Color(0xffe46b10),
                                fontSize: 30),
                          ),
                        ]),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, bottom: 0, top: 15),
                child: Container(
                  alignment: Alignment.center,
                  child: TextField(
                    //controller: _titleController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "Enter Task Title ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
