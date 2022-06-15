import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/case_bloc/case_bloc.dart';
import 'package:wesafepoliceapp/Dataprovider/dataprovider.dart';
import 'package:wesafepoliceapp/Models/models.dart';
import 'package:wesafepoliceapp/Repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:wesafepoliceapp/Screens/screens.dart';
import 'package:wesafepoliceapp/Utils/utils.dart';

class HomeCase extends StatefulWidget {
  const HomeCase({Key? key}) : super(key: key);

  @override
  State<HomeCase> createState() => _HomeCaseState();
}

class _HomeCaseState extends State<HomeCase> {
  List<Case> _policeCases = [];
  @override
  Widget build(BuildContext context) {
    final _repository = CaseRepository(
      dataProvider: CaseDataProvider(
        httpClient: http.Client(),
      ),
    );
    return BlocProvider(
      lazy: false,
      create: (context) => CaseBloc(repository: _repository)
        ..add(const FetchCaseByPoliceId(false)),
      child: BlocConsumer<CaseBloc, CaseState>(
        listener: (context, state) {
          if (state is CaseDeleteSuccess) {}
        },
        builder: (context, state) {
          // debugPrint('The state is $state');
          if (state is CaseLoading || state is CaseInitial) {
            debugPrint('<============== Loading ==============>');
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (state is CaseDeleteSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Cases",
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
                  Column(
                      children: _policeCases
                          .map(
                            (policeCase) =>
                                _buildHistoryItem(context, policeCase),
                          )
                          .toList())
                ],
              ),
            );
          } else if (state is CaseLoaded) {
            _policeCases = state.policeCases;
            debugPrint('${state.policeCases}');
            return SingleChildScrollView(
              child: Column(
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
                  Column(
                      children: _policeCases
                          .map(
                            (policeCase) =>
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(CaseDetail.routeName, arguments: policeCase);
                                  },
                                  child: _buildHistoryItem(context, policeCase)),
                          )
                          .toList())
                ],
              ),
            );
          } else {
            late CaseError _caseState = state as CaseError;
            return Center(
              child: Text(
                _caseState.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ),
    );
  }

  Container _buildHistoryItem(
    BuildContext context,
    Case policeCase,
  ) {
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
            Expanded(
              child: Row(
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
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    policeCase.summary!,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        height: 1.5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Color(0xff494848)),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    policeCase.description!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      height: 1.5,
                                      color: Color(0xff797070),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormaterClass.formatDate(policeCase.openedDate.toString()),
                                  style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 11,
                                    color: Color(0xff797070),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
        
            IconButton(
              onPressed: () {
                // BlocProvider.of<CaseBloc>(context)
                //     .add(DeleteCase(policeCase.id.toString()));
                // BlocProvider.of<CaseBloc>(context).add(
                //   const FetchCaseByPoliceId(true),
                // );
              },
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
