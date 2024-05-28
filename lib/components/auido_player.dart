// ignore_for_file: unused_element

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
// import 'package:ebook_app/data/book_read_listen_data.dart';
// import 'package:ebook_app/models/book_read_listen.dart';
import 'package:flutter/material.dart';

// String _url = "";

// class ListenModePlayer extends StatefulWidget {
//   final String url;
//   const ListenModePlayer({super.key, required this.url});

//   @override
//   State<StatefulWidget> createState() {
//     return _ListenModePlayerState();
//   }
// }

// class _ListenModePlayerState extends State<ListenModePlayer> {
//   late AudioPlayer player = AudioPlayer();
//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();
//     player.setReleaseMode(ReleaseMode.stop);
//     // final BookReadListen data =
//     //     readListenData.firstWhere((element) => element.id == widget.id);

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _url = widget.url;
//       await player.setSource(AssetSource(_url));
//       await player.resume();
//     });
//   }


//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: Scaler.width(1, context),
//       child: PlayerWidget(player: player),
//     );
//   }
// }

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  const PlayerWidget({
    super.key,
    required this.player,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Slider(
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).colorScheme.secondary,
          onChanged: (value) {
            final duration = _duration;
            if (duration == null) {
              return;
            }
            final position = value * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
                  _duration != null &&
                  _position!.inMilliseconds > 0 &&
                  _position!.inMilliseconds < _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _position != null
                  ? _positionText
                  : _duration != null
                      ? _durationText
                      : '',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              width: 108,
            ),
            Text(
              _position != null
                  ? _durationText
                  : _duration != null
                      ? _durationText
                      : '',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              key: const Key('skip_previous'),
              onPressed: started,
              iconSize: 32.0,
              icon: const Icon(Icons.skip_previous_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
              hoverColor: Theme.of(context).colorScheme.secondary,
            ),
            IconButton(
              key: const Key('replay_10_button'),
              onPressed: _replay10sn,
              iconSize: 32.0,
              icon: const Icon(Icons.replay_10_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
              hoverColor: Theme.of(context).colorScheme.secondary,
            ),
            if (isPlay == false)
              IconButton(
                key: const Key('play_button'),
                onPressed: _play,
                iconSize: 48.0,
                icon: const Icon(Icons.play_arrow),
                color: Theme.of(context).colorScheme.primary,
                hoverColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
              )
            else
              IconButton(
                key: const Key('pause_button'),
                onPressed: _pause,
                iconSize: 48.0,
                icon: const Icon(Icons.pause),
                color: Theme.of(context).colorScheme.primary,
                hoverColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            IconButton(
              key: const Key('forward_10_button'),
              onPressed: _forwar10sn,
              iconSize: 32.0,
              icon: const Icon(Icons.forward_10_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
              hoverColor: Theme.of(context).colorScheme.secondary,
            ),
            IconButton(
              key: const Key('skip_next_button'),
              onPressed: ended,
              iconSize: 32.0,
              icon: const Icon(Icons.skip_next_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
              hoverColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    isPlay = true;
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    isPlay = false;
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  Future<void> _replay10sn() async {
    final duration = _position;
    if (duration == null) {
      return;
    }
    if (duration.inMilliseconds < 10000) {
      await player.seek(const Duration(milliseconds: 0));
    } else {
      await player
          .seek(Duration(milliseconds: duration.inMilliseconds - 10000));
    }

    await player.resume();
    setState(() {
      _playerState = PlayerState.playing;
      isPlay = true;
    });
  }

  Future<void> _forwar10sn() async {
    final position = _position;
    final duration = _duration;

    if (position == null || duration == null) {
      return;
    }

    if ((position.inMilliseconds + 10000) > duration.inMilliseconds) {
      await player.seek(Duration(milliseconds: duration.inMilliseconds));
    } else {
      await player
          .seek(Duration(milliseconds: position.inMilliseconds + 10000));
    }

    await player.resume();

    setState(() {
      _playerState = PlayerState.playing;
      isPlay = true;
    });
  }

  Future<void> ended() async {
    final duration = _duration;
    if (duration == null) {
      return;
    }
    await player.pause();
    await player.seek(Duration(milliseconds: duration.inMilliseconds));
    setState(() {
      _playerState = PlayerState.stopped;
      _position = duration;
      isPlay = false;
    });
  }

  Future<void> started() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
      isPlay = false;
    });
  }
}
