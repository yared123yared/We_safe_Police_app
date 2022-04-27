import 'package:flutter/material.dart';


class HomeReport extends StatefulWidget {
  const HomeReport({ Key? key }) : super(key: key);

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
       
      ],
    );
  }
}