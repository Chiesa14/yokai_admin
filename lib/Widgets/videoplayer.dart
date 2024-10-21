// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:click_innovate_admin/utils/colors.dart';
// import 'dart:html' as html;

// class VideoPlayerWidget extends StatefulWidget {
//   final String url;

//   VideoPlayerWidget({required this.url});

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _showControls = false;
//   bool _isFullScreen = false;
//   double _currentPosition = 0;
//   static const normalSpeed = 1.0;
//   static const fastSpeed = 1.5;
//   static const fasterSpeed = 2.0;
//   double _selectedSpeed = normalSpeed;
//   bool _isBuffering = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });

//     _controller.addListener(() {
//       setState(() {
//         _currentPosition = _controller.value.position.inMilliseconds.toDouble();
//         _isBuffering = _controller.value.isBuffering;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void enterFullScreen() {
//     final videoElement = html.document.querySelector('video');
//     videoElement?.requestFullscreen();
//   }

//   void exitFullScreen() {
//     html.document.exitFullscreen();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       _controller.value.isPlaying ? _controller.pause() : _controller.play();
//     });
//   }

//   void _toggleFullScreen() {
//     if (kIsWeb) {
//       setState(() {
//         _isFullScreen = !_isFullScreen;
//       });
//       if (_isFullScreen) {
//         enterFullScreen();
//       } else {
//         exitFullScreen();
//       }
//     }
//   }

//   void _changeSpeed(double speed) {
//     setState(() {
//       _selectedSpeed = speed;
//     });
//     _controller.setPlaybackSpeed(speed);
//   }

//   Widget _buildControls() {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(_showControls ? 0.8 : 0.0),
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: Icon(
//                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 color: Colors.white,
//                 size: 20.0,
//               ),
//               onPressed: _togglePlayPause,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 50,
//           left: 10,
//           right: 10,
//           child: Column(
//             children: [
//               CustomSeekBar(
//                 controller: _controller,
//                 currentPosition: _currentPosition,
//                 onSeek: (position) {
//                   _controller.seekTo(Duration(milliseconds: position.toInt()));
//                 },
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 30,
//           right: 10,
//           child: IconButton(
//             icon: Icon(
//               // _isFullScreen ? Icons.fullscreen_exit :
//                Icons.fullscreen,
//               color: primaryColor,
//             ),
//             onPressed: _toggleFullScreen,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       width: 600,
//       child: MouseRegion(
//         onEnter: (_) => setState(() => _showControls = true),
//         onExit: (_) => setState(() => _showControls = false),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         VideoPlayer(_controller),
//                         if (_isBuffering)
//                           Center(
//                             child: CircularProgressIndicator(
//                               color: primaryColor,
//                             ),
//                           ),
//                       ],
//                     ),
//                   )
//                 : Center(child: CircularProgressIndicator(color: primaryColor)),
//             if (_showControls || _isFullScreen) _buildControls(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomSeekBar extends StatelessWidget {
//   final VideoPlayerController controller;
//   final double currentPosition;
//   final ValueChanged<double> onSeek;

//   CustomSeekBar({
//     required this.controller,
//     required this.currentPosition,
//     required this.onSeek,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliderTheme(
//       data: SliderThemeData(
//         thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
//         overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
//         thumbColor: primaryColor,
//         activeTrackColor: primaryColor,
//         inactiveTrackColor: Colors.grey,
//         trackHeight: 4.0,
//       ),
//       child: Slider(
//         value: currentPosition,
//         min: 0.0,
//         max: controller.value.duration.inMilliseconds.toDouble(),
//         onChanged: onSeek,
//       ),
//     );
//   }
// }
