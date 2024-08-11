import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterrecorder/functions/global_func.dart';
import 'package:flutterrecorder/screens/video_upload_pages/video_upload_page.dart';
import 'package:flutterrecorder/shared/text_styles.dart';

class VideoRecorderPage extends StatefulWidget {
  const VideoRecorderPage({super.key});

  @override
  State<VideoRecorderPage> createState() => _VideoRecorderPageState();
}

class _VideoRecorderPageState extends State<VideoRecorderPage> {
  CameraController? controller;
  XFile? videoFile;
  List<CameraDescription>? cameras;
  bool isRecording = false;
  bool isPaused = false;
  int selectedCameraIndex = 0;
  Timer? timer;
  Duration recordingDuration = Duration.zero;
  
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future initializeCamera() async {
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras![selectedCameraIndex], ResolutionPreset.high);
      await controller?.initialize();
      setState(() {});
    } catch (e) {
      showGLobalAlert(
        "danger",
        "Failed to initialize camera with message : $e",
        context
      );
    }
  }

  Future startRecording() async {
    try {
      await controller?.startVideoRecording();
      stopTimer(reset: true);
      startTimer();
      setState(() {
        this.isRecording = true;
      });
    } catch (e) {
      showGLobalAlert(
        "danger",
        "Failed to start a recording with message : $e",
        context
      );
    }
  }

  Future pauseRecording() async {
    try {
      await controller?.pauseVideoRecording();
      stopTimer();
      setState(() {
        this.isPaused = true;
      });
    } catch (e) {
      showGLobalAlert(
        "danger",
        "Failed to pause the recording with message : $e",
        context
      );
    }
  }

  Future resumeRecording() async {
    try {
      await controller?.resumeVideoRecording();
      startTimer();
      setState(() {
        this.isPaused = false;
      });
    } catch (e) {
      showGLobalAlert(
        "danger",
        "Failed to resume the recording with message : $e",
        context
      );
    }
  }
 
  Future stopRecording() async {
    try {
      final videoFile = await controller?.stopVideoRecording();
      stopTimer();
      setState(() {
        this.videoFile = videoFile;
        this.isRecording = false;
        this.isPaused = false;
      });
    } catch (e) {
      showGLobalAlert(
        "danger",
        "Failed to stop the recording with message : $e",
        context
      );
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        recordingDuration += Duration(seconds: 1);
      });
    });
  }

  void stopTimer({bool reset = false}) {
    if (timer != null) {
      timer!.cancel();
      if (reset) {
        setState(() {
          recordingDuration = Duration.zero;
        });
      }
    }
  }

  void switchCamera() async {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    await initializeCamera();
  }

  Widget build(BuildContext context) {
    Widget RecordAction() {
      if (isRecording) {
        return IconButton(
          icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
          onPressed: () {
            isPaused ? resumeRecording() : pauseRecording();
          }
        );
      }
      return Container();
    }

    Widget UploadAction() {
      if (videoFile != null && !isRecording) {
        return IconButton(
          icon: Icon(Icons.queue_play_next),
          onPressed: (){
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => VideoUploadPage(videoFile: videoFile)
              )
            );
          },
        );
      }
      return Container();
    }

    Widget TimerDisplay() {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(recordingDuration.inMinutes.remainder(60));
      final seconds = twoDigits(recordingDuration.inSeconds.remainder(60));

      return Text(
        '$minutes:$seconds',
        style: regular.black.semiBold,
      );
    }

    if (controller != null) {
      if (!controller!.value.isInitialized) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(title: Text("Video Recorder")),
        body: Column(
          children: [
            Expanded(
              child: CameraPreview(controller!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isRecording ? IconButton(
                  icon: Icon(Icons.switch_camera),
                  onPressed: switchCamera,
                ) : Container(width: 48,),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(isRecording ? Icons.stop : Icons.videocam),
                      onPressed: () {
                        isRecording ? stopRecording() : startRecording();
                      },
                    ),
                    RecordAction(),
                    UploadAction(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 12
                  ),
                  child: TimerDisplay()
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
