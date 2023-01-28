import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../theme.dart';

class Result extends StatefulWidget {
  const Result({
    super.key,
    required this.controller,
    required this.transcript,
    required this.query,
  });

  final YoutubePlayerController controller;
  final Map<String, String> transcript;
  final String query;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String _transcript = '';
  String first = '';
  String highlight = '';
  String second = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          controller: widget.controller,
          showVideoProgressIndicator: true,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            if (widget.transcript[value.position.inSeconds.toString()] !=
                null) {
              _transcript = widget
                  .transcript[value.position.inSeconds.toString()] as String;
              if (_transcript.contains(widget.query)) {
                first =
                    _transcript.substring(0, _transcript.indexOf(widget.query));
                highlight = _transcript.substring(
                    _transcript.indexOf(widget.query),
                    _transcript.indexOf(widget.query) + widget.query.length);
                second = _transcript.substring(
                    _transcript.indexOf(widget.query) + widget.query.length);
              }
            }
            return _transcript.contains(widget.query)
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: first,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: highlight,
                          style: TextStyle(
                            backgroundColor: Colors.yellow,
                            color: AppColors.primary,
                            fontFamily: 'Ubuntu',
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: second,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: 'Ubuntu',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    _transcript,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                    ),
                  );
          },
        ),
      ],
    );
  }
}
