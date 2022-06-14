import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController _urlTextFieldController = TextEditingController();
  String videoTitle = '';
  String videoPublishDate = '';
  String videoID = '';
  bool _downloading = false;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Column(
                  children: [
                    const SizedBox(height: 10,),

                    Row(
                      children: [
                      FlatButton(onPressed: (){Get.back();}, child:const Icon(Icons.arrow_back_ios,color: Colors.black,))
                    ],),
                   const SizedBox(height: 20,),
                    Container(
                      child: TextField(
                        controller: _urlTextFieldController,
                        onChanged: (val) {
                          getVideoInfo(val);
                        },
                        decoration: const InputDecoration(
                            labelText:('Paste youtube video url here')),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                width: 250,
                child: Image.asset( 'assets/image/youtube.png'
                ),
              ),

              // SizedBox(
              //   height: 150,
              //   width: 250,
              //   child: Image.network( videoID == ''
              //       ? 'https://img.youtube.com/vi/$videoID/0.jpg'
              //       : 'assets/image/youtube.png',
              //   'https://play-lh.googleusercontent.com/vA4tG0v4aasE7oIvRIvTkOYTwom07DfqHdUPr6k7jmrDwy_qA_SonqZkw6KX0OXKAdk'
              //
              //   ),
              // ),
              Text(videoTitle),
              Text(videoPublishDate),
              TextButton.icon(
                  onPressed: () {
                    downloadVideo(_urlTextFieldController.text);
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Start download')),
              _downloading
                  ? Padding(
                     padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.blueAccent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.greenAccent),
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  //functions
  Future<void> getVideoInfo(url) async {
    var youtubeInfo = YoutubeExplode();
    var video = await youtubeInfo.videos.get(url);
    setState(() {
      videoTitle = video.title;
      videoPublishDate = video.publishDate.toString();
      videoID = video.id.toString();
    });
  }

  Future<void> downloadVideo(id) async {
    var permisson = await Permission.storage.request();
    if (permisson.isGranted) {
      //download video
      if (_urlTextFieldController.text != '') {
        setState(() => _downloading = true);

        //download video
        setState(() => progress = 0);
        var _youtubeExplode = YoutubeExplode();
        //get video metadata
        var video = await _youtubeExplode.videos.get(id);
        var manifest =
        await _youtubeExplode.videos.streamsClient.getManifest(id);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = _youtubeExplode.videos.streamsClient.get(audio);
        //create a directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var file = File('$appDocPath/${video.id}');
        //delete file if exists
        if (file.existsSync()) {
          file.deleteSync();
        }
        var output = file.openWrite(mode: FileMode.writeOnlyAppend);
        var size = audio.size.totalBytes;
        var count = 0;

        await for (final data in audioStream) {
          // Keep track of the current downloaded data.
          count += data.length;
          // Calculate the current progress.
          double val = ((count / size));
          var msg = '${video.title} Downloaded to $appDocPath/${video.id}';
          for (val; val == 1.0; val++) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          }
          setState(() => progress = val);

          // Write to file.
          output.add(data);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('add youtube video url first!')));
        setState(() => _downloading = false);
      }
    } else {
      await Permission.storage.request();
    }
  }
}
