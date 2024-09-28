import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:video_player/video_player.dart';

class CustomSlideImage extends StatefulWidget {
  final String imageUrls;
  final String videoUrl;

  const CustomSlideImage({
    Key? key,
    required this.imageUrls,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<CustomSlideImage> createState() => _CustomSlideImageState();
}

class _CustomSlideImageState extends State<CustomSlideImage> {
  late VideoPlayerController videoPlayerController;
  late int selectedPage;
  PageController? pageController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    ini();
  }

  ini() async {
    selectedPage = 0;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      materialProgressColors: ChewieProgressColors(
          // playedColor: Colors.red,
          // handleColor: Colors.blue,
          // backgroundColor: Colors.grey,
          // bufferedColor: Colors.lightGreen,
          ),
      placeholder: Center(child: CircularProgressIndicator()),
    );

    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("video url----${widget.videoUrl}");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: PageView(
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              // controller: pageController,
              scrollDirection: Axis.horizontal,
              children: [
                ImagePage(widget.imageUrls),
                VideoPage(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PageViewDotIndicator(
              size: Size(8, 8),
              currentItem: selectedPage,
              count: 2,
              unselectedColor: Colors.black26,
              selectedColor: ColorConstants.button_color,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
              onItemClicked: (index) {
                pageController?.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ImagePage(String urlImage) {
    return Container(
      height: 180,
      width: double.infinity,
      child: Image.network(urlImage, fit: BoxFit.cover),
    );
  }

  Widget VideoPage() {
    return chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(controller: chewieController!)
        : Center(child: CircularProgressIndicator());
  }
}
