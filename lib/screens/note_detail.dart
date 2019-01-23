import 'package:flutter/material.dart';

class NoteDetial extends StatefulWidget {
  @override
  _NoteDetialState createState() => _NoteDetialState();
}

class _NoteDetialState extends State<NoteDetial> {

  static var _priorities = ['High', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
 

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note')
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //First Element
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownStringItem){
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(), 
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectedByUser){
                  setState(() {
                    debugPrint('USer selected $valueSelectedByUser');
                  });
                },
              ),
            ),
            //Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value){
                  debugPrint('Something changed in Title text field');
                },
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),
            //Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value){
                  debugPrint('Something changed in Description text field');
                },
                decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),
            //Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                            debugPrint("Save Button clicked");                        
                        });
                      },
                    ),
                  ),
                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState(() {
                            debugPrint("Delete Button clicked");                        
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}