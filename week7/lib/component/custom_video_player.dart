import 'dart:io'; // File 클래스를 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // VideoPlayerController를 사용하기 위해 필요
import 'package:image_picker/image_picker.dart';

class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 주입해주기
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  bool showControls = false;

  @override
  void initState() {
    super.initState();
    initializeController(); // 컨트롤러 초기화
  }

  Future<void> initializeController() async {
    // 선택한 동영상으로 컨트롤러 초기화
    final controller = VideoPlayerController.file(
      File(widget.video.path),
    );
    await controller.initialize();
    controller.addListener(videoControllerListener);
    setState(() {
      videoController = controller;
    });
  }

  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    videoController?.removeListener(videoControllerListener);
    videoController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  void onReversePressed() {
    // 되감기 버튼 눌렀을 때 실행할 함수
    final currentPosition = videoController!.value.position;
    Duration position = Duration();
    // 0초로 실행 위치 초기화
    if (currentPosition.inSeconds > 3) {
      // 현재 실행위치가 3초보다 길때만 3초 빼기
      position = currentPosition - Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    // 앞으로 감기 버튼 눌렀을 때 실행할 함수
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;
    Duration position = maxPosition;
    // 동영상 길이에서 3초를 뺀 값보다 현재 위치가 짧을 때만 3초 더하기
    if ((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    // 재생 버튼을 눌렀을 때 실행할 함수
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoController!), // 동영상 플레이어
            if (showControls) ...[
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Slider(
                  onChanged: (double val) {
                    videoController!.seekTo(
                      Duration(seconds: val.toInt()),
                    );
                  },
                  value: videoController!.value.position.inSeconds.toDouble(),
                  min: 0,
                  max: videoController!.value.duration.inSeconds.toDouble(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const CustomIconButton({required this.onPressed, required this.iconData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}