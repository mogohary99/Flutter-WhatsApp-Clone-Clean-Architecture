import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../components/loader.dart';
import 'components/camera_appbar.dart';
import 'components/select_image_from_gallery_button.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final String receiverId;
  const CameraScreen({super.key, required this.receiverId,});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CameraAppBar(
        isFlashOn: isFlashOn,
        onFlashPressed: toggleFlash,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureBuilder(
                  future: _cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: double.infinity,
                        child: CameraPreview(_cameraController),
                      );
                    } else {
                      return const Loader();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         SelectImageFromGalleryButton(receiverId: widget.receiverId),
                        GestureDetector(
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          onLongPress: ()async {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording =true;
                            });

                          },
                          onLongPressUp: () async{
                            XFile videoPath = await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            if(!mounted) return;
                            navigateTo(context, Routes.sendingVideoViewRoute, arguments: {
                              'uId' : widget.receiverId,
                              'path' : videoPath.path,
                            },);
                          },
                          child: cameraIcon(),
                        ),
                        GestureDetector(
                          onTap: toggleCameraFront,
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black38,
                            child: Icon(
                              Icons.flip_camera_ios,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'Hold for video, tap for photo',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Icon cameraIcon() {
    return isRecording
        ? const Icon(
            Icons.radio_button_on,
            color: Colors.red,
            size: 80,
          )
        : const Icon(
            Icons.panorama_fish_eye,
            size: 80,
            color: Colors.white,
          );
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 0 : 1;
    _cameraController =
        CameraController(cameras[cameraPos], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    if(!mounted) return;
    navigateTo(context, Routes.sendingImageViewRoute, arguments: {
      'path': file.path,
      'uId' : widget.receiverId,
    });
  }



  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
