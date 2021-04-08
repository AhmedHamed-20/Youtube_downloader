import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

StreamSubscription<DataConnectionStatus> listener;
var internetStatus = "Unknown";
var contentmessage = "Unknown";

void _showDialog(String title, String content, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Hi'),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ]);
      });
}

checkConnection(BuildContext context) async {
  listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case DataConnectionStatus.connected:
        internetStatus = "Connected to the Internet";
        contentmessage = "Connected to the Internet";
        break;
      case DataConnectionStatus.disconnected:
        internetStatus = "You are disconnected to the Internet. ";
        contentmessage = "Please check your internet connection";
        _showDialog(internetStatus, contentmessage, context);
        break;
    }
  });
  return await DataConnectionChecker().connectionStatus;
}
