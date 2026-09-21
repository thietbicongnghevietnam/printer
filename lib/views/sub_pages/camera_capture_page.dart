import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/camera_manager.dart';

@RoutePage<String>()
class CameraCapturePage extends StatefulWidget {
  const CameraCapturePage({super.key});

  @override
  CameraCaptureState createState() => CameraCaptureState();
}

class CameraCaptureState extends State<CameraCapturePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initialCam();
  }

  Future<void> initialCam() async {
    final firstCamera = getIt<CameraManager>().cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _controller != null) {
      _initializeControllerFuture = _controller!.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LocaleKeys.camera_camera).tr()),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              final size = context.mediaQuerySize;

              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRect(
                  child: OverflowBox(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SizedBox(
                        height: size.width,
                        width: size.width / _controller!.value.aspectRatio,
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: CameraPreview(_controller!),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller?.takePicture();

                    if (!mounted) {
                      return;
                    }

                    if (image?.path != null && mounted) {
                      final selectCode = await context.pushRoute<String>(
                        DisplayTextPictureRoute(imagePath: image?.path ?? ''),
                      );
                      if (mounted) {
                        context.maybePop(selectCode);
                      }
                    }
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

