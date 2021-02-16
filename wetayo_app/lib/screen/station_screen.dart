import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Post> fetchPost() async {
  var future = http.get(
      Uri.encodeFull('https://openapi.naver.com/v1/voice/tts.bin'),
      headers: {"Content-type": "application/x-www-form-urlencoded"});
  final response = await future;

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  /*final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }*/

  final String speaker;
  final int speed;
  final String text;

  Post({this.speaker, this.speed, this.text});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      speaker: json['speaker'],
      speed: json['speed'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speaker'] = this.speaker;
    data['speed'] = this.speed;
    data['text'] = this.text;

    return data;
  }
}

class StationScreen extends StatefulWidget {
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  String _buttonState = 'OFF';
  String _text = '현재 위치 : 모름';
  String _x, _y; // 현재 위치의 위도, 경도 (x, y)
  VoiceController _voiceController;
  String text = ' ';
  Future<Post> post;
  String clientId = "YOUR_CLIENT_ID";
  String clientSecret = "YOUR_CLIENT_SECRET";

  void onClick() {
    print("onClick()");
    setState(() {
      if (_buttonState == 'OFF') {
        _buttonState = 'ON';
      } else {
        _buttonState = 'OFF';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _refresh();
    //_voiceController = FlutterTextToSpeech.instance.voiceController();
    post = fetchPost();
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController.stop();
  }

  _playVoice() {
    _voiceController.init().then((_) {
      _voiceController.speak(
        text,
        VoiceControllerOptions(),
      );
    });
  }

  _checkPermissions() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }

  _refresh() async {
    print('refresh current location');
    String _newText;
    String _newX, _newY;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String result = "(${position.latitude}, ${position.longitude})";
      _newText = '현재 위치는 $result ';
      _newX = position.latitude.toString();
      _newY = position.longitude.toString();
    } on PlatformException {
      _newText = '현재 위치는 사용할 수 없습니다.';
    }
    setState(() {
      _text = _newText;
      _x = _newX;
      _y = _newY;
    });

    print(_text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(-0.7, 0),
            child: Text(
              '나와 가장 가까운 정류소',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 30.0),
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                '한국산업기술대 \n (이마트 방향) \n 정류소 선택하기',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              color: Color(0xff184C88),
              onPressed: _refresh,
              padding: const EdgeInsets.all(20.0),
            ),
          ),
          Container(
            alignment: Alignment(-0.5, 0),
            child: Text(
              '내 주변의 가장 가까운 정류소',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(_text),
          )
        ],
      ),
    )));
  }
}
