import 'package:flutter/material.dart';

class LiveImage extends StatelessWidget {
  final String image;
  final double height;
  const LiveImage({
    required this.image,
    required this.height,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill)),
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
          ),
        )
      ],
    );
  }
}
