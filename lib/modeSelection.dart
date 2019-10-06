import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'generated/i18n.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'playerSelector.dart';


class modeSelection extends StatefulWidget{
  @override
  modeSelectionState createState() => new modeSelectionState();
}

class modeSelectionState extends State<modeSelection>{

  final channel = IOWebSocketChannel.connect('wss://lucarybka.de/nodenode');
  final myController = TextEditingController();
  
  @override
  void initState()  {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                        child: new Center(
                          child: new Text(
                              S.of(context).modeSelector
                          ),
                        ),
                        flex: 1
                    ),
                    new Expanded(
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new TextField(
                              controller: myController,
                            ),
                            new Flexible(
                                child: new FloatingActionButton.extended(
                                    heroTag: 'FABOnline',
                                    label: Text("Online"),
                                    onPressed: () {
                                      channel.sink.add(myController.text);
                                      _showToastComingSoon(context);
                                    }
                                ),
                                flex: 1
                            ),
                            new Flexible(
                                child: new FloatingActionButton.extended(
                                    heroTag: 'FABOffline',
                                    label: Text("Offline"),
                                    onPressed: () {
                                    }
                                )
                            ),
                            new Spacer(
                                flex: 1
                            )
                          ],
                        ),
                        flex: 1
                    )
                  ]
              )
          );
        }
      )
    );
  }

  void _showToastComingSoon(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).comingSoon,
            textAlign: TextAlign.center,),
          duration: Duration(seconds: 3),
        )
    );
  }
}