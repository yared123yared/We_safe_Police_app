import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Screens/screens.dart';

class HomeHistory extends StatelessWidget {
  const HomeHistory({Key? key}) : super(key: key);

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
                "Recent History",
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
            Navigator.of(context).pushNamed(CaseDetail.routeName);
          },
          child: _buildHistoryItem()),
        _buildHistoryItem(),
        _buildHistoryItem(),
      ],
    );
  }

  Container _buildHistoryItem() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 10.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                ),
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
                Icons.delete,
                color: Color(0xff727272),
              ),
            )
          ],
        ),
      ),
    );
  }
}
