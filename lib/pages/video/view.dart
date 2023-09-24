/*
 * @Author: 杨武硕
 * @Date: 2023-09-24 15:40:51
 * @LastEditors: 杨武硕
 * @LastEditTime: 2023-09-25 00:39:56
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nba/common/index.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  /// 视频播放控制器
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://media.w3.org/2010/05/sintel/trailer.mp4',
      ),
    )..initialize().then(
        // 确保第一帧画面立即显示出来
        (_) => setState(() {
          // 初始化成功开始播放
          _videoPlayerController.play();
        }),
      );
    addListenVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: _videoPlayerController.value.isInitialized
                          ? GestureDetector(
                              onTap: changeVideoStatus,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Positioned.fill(
                    child: UnconstrainedBox(
                      child: _videoPlayerController.value.isPlaying
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: changeVideoStatus,
                              child: CircleButton(
                                icon: Icon(
                                  Icons.play_arrow_rounded,
                                  weight: 400,
                                  size: 60.sp,
                                ),
                                size: 90.sp,
                                edge: EdgeInsets.only(bottom: 8.sp),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: context.pop,
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Image.asset(
                          AssetsImages.leftArrow3x,
                          width: 18.sp,
                          height: 18.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.sp,
                    right: 10.sp,
                    bottom: 10.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "《NBA档案库》第十期： 凯莱布-马丁小人物完美逆袭.mp4",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(height: 1.4),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "09月2日 14:23",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF999999)),
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Column(
                          children: [
                            CircleButton(
                              icon: Icon(
                                Icons.favorite_outline,
                                weight: 400,
                                size: 20.sp,
                              ),
                              size: 40.sp,
                              edge: EdgeInsets.only(bottom: 8.sp),
                              backgroundColor: Colors.white30,
                            ),
                            CircleButton(
                              icon: Icon(
                                Icons.star_outline,
                                weight: 400,
                                size: 20.sp,
                              ),
                              size: 40.sp,
                              edge: EdgeInsets.only(bottom: 8.sp),
                              backgroundColor: Colors.white30,
                            ),
                            CircleButton(
                              icon: Icon(
                                Icons.share_outlined,
                                weight: 400,
                                size: 20.sp,
                              ),
                              size: 40.sp,
                              edge: EdgeInsets.only(bottom: 8.sp),
                              backgroundColor: Colors.white30,
                            ),
                            CircleButton(
                              icon: Icon(
                                _videoPlayerController.value.volume == 0
                                    ? Icons.volume_off_outlined
                                    : Icons.volume_up_outlined,
                                weight: 400,
                                size: 20.sp,
                              ),
                              size: 40.sp,
                              edge: EdgeInsets.only(bottom: 8.sp),
                              backgroundColor: Colors.white30,
                              onTap: changeVideoVolume,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.sp,
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list,
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  Expanded(
                    child: Text(
                      "档案袋",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 10.sp,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
            // 进度条
            Padding(
              padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 5.sp),
              child: StepProgressIndicator(
                totalSteps: _videoPlayerController.value.duration.inSeconds <= 0
                    ? 100
                    : _videoPlayerController.value.duration.inMilliseconds,
                currentStep:
                    _videoPlayerController.value.position.inMilliseconds,
                size: 2.sp,
                padding: 0,
                selectedColor: const Color(0xFF999999),
                unselectedColor: Theme.of(context).colorScheme.onBackground,
                roundedEdges: const Radius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _VideoPageStateExtension on _VideoPageState {
  // 播放状态切换
  void changeVideoStatus() => setState(
        () {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
        },
      );

  // 开启播放监听
  void addListenVideo() {
    // 视频播放发生变动则持续刷新
    _videoPlayerController.addListener(() => setState(() => {}));
  }

  // 音量切换
  void changeVideoVolume() {
    setState(
      () {
        _videoPlayerController.value.volume == 0
            ? _videoPlayerController.setVolume(100)
            : _videoPlayerController.setVolume(0);
      },
    );
  }
}
