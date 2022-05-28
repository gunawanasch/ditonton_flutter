import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/get_watchlist_tv_bloc.dart';
import 'package:tv/presentation/provider/watchlist_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv_injection.dart';

class WatchlistTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTVPageState createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage>
    with RouteAware {
  GetWatchlistTVBloc _getWatchlistTVBloc = locator<GetWatchlistTVBloc>();
  
  @override
  void initState() {
    _getWatchlistTVBloc.add(LoadWatchlistTV());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTVNotifier>(context, listen: false)
        .fetchWatchlistTV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetWatchlistTVBloc, GetWatchlistTVState>(
          bloc: _getWatchlistTVBloc,
          builder: (context, state) {
            if (state is GetWatchlistTVInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetWatchlistTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetWatchlistTVSuccess) {
              if (state.result.isEmpty) {
                return const Center(
                  child: Text('Data is empty'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.result[index];
                    return TVCard(tv);
                  },
                  itemCount: state.result.length,
                );
              }
            } else if (state is GetWatchlistTVError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}