// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: CarouselSlider(
              options: CarouselOptions(
                  height: 400.0,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
              items: [
                'assets/images/police_image_one.jpg',
                'assets/images/police_image_two.jpg',
                'assets/images/police_image_three.jpeg'
              ].map((item) {
                return Builder(builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.3)),
                          child: const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ]),
                  );
                });
              }).toList()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [0, 1, 2]
              .map((item) => Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2.0,
                    ),
                    height: 3,
                    width: _currentIndex == item ? 20 : 7,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ))
              .toList(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: const Text(
            'Recent News',
            style: TextStyle(
              fontSize: 21.0,
              color: Color(0xff494848),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                width: 91,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/contact_img.png'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 200,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Lorem ipsum",
                            style: TextStyle(
                              color: Color(0xff535353),
                              fontSize: 18.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: const[
                          Text('Lorem ipsum dolot, lorem ipsum dolot, lorem ipsum,\n dolot, lorem ipsum, dolot lorem ipsum, dolot,lorem ipsum, dolot.', style: TextStyle(),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment : MainAxisAlignment.end,
                        children: const[
                          Text('Dec 22, 2021')
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
