import 'package:flutter/material.dart';


class HomeLive extends StatefulWidget {
  const HomeLive({ Key? key }) : super(key: key);

  @override
  State<HomeLive> createState() => _HomeLiveState();
}

class _HomeLiveState extends State<HomeLive> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Live page"),
    );
  }
}