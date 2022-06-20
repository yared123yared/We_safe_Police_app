import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wesafepoliceapp/Bloc/user_alert_bloc/useralert_bloc.dart';
import 'package:wesafepoliceapp/Models/alert_model.dart';
import 'package:wesafepoliceapp/Screens/live_detail/map_detail.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({Key? key}) : super(key: key);

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UseralertBloc()..add(GetUserALert()),
      child: BlocBuilder<UseralertBloc, UseralertState>(
        builder: (context, state) {
          if (state is UseralertInitial || state is UserAlertLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserAlertError) {
            return Text(state.message);
          }

          UserAlertLoaded alertLoaded = state as UserAlertLoaded;
          return ListView(
            children: alertLoaded.userAlerts
                .map((alert) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(MapDetail.routeName,
                            arguments:  LatLng(alert.latitude!, alert.longtiude!));
                      },
                      child: _buildNamesNames(alert),
                    ))
                .toList()
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Recent Alerts",
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //       Row(
            //         children: const [
            //           Icon(
            //             Icons.filter_alt_rounded,
            //             color: Colors.pink,
            //           ),
            //           Text('Filter')
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            ,
          );
        },
      ),
    );
  }

  Widget _buildNamesNames(UserAlert alert) {
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
                            children: [
                              // Container(
                              //   width: double.infinity,
                              //   height:120,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //         fit: BoxFit.cover,
                              //         image: NetworkImage(alert
                              //             .alertedBy!.person!.picture
                              //             .toString())),
                              //   ),
                              // ),
                              Text(
                                '${alert.alertedBy!.person!.firstName} ${alert.alertedBy!.person!.lastName}',
                                style: const TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color(0xff494848)),
                              ),
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
