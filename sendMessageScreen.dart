/* This file is part of a basic Flutter app I made for my venture, Preff. This specific
page implements a package that adds functionality to send sms messages. I included this
within our app to allow for sending individual sms messages to multiple people. This page
contains functions for sending messages as well as code to build the page within the app.
It also implements a custom Preff theme I made to ensure consistency among all pages
in the app.
-Dom Allen
*/


import 'package:flutter/material.dart';
//Package that adds functionality to send sms messages from a Flutter app
import 'package:flutter_sms/flutter_sms.dart';
//Custom theme with Preff colors, fonts, and other assets
import 'preffTheme.dart' as preffTheme;
import 'user.dart';

class SendMessagePage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() => new _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {

  static User _u = new User();
  int _txtIndex = 0;
  List<String> _nums = _u.getGroups()[0].getPhoneNumberList();

  //sends the message or prints if an error occurs
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await FlutterSms
            .sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
          print(onError);
        });
    print(_result);
  }

  _sendMessage() {
    print("SENDING MESSAGE");
    if(_txtIndex < _nums.length) {
      print(_u.getMessage().getTxt());
      print(_nums[_txtIndex]);
      _sendSMS(_u.getMessage().getTxt(), [_nums[_txtIndex]]);
      _txtIndex++;            
    } else {
      print("DONE SENDING MESSAGES");     
    }
            
  }
  //builds the page that sends sms messages
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: preffTheme.PreffColors.mainRed[300],
          title: new Text(
            'Send Your Message',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: preffTheme.PreffColors.offWhite,
              fontFamily: 'NunitoSans',
              fontSize: 30.0,
            )
          ),
        ),
      
        body: new Container(
          padding: EdgeInsets.all(36.0),
          //allows for scrolling
          child: new ListView(
            children: <Widget>[
              new DecoratedBox(
                decoration:BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Preston-Excited.png'),
                  )
                ),
              ),
              new FlatButton(
                child: Text(
                  'Send Message',
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 32.0,
                  ),
                  ),
                //styling for the button
                disabledColor: preffTheme.PreffColors.redOrange,
                color: preffTheme.PreffColors.redOrange,
                textColor: preffTheme.PreffColors.offWhite,
                disabledTextColor: preffTheme.PreffColors.offWhite,
                padding: const EdgeInsets.all(20.0),
                shape: const StadiumBorder(),
                //send the message when button is pressed
                onPressed: _sendMessage,
              )
            ]
          )
        )
      );
    }
}