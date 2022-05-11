// ignore_for_file: avoid_unnecessary_containers, avoid_types_as_parameter_names, file_names

import 'package:flutter/material.dart';


class ImageSwiper extends StatefulWidget {
  final List imagelist;
  const ImageSwiper({Key? key, required this.imagelist}) : super(key: key);

  @override
  State<ImageSwiper> createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imagelist.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imagelist[i]}",
                    fit: BoxFit.cover,
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imagelist.length; i++)
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 25.0 : 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: _selectedPage == i ? Colors.black : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
