import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

import '../model/message.dart';
import 'loading.dart';

class ReceiverMessage extends StatefulWidget {
  const ReceiverMessage(
      {super.key,
      required this.message,
      required this.onImageOpen,
      required this.onVideoOpen,
      required this.onUserImageClicked});

  final Message? message;
  final void Function() onImageOpen;
  final void Function() onVideoOpen;
  final VoidCallback onUserImageClicked;

  @override
  State<ReceiverMessage> createState() => _ReceiverMessageState();
}

class _ReceiverMessageState extends State<ReceiverMessage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.message?.video ?? ""));
    _controller.setLooping(true);
    _controller.initialize();
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onUserImageClicked,
            child: CircleAvatar(
              radius: 20,
              foregroundImage: NetworkImage(widget.message?.ownerImage ?? ""),
              backgroundImage: const AssetImage("assets/img/img_2.png"),
            ),
          ),
          const Gap(10),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: widget.message?.type == MessageType.text ? const BoxDecoration(
              color: Color(0xFF262323), // Color for sender messages
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topRight: Radius.circular(16)
              ),
            ) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.message?.type == MessageType.text)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 100),
                    child: Text(widget.message?.text ?? "",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white)),
                  )
                else if (widget.message?.type == MessageType.photo)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 100.0,
                        minWidth: 100.0,
                        maxHeight: 300.0,
                        maxWidth: MediaQuery.of(context).size.width - 100),
                    child: GestureDetector(
                      onTap: widget.onImageOpen,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: widget.message?.image ?? "",
                          placeholder: (context, url) => const Loading(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                else if (widget.message?.type == MessageType.video)
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: VideoPlayer(_controller)),
                    ),
                  ),
                const Gap(5),
                Text(widget.message?.time ?? "",
                    style: const TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
