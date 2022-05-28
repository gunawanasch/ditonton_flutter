import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv_injection.dart';

class TopRatedTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  final TopRatedTVBloc _topRatedTVBloc = locator<TopRatedTVBloc>();
  
  @override
  void initState() {
    _topRatedTVBloc.add(TopRatedTV());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
          bloc: _topRatedTVBloc,
          builder: (context, state) {
            if (state is TopRatedTVInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTVSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTVError) {
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