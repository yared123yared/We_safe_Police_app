import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';

class CaseDetail extends StatefulWidget {
  static const routeName = 'wesafepoliceapp/casedetail';

  const CaseDetail({Key? key}) : super(key: key);

  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 132, 129, 129),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Lorem Ipsum Is',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Dec 22, 2022',
                    style: kDateTimeTextStyle,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.question_mark,
                  color: Colors.white,
                  size: 15,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          IntrinsicHeight(
            child: SizedBox(
              height: 30.0,
              child: Row(children: const [
                VerticalDivider(
                  color: Colors.blue,
                  thickness: 3.0,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Flexible(
            child: Text(
              loremIpsum + loremIpsum,
              style: TextStyle(
                height: 1.5,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
