import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/news_bloc/news_bloc.dart';
import 'package:wesafepoliceapp/Models/new_model.dart';
import 'package:wesafepoliceapp/Screens/news_widget.dart/news_detail.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';
import 'package:wesafepoliceapp/Widgets/cached_custome_network_image.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial || state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewsLoaded) {
          return SingleChildScrollView(
            child: Column(
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
                      items: state.newsDatas.map((news) {
                        return Builder(builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(children: [
                              Container(
                                height: 250,
                                width: double.infinity,
                                child: CustomCachedNetworkImage(
                                    url: news.image.toString(),
                                    borderRadius: BorderRadius.circular(10.0),
                                    placeholder:
                                        'assets/images/police_image_three.jpeg',
                                    boxFit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 250),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.3)),
                                  child: Text(
                                    news.title.toString(),
                                    style: const TextStyle(
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: const Text(
                    'Recent News',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Color(0xff494848),
                    ),
                  ),
                ),
                Column(
                    children: state.newsDatas
                        .map(
                          (news) => GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed(
                                NewsDetail.routeName,
                                arguments: news
                              );
                            },
                            child: _buildRecentNew(news),
                          ),
                        )
                        .toList())
              ],
            ),
          );
        } else {
          NewsError _errorState = state as NewsError;
          return Center(
            child: Text(_errorState.errorMessage),
          );
        }
      },
    );
  }

  Container _buildRecentNew(NewsModel newsModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 91,
            height: 100,
            child: CustomCachedNetworkImage(
              url: newsModel.image.toString(),
              placeholder: 'assets/images/contact_img.png',
              width: 91,
              boxFit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              width: 200,
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              // color: Colors.blue,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            newsModel.title.toString(),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Color(0xff535353),
                              fontSize: 18.0,
                            ),
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
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(
                            newsModel.subTitle.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(DateFormaterClass.formatDate(newsModel.postedDate!))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
