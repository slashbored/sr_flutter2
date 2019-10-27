import 'package:flutter/material.dart';
import 'localizationBloc.dart';
import 'generated/i18n.dart';
import 'package:flutter/cupertino.dart';

import 'roomSelection.dart';

class playerEditing extends StatefulWidget  {
  @override
  playerEditingState createState() => new playerEditingState();
}

class playerEditingState extends State<playerEditing>{
  static String playerName;
  static String playerSex;
  final TextEditingController nameTextfieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Spacer(
                  flex: 1
                ),
                Flexible(
                  child:  TextField(
                    controller: nameTextfieldController,
                  ),
                ),
                Spacer(
                  flex: 1
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputChip(
                  label: Text(S.of(context).sexMale),
                  onPressed: (){
                    setState(() {
                      playerSex = 'm';
                    });
                  },
                  backgroundColor: playerSex=='m'?getSexcolor(playerSex):Colors.grey,
                ),
                InputChip(
                  label: Text(S.of(context).sexFemale),
                  onPressed: (){
                    setState(() {
                      playerSex = 'f';
                    });
                  },
                  backgroundColor: playerSex=='f'?getSexcolor(playerSex):Colors.grey,
                ),
                InputChip(
                  label: Text(S.of(context).sexX),
                  onPressed: (){
                    setState(() {
                      playerSex = 'o';
                    });
                  },
                  backgroundColor: playerSex=='o'?getSexcolor(playerSex):Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          playerName = nameTextfieldController.text.toString();
          if  (playerName!=""&&playerSex!="") {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => roomSelection()));
          }
          else  {
           showDialog(
             context: context,
             builder: (BuildContext context) => CupertinoAlertDialog(
               content: Text(S.of(context).pleaseCompleteEntries)
             )
           );
          }
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black,
      ),
    );
  }

  Color getSexcolor(String sex) {
    Color colorplaceholder;
    switch  (sex) {
      case 'm':
        return Colors.blue;
        break;
      case 'f':
        return Colors.red;
        break;
      case 'o':
        return Colors.green;
        break;
    }
  }

}