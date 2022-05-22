import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';
import 'package:wesafepoliceapp/Widgets/widgets.dart';

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
                  return GestureDetector(
                    onTap:(){
                      Navigator.of(context).pushNamed(LiveDetail.routeName);
                    },
                    child: LiveImage(
                      image: _images[index],
                      height: 250,
                    )
                  );
                })
          ],
        ));
  }
}
