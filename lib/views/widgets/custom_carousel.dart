import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        7,
        (index) {
          return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 55,
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              "12 May",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.heart_circle_fill,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  right: 0,
                  left: 10,
                  child: Text(
                    "Maqtov yorlig'ini topshirish",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      options: CarouselOptions(
        height: 250,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }
}
