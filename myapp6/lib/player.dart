import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AssetPlayer extends StatefulWidget {
  @override
  _AssetPlayerState createState() => _AssetPlayerState();
}

class _AssetPlayerState extends State<AssetPlayer> {
  AssetsAudioPlayer _assetsAudioPlayer;

  bool playing;
  double sD = 100;
  double value = 0;

  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer = AssetsAudioPlayer();

    _assetsAudioPlayer.open(
      AssetsAudio(
        asset: "NEFEX.mp3",
        folder: "audio/",
      ),
    );

    _assetsAudioPlayer.playOrPause();
    setState(() {
      playing = true;
    });

    _assetsAudioPlayer.current.listen((playingAudio) {
      final songDuration = playingAudio.duration;
      print(songDuration.inSeconds);
      sD = songDuration.inSeconds.toDouble();
    });
  }

  void dispose() {
    _assetsAudioPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Asset Audio'),
        ),
        body: ListView(
          children: <Widget>[
            Slider(
              value: value,
              min: 0,
              max: sD,
              onChanged: (double d) {
                setState(() {
                  value = d;
                  Duration du = new Duration(seconds: d.toInt());
                  _assetsAudioPlayer.seek(du);
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: _assetsAudioPlayer.currentPosition,
                builder: (context, asyncSnapshot) {
                  final Duration duration = asyncSnapshot.data;
                  value = duration.inSeconds.toDouble();
                  return Text(duration.inSeconds.toString());
                },
                
              ),
            ),
            RaisedButton(
              child: Icon(Icons.play_arrow),
              onPressed: () {
                _assetsAudioPlayer.playOrPause();
                setState(() {
                  playing = true;
                });
              },
            ),
            RaisedButton(
              child: Icon(Icons.pause),
              onPressed: () {
                _assetsAudioPlayer.pause();
                setState(() {
                  playing = false;
                });
              },
            ),
            RaisedButton(
              child: Icon(Icons.stop),
              onPressed: () {
                setState(() {
                  Duration du = new Duration(seconds: 0);
                  _assetsAudioPlayer.seek(du);
                  value = 0;
                  playing = false;
                });
              },
            ),
            RaisedButton(
              child: Icon(Icons.check),
              onPressed: () {
                print("_____isPlaying________" +
                    _assetsAudioPlayer.isPlaying.value.toString());

                print("______Lacation____" +
                    _assetsAudioPlayer.currentPosition.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
