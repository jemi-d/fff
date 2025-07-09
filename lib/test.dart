import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imgs = ["https://unsplash.com/photos/a-black-background-with-a-blue-rose-on-it-TK43-x-yJTA", "https://unsplash.com/photos/icebergs-loom-in-a-dark-cold-ocean-lIXRSlHUv0s",
  "https://unsplash.com/photos/a-blue-sculpture-is-shown-with-a-gray-background-Ia9sASxnrtA","https://unsplash.com/photos/a-man-sits-and-observes-the-water-from-a-boat-Mqq_Csd0_qw"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(padding: EdgeInsets.all(10),
      child: CarouselSlider(options: CarouselOptions(height: 200), items: imgs.map((i){
        return Container(
          child: Text(""),
        );
      }).toList(),)
      ),),
    );
  }
}
