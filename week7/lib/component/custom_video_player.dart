import 'dart:io'; // File 클래스를 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // VideoPlayerController를 사용하기 위해 필요
import 'package:image_picker/image_picker.dart';

class CustomVideoPlayer extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    initializeController(); // 컨트롤러 초기화
  }

  Future<void> initializeController() async {
    // 선택한 동영상으로 컨트롤러 초기화
    final controller = VideoPlayerController.file(
      File(widget.video.path), //videoplaterconteoller를 이용해서 videoplater 제어
    );
    await controller.initialize();
    // videoController 생성 후 initialize 함수 실행-> 동영상 재생 준비 상태
    controller.addListener(videoControllerListener); // videoController 변화 감지 -> callback 함수
    setState(() {
      videoController = controller;
    });
  }

  void videoControllerListener() { // videoController 변화 감지 시 동작하는 callback -> setState로 상태 갱신-> build()함수 자동 재실행 됨->slider변화 반영
    setState(() {});
  }

  @override
  // 앱 종료시 Listener 해제
  void dispose() {
    videoController?.removeListener(videoControllerListener);
    videoController?.dispose();
    super.dispose();
  }

  @override // convariant:기존 위젯의 변수를 모두 가져오기 위해서 사용
  //State가 Update 될때 (새로운 동영상 선택)
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;
    Duration position = maxPosition;
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed() {
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
          // Tap action 처리
        });
      },
      child: AspectRatio(// 위젯 내부에 영상의 비율을 조정해 주기 위함
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack( //children 위젯을 위로 쌓을 수 있는 위젯
          children: [
            VideoPlayer(videoController!), // 동영상 플레이어, videoplater 위젯을 stack으로 이동
            Align(
              alignment: Alignment.topRight,
              child: CustomIconButton(
                onPressed: widget.onNewVideoPressed, // 플레이어 화면 구현(동영상 최초 선택시)
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
            Positioned( // 영상을 초단위로 제어하므로 0초에서 시작 최대 값은 videoConteoller에 로딩된 영상 값 참조
              bottom: 0,
              left: 0,
              right: 0,
              child: Slider(
                onChanged: (double val) { // 슬라이더가 변화하면 val 값이 전달됨, videoController에서 val 부분을 찾아서 이동
                  videoController!.seekTo(
                    Duration(seconds: val.toInt()),
                  );
                },
                value: videoController!.value.position.inSeconds.toDouble(), //현재 동영상이 실행되고 있는 위치
                min: 0,
                max: videoController!.value.duration.inSeconds.toDouble(),// 동영상 전체 길이 값
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const CustomIconButton({
    // 일반적인 버튼이 눌리면 onPressed()가 실행되도록 일반적으로 정의함
    required this.onPressed,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
