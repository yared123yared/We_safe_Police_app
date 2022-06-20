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
                  .map((_criminal) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    elevation: 4.0,
                    child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                width: double.infinity,
                                height: 200.0,
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
                                    : Container(
                                      decoration: BoxDecoration(
                                        
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_criminal.images!.first.url!)
                                        )
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                  '${_criminal.firstName} ${_criminal.lastName}', style: const  TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 20.0),
                              const Text(
                                text_is,
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
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



const text_is =   '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
''';