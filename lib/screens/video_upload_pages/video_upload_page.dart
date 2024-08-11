import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterrecorder/shared/constants.dart';
import 'package:flutterrecorder/view_models/video_upload_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoUploadPage extends StatefulWidget {
  final XFile? videoFile;

  VideoUploadPage({this.videoFile});

  @override
  State<VideoUploadPage> createState() => _VideoUploadPageState();
}

class _VideoUploadPageState extends State<VideoUploadPage> {
  late VideoUploadViewModel uploadVM = VideoUploadViewModel(context);
  VideoPlayerController? videoController;
  bool isPlaying = false;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile != null) {
      videoController = VideoPlayerController.file(File(widget.videoFile!.path))
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          print("Error initializing video: $error");
        });

      videoController?.addListener(() {
        if (videoController!.value.position >= videoController!.value.duration) {
          videoController!.pause();
          videoController!.seekTo(Duration.zero);
          setState(() {
            isPlaying = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  void playVideo() {
    if (videoController != null && videoController!.value.isInitialized) {
      videoController!.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void stopVideo() {
    if (videoController != null && videoController!.value.isInitialized) {
      videoController!.pause();
      videoController!.seekTo(Duration.zero);
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoController != null && videoController!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text("Upload Video")),
        body: Column(
          children: [
            Expanded(child: VideoPlayer(videoController!)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: (){
                    setState(() {
                      if (isPlaying) {
                        stopVideo();
                      } else {
                        playVideo();
                      }
                    });
                  },
                ),
                uploading ? Container(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: blackColor,
                  ),
                ) :
                IconButton(
                  icon: Icon(
                    Icons.upload
                  ),
                  onPressed: () async {
                    setState(() { uploading = true; });
                    await uploadVM.onViodeoUpload(this.widget.videoFile!);
                    setState(() { uploading = false; });
                    if (mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/record",
                        (route) => false,
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
    );
    }
    return Center(child: CircularProgressIndicator());
  }
}
