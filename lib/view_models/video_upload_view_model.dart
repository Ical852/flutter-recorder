import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterrecorder/functions/global_func.dart';
import 'package:flutterrecorder/services/video_services.dart';

class VideoUploadViewModel {
  late BuildContext context;
  late VideoServices services;

  VideoUploadViewModel(BuildContext context) {
    this.context = context;
    this.services = VideoServices();
  }

  void onViodeoUpload(XFile videoFile) async {
    try {
      var response = await services.uploadVideo(videoFile: videoFile);
      if (response) {
        return showGLobalAlert("success", "Success to upload video", context);
      }

      return showGLobalAlert("danger", "Failed to upload video", context);
    } catch (e) {
      return showGLobalAlert("danger", "Failed to upload video", context);
    }
  }
}