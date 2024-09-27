import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/controller/learning_controller/MyLearningController.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:learning_app/core/widgets/custom_star.dart';
import 'package:learning_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:learning_app/view/my_learning/widgets/add_reviews.dart';
import 'package:learning_app/view/my_learning/widgets/myLearningWidget.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

class Learningdetails extends StatefulWidget {
  final int courseID;
  final String courseName;
  const Learningdetails(
      {super.key, required this.courseID, required this.courseName});

  @override
  State<Learningdetails> createState() => _LearningdetailsState();
}

class _LearningdetailsState extends State<Learningdetails> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  int initialIndex = 0;
  Future initializeVideoPlayer(int index) async {
    var provider = context.read<Mylearningcontroller>();
    await provider.detailLearningpage(widget.courseID);
    var data = provider.learningDetailModel?.data;

    if (data != null && index < data.length) {
      String? videoUrl = data[index].video;
      log("Intial index----$index");
      log("video url----$videoUrl");

      if (videoUrl != null && videoUrl.isNotEmpty) {
        await videoPlayerController.dispose();
        // chewieController?.dispose();

        videoPlayerController = VideoPlayerController.network(videoUrl)
          ..addListener(() async {
            log("inside");
            if (chewieController?.isPlaying == false) {
              final position = await videoPlayerController.position;
              log("position----$position");
              chewieController?.pause();
              provider.watchlength(widget.courseID, data[index].id, position);
            }
          });
        await videoPlayerController.initialize();

        var startAt = context
            .read<Mylearningcontroller>()
            .parseDuration(data[index].watchDuration ?? "");
        log("start at-----$startAt");
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: false,
          looping: true,
          materialProgressColors: ChewieProgressColors(),
          startAt: startAt,
          //   IconButton(
          //   icon: Icon(Icons.pause),
          //   onPressed: () async {
          //      final position = await videoPlayerController.position;
          //     chewieController?.pause();
          //     provider.watchlength(widget.courseID, data[index].id, position?.inSeconds);
          //   },
          // );

          placeholder: Center(child: CircularProgressIndicator()),
        );

        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network('');
    initializeVideoPlayer(initialIndex);
    log("inside ----1");

    // }
    // context.read<Mylearningcontroller>().detailLearningpage(widget.courseID);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Mylearningcontroller>();
    var data = provider.learningDetailModel;
    // log("watch duration---${data?.watchDuration}");
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigation(initialIndex: 2),
                  ),
                  ModalRoute.withName('/mylearning'));
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "Learning details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: provider.learningDetailModel?.status != "success"
            ? Center(child: Text("Topics Not Found !"))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //     height: 220,
                    //     child: Chewie(controller: chewieController!)),
                    if (chewieController != null &&
                        chewieController!
                            .videoPlayerController.value.isInitialized)
                      Container(
                        height: 220,
                        child: Chewie(controller: chewieController!),
                      )
                    else
                      Container(
                        height: 220,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddReview(
                                    course_id: widget.courseID,
                                    courseName: widget.courseName,
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: StarRating(
                                size: 23,
                                rating: data?.data?[initialIndex].rating ?? 0),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data?.data?[initialIndex].topicName ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    ReadMoreText(
                      data?.data?[initialIndex].description ?? "",
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color),
                      trimCollapsedText: 'See more',
                      trimExpandedText: ' Show less',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.button_color),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        height: .5,
                        color: ColorConstants.primary_black,
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data1 =
                              provider.learningDetailModel?.data?[index];
                          String watchDuration = data1?.watchDuration ?? "";
                          watchDuration = watchDuration.substring(
                              0, watchDuration.length - 6);
                          var videoDuration = data1?.videoDuration ?? "";
                          log("watch---$watchDuration,video---$videoDuration");
                          var percentage = provider.percentageCalculator(
                              watchDuration, videoDuration);
                          log("percentage====$percentage");
                          return InkWell(
                            onTap: () {
                              log("id---${widget.courseID}");

                              // log("Percentage: $percentage");

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => Learningdetails(
                              //         courseID: data1?.id ?? 0,
                              //       ),
                              //     ));

                              setState(() {
                                initialIndex = index;
                              });
                              log("index----$index");
                              initializeVideoPlayer(index);
                            },
                            child: Mylearningwidget(
                              percentage: percentage,
                              courseName: data1?.topicName ?? "",
                              photo: data1?.thumbnail ?? "",
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemCount:
                            provider.learningDetailModel?.data?.length ?? 0)
                  ],
                ),
              ),
      ),
    );
  }
}
