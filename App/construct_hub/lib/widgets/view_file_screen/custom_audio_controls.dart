import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomAudioControls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const CustomAudioControls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return IconButton(
            onPressed: () async {
              await audioPlayer.play();
            },
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 64,
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            onPressed: () async {
              await audioPlayer.pause();
            },
            icon: const Icon(
              Icons.pause_rounded,
              color: Colors.white,
              size: 64,
            ),
          );
        }
        return const Icon(
          Icons.play_arrow_rounded,
          size: 64,
          color: Colors.white,
        );
      },
    );
  }
}
