import 'package:flutter/material.dart';

class HomeLive extends StatefulWidget {
  const HomeLive({Key? key}) : super(key: key);

  @override
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
  final List<String> _images = [
    "assets/images/giraffe.png",
    'assets/images/contact_img.png',
    "assets/images/giraffe.png",
    "assets/images/wallpaper.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Currently Live',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(_images[index]),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        left: 10.0,
                        top: 10.0,
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "live",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                )),
                            child: Row(children: const [
                              Text(
                                '200',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text('Viewers',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))
                            ]),
                          ))
                    ],
                  );
                })
          ],
        ));
  }
}
