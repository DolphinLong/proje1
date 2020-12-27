import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'dart:async';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApphome(),
    );
  }
}

class MyApphome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyhomeState();
  }
}

class _MyhomeState extends State<MyApphome> {
  String lorem =
      "                                         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam suscipit posuere facilisis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vestibulum vitae elit dictum, ultrices felis vel, malesuada lectus. Integer ac ornare velit. Fusce euismod nisl id mi egestas, in laoreet risus commodo. Pellentesque luctus risus vel nibh auctor, ac congue nunc faucibus. Aenean aliquet justo vel risus cursus luctus. Phasellus vel leo viverra, aliquet odio in, rutrum mauris. Proin nisi orci, iaculis et enim et, elementum pretium mi. "
          .toLowerCase()
          .replaceAll(',', ' ')
          .replaceAll('.', ' ');

  int step = 0;
  int score = 0;
  int typerror;
  String username = "";

  void GameReset() {
    setState(() {
      score = 0;
      step = 0;
    });
  }

  void onlasttye() {
    this.typerror = DateTime.now().millisecondsSinceEpoch;
  }

  void onType(String value) {
    onlasttye();
    String kesme = lorem.trimLeft();
    setState(() {
      if (kesme.indexOf(value) != 0) {
        step = 2;
      } else {
        score = value.length;
      }
    });
  }

  void usernametype(String value) {
    setState(() {
      this.username = value.substring(0, 3);
    });
  }

  void onStartclick() {
    setState(() {
      onlasttye();
      step++;
    });

    var timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      int now = DateTime.now().millisecondsSinceEpoch;

      setState(() {
        if (step != 1) {
          timer.cancel();
        }
        if (step == 1 && now - typerror > 4000) step++;
      });
    });
  }

  @override
  Widget build(Object context) {
    var showWidget;
    if (step == 0)
      showWidget = <Widget>[
        Text("Oyuna başlamaya hazır mısın ?"),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onChanged: usernametype,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Adını Yaz Oyuncu',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: RaisedButton(
            child: Text("BAŞLA !"),
            onPressed: onStartclick,
          ),
        ),
      ];
    else if (step == 1)
      showWidget = <Widget>[
        Text("Puanınız:  $score"),
        new Container(
            height: 40,
            child: Marquee(
              text: lorem,
              style: TextStyle(fontSize: 24, letterSpacing: 2),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 125,
              startPadding: 0,
              accelerationDuration: Duration(seconds: 25),
              accelerationCurve: Curves.ease,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 32),
          child: TextField(
            autofocus: true,
            onChanged: onType,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Yaz Bakalım',
            ),
          ),
        ),
      ];
    else
      showWidget = <Widget>[
        Text("Game Over.....Scorun: $score"),
        RaisedButton(
          child: Text("Yeniden Dene"),
          onPressed: GameReset,
        )
      ];

    return Scaffold(
        appBar: AppBar(
          title: Text("                      Hızlı Parmak"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: showWidget,
        )));
  }
}
