import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/constants/assets_manager.dart';
import 'timer.dart';

class RecordingMicWidget extends StatefulWidget {
  const RecordingMicWidget({
    Key? key,
    required this.onVerticalScrollComplete,
    required this.onHorizontalScrollComplete,
    required this.onLongPress,
    required this.onLongPressCancel,
    required this.onSend,
    required this.onTapCancel,
  }) : super(key: key);

  final VoidCallback onVerticalScrollComplete;
  final VoidCallback onHorizontalScrollComplete;
  final VoidCallback onLongPress;
  final VoidCallback onLongPressCancel;
  final VoidCallback onSend;
  final VoidCallback onTapCancel;

  @override
  _RecordingMicWidgetState createState() => _RecordingMicWidgetState();
}

class _RecordingMicWidgetState extends State<RecordingMicWidget>
    with SingleTickerProviderStateMixin {
  double micDx = 4;
  double micDy = 4;

  double micWidth = 50;
  double micHeight = 50;

  bool isVerticalScroll = true;
  bool showSwipeOptions = false;
  bool isVerticalActionComplete = false;
  bool isHorizontalActionComplete = false;
  bool isShowMic = false;
  bool isShowTime = false;
  late AnimationController _animationController;

  //Mic
  late Animation<double> _micTranslateTop;
  late Animation<double> _micRotationFirst;
  late Animation<double> _micTranslateRight;
  late Animation<double> _micTranslateLeft;
  late Animation<double> _micRotationSecond;
  late Animation<double> _micTranslateDown;
  late Animation<double> _micInsideTrashTranslateDown;

  //Trash Can
  late Animation<double> _trashWithCoverTranslateTop;
  late Animation<double> _trashCoverRotationFirst;
  late Animation<double> _trashCoverTranslateLeft;
  late Animation<double> _trashCoverRotationSecond;
  late Animation<double> _trashCoverTranslateRight;
  late Animation<double> _trashWithCoverTranslateDown;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    //Mic

    _micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _micRotationFirst = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.2),
      ),
    );

    _micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.1),
      ),
    );

    _micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.2),
      ),
    );

    _micRotationSecond = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.45),
      ),
    );

    _micTranslateDown = Tween(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.79, curve: Curves.easeInOut),
      ),
    );

    _micInsideTrashTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );


    //Trash Can

    _trashWithCoverTranslateTop = Tween(begin: 30.0, end: -25.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.6),
      ),
    );

    _trashCoverRotationFirst = Tween(begin: 0.0, end: -pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.7),
      ),
    );

    _trashCoverTranslateLeft = Tween(begin: 0.0, end: -18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.7),
      ),
    );

    _trashCoverRotationSecond = Tween(begin: 0.0, end: pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 0.9),
      ),
    );

    _trashCoverTranslateRight = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 0.9),
      ),
    );

    _trashWithCoverTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    //Size screenSize = context.size;
    return Stack(
      children: [
        Positioned(
          bottom: 4,
          right: 50,
          child: Visibility(
            visible: showSwipeOptions || isVerticalActionComplete,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.00),
                  color: Colors.white,
                ),
                width: context.width(1) - 65,
                height: 50,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 70,
          child: Visibility(
            visible: showSwipeOptions,
            child: Shimmer.fromColors(
              direction: ShimmerDirection.rtl,
              baseColor: Colors.grey.shade500,
              highlightColor: Colors.grey.shade300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.chevron_left,
                  ),
                  Text(
                    "swipe to cancel",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 70,
          child: Visibility(
            visible: isVerticalActionComplete,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isVerticalActionComplete = false;
                  isShowMic =false;
                  isShowTime = false;
                });
                widget.onTapCancel();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: 0,
          child: Visibility(
            visible: showSwipeOptions,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.00),
                color: Colors.white,
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade300,
                child: const Icon(
                  Icons.lock_rounded,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: micDy,
          right: micDx,
          child: GestureDetector(
            // this is used when the recording is locked and you want to save the audio
            onTap: () {
              if (isVerticalActionComplete) {
                setState(() {
                  isVerticalActionComplete = false;
                  isShowMic =false;
                  isShowTime=false;
                });
                widget.onSend();
              }
            },

            onLongPress: () {
              widget.onLongPress();
              isVerticalActionComplete = false;
              isHorizontalActionComplete = false;

              setState(() {
                micWidth = 80;
                micHeight = 80;
                showSwipeOptions = true;
                isShowMic =true;
                isShowTime=true;
              });
            },

            onLongPressEnd: (LongPressEndDetails lg) {
              setState(() {
                micWidth = 50;
                micHeight = 50;
                micDy = 4;
                micDx = 4;
                showSwipeOptions = false;
              });
              if (!isVerticalActionComplete && !isHorizontalActionComplete) {
                widget.onLongPressCancel();
                setState(() {
                  isShowMic =false;
                  isShowTime=false;
                });
              }
            },

            onLongPressMoveUpdate: (LongPressMoveUpdateDetails longPressData) {
              longPressUpdate(longPressData);
            },

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.00),
                color: Colors.teal,
              ),
              width: micWidth,
              height: micHeight,
              child: Icon(
                isVerticalActionComplete ? Icons.send : Icons.mic,
                color: Colors.teal[50],
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: -10,
          child: Visibility(
            visible: isShowMic,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 10)..translate(
                            _micTranslateRight.value)..translate(
                            _micTranslateLeft.value)..translate(
                            0.0, _micTranslateTop.value)..translate(
                            0.0, _micTranslateDown.value)..translate(
                            0.0, _micInsideTrashTranslateDown.value),
                      child: Transform.rotate(
                        angle: _micRotationFirst.value,
                        child: Transform.rotate(
                          angle: _micRotationSecond.value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child:  const Icon(
                    Icons.mic,
                    color: Color(0xFFef5552),
                    size: 30,
                  ),
                ),
                AnimatedBuilder(
                  animation: _trashWithCoverTranslateTop,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            0.0, _trashWithCoverTranslateTop.value)..translate(
                            0.0, _trashWithCoverTranslateDown.value),
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _trashCoverRotationFirst,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..translate(
                                  _trashCoverTranslateLeft.value)..translate(
                                  _trashCoverTranslateRight.value),
                            child: Transform.rotate(
                              angle: _trashCoverRotationSecond.value,
                              child: Transform.rotate(
                                angle: _trashCoverRotationFirst.value,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: const Image(
                          //image: AssetImage('assets/images/trash_cover.png'),
                          image: AssetImage(AppImage.trashCoverImg),
                          width: 30,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 1.5),
                        child: Image(
                          image:
                          //AssetImage('assets/images/trash_container.png'),
                          AssetImage(AppImage.trashContainerImg),
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
         Positioned(
          bottom: 15,
          left: 45,
          child: Visibility(
            visible: isShowTime,
            child: const TimerWidget(),
          ),
        ),
      ],
    );
  }

  void longPressUpdate(LongPressMoveUpdateDetails longPressData) {
    //determine the direction of the swipe
    if (longPressData.localPosition.direction > 1) {
      isVerticalScroll = false;
    } else {
      isVerticalScroll = true;
    }

    // handle the swipe data and move the mic in vertical direction
    if (isVerticalScroll) {
      if (longPressData.localPosition.dy < 0) {
        if (longPressData.localPosition.dy > -100) {
          setState(() {
            micDy = -longPressData.localPosition.dy;
          });
        } else {
          // reset only once
          if (showSwipeOptions) {
            isVerticalActionComplete = true;
            widget.onVerticalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // handle the swipe data and move the mic in horizontal direction
    if (!isVerticalScroll) {
      if (longPressData.localPosition.dx < 0) {
        if (longPressData.localPosition.dx > -150) {
          setState(() {
            micDx = -longPressData.localPosition.dx;
          });
        } else {
          // reset only once
          if (showSwipeOptions) {
            isHorizontalActionComplete = true;
            isShowTime=false;
            _animationController.forward().then((_) {
              _animationController.reset();
              setState(() {
                isShowMic =false;
              });

            });
            widget.onHorizontalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // reset mic size when the swipe reaches the vertical bounds
    if (longPressData.localPosition.dy < -100 && micHeight != 50) {
      setState(() {
        micWidth = 50;
        micHeight = 50;
      });
    }

    // reset mic size when the swipe reaches the horizontal bounds
    if (longPressData.localPosition.dy < -150 && micWidth != 50) {
      setState(() {
        micWidth = 50;
        micHeight = 50;
      });
    }
  }

  void resetMicPosition() {
    setState(() {
      micDx = 4;
      micDy = 4;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
