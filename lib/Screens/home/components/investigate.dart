import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wesafepoliceapp/Bloc/criminal_bloc/criminal_bloc.dart';
import 'package:wesafepoliceapp/Widgets/search_image.dart';

class InvetagatePage extends StatelessWidget {
  const InvetagatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CriminalBloc, CriminalState>(
        builder: (context, state) {
          if (state is CriminalInitial || state is CriminalLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CriminalLoaded) {
            return ListView(
              children: state.criminals
                  .map((_criminal) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              width: 80,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: _criminal.images!.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Icon(
                                        Icons.person,
                                        size: 50.0,
                                        color: Colors.grey.shade700,
                                      ))
                                  : Image.network(
                                      _criminal.images!.first.url!,
                                    ),
                            ),
                            Text(
                                '${_criminal.firstName} ${_criminal.lastName}'),
                          ],
                        ),
                      ))
                  .toList(),
            );
          } else {
            final CriminalError _ciminalErrorState = state as CriminalError;
            return Center(
              child: Text(_ciminalErrorState.errorMessage),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SearchImage.routeName);
        },
        child: const Icon(
          Icons.search,
        ),
      ),
    );
  }
}
