import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:learning_app/core/constants/color_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({Key? key, required this.imageUrls}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int activeIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: 200,
            child: CarouselSlider.builder(
              carouselController: controller,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = widget.imageUrls[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                // height: 400,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
            ),
          ),
          SizedBox(height: 12),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: ColorConstants.button_color),
        activeIndex: activeIndex,
        count: widget.imageUrls.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Container(
      height: 200,
      width: 400,
      child: Image.network(urlImage, fit: BoxFit.cover));
}
