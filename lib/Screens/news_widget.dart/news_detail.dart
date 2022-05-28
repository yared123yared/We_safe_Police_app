import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Models/new_model.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';
import 'package:wesafepoliceapp/Widgets/cached_custome_network_image.dart';

class NewsDetail extends StatelessWidget {
  static const routeName = 'wesafepoliceapp/newdetail';
  const NewsDetail(this.news, {Key? key}) : super(key: key);
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: CustomCachedNetworkImage(
                  url: news.image.toString(),
                  placeholder: 'assets/images/police_image_three.jpeg',
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                ),
                // Image.asset(
                //   'assets/images/police_image_three.jpeg',
                //   width: double.infinity,
                //   fit: BoxFit.fill,
                // ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          DateFormaterClass.formatDate(
                              DateTime.now().toIso8601String()),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  child: Row(children: [
                    const VerticalDivider(
                      color: Colors.blue,
                      thickness: 3.0,
                    ),
                    Expanded(
                      child: Text(
                        news.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                 Text(
                  news.body.toString(),
                  style: const TextStyle(
                    height: 1.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
