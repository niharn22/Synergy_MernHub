import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideoWidget extends StatefulWidget {
  final String url;
  const ViewVideoWidget({super.key, required this.url});

  @override
  State<ViewVideoWidget> createState() => _ViewVideoWidgetState();
}

class _ViewVideoWidgetState extends State<ViewVideoWidget> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    initilizeController();

    super.initState();
  }

  Future<void> initilizeController() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        allowFullScreen: true,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false);
    // await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrange,
        ),
      );
    } else {
      return Chewie(controller: chewieController!);
    }

    // isInitilized == true
    //     ? Chewie(controller: chewieController)
    //     : Center(
    //         child: const CircularProgressIndicator(
    //           color: Colors.deepOrange,
    //         ),
    //       );
  }
}
