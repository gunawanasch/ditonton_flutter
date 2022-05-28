import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv_injection.dart';

class PopularTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  final PopularTVBloc _popularTVBloc = locator<PopularTVBloc>();
  
  @override
  void initState() {
    _popularTVBloc.add(PopularTV());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVBloc, PopularTVState>(
          bloc: _popularTVBloc,
          builder: (context, state) {
            if (state is PopularTVInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTVError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          }
        ),
      ),
    );
  }
}