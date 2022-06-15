import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Screens/live_detail/map_detail.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({Key? key}) : super(key: key);

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Alerts",
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: const [
                  Icon(
                    Icons.filter_alt_rounded,
                    color: Colors.pink,
                  ),
                  Text('Filter')
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(MapDetail.routeName, arguments: const LatLng(8.980603, 38.757759));
          },
          child: _buildNamesNames(),
          ),
        _buildNamesNames(),
        _buildNamesNames(),
      ],
    );
  }
  Widget _buildNamesNames() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Lorem Ipsum is',
                                style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color(0xff494848)),
                              ),
                              Text(
                                'dummy text of printing',
                                style: TextStyle(
                                  height: 1.5,
                                  color: Color(0xff797070),
                                ),
                              ),
                              Text(
                                'Dec 22,2022',
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 11,
                                  color: Color(0xff797070),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.flag,
                    color: Color(0xff727272),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Divider(
            thickness: 0.8,
            color: Color.fromARGB(255, 219, 212, 212),
          )
        ],
      ),
    );
  }
}
