import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecorderPage extends StatefulWidget {
  const VideoRecorderPage({super.key});

  @override
  State<VideoRecorderPage> createState() => _VideoRecorderPageState();
}

class _VideoRecorderPageState extends State<VideoRecorderPage> {
  CameraController? controller;
  XFile? videoFile;
  List<CameraDescription>? cameras;
  
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high);
    await controller?.initialize();
    setState(() {});
  }

  void startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final videoPath = '${directory.path}/video.mp4';
    await controller?.startVideoRecording();
    setState(() {});
  }

  void stopRecording() async {
    videoFile = await controller?.stopVideoRecording();
    setState(() {});
  }

  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.videocam),
                onPressed: () {
                  startRecording();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  stopRecording();
                },
              ),
            ],
          ),
          videoFile != null
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/upload', arguments: videoFile);
                  },
                  child: Text("Upload Video"),
                )
              : Container(),
        ],
      ),
    );
  }
}
