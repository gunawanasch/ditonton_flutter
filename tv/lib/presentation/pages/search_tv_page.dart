import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SearchTVPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTVBloc>().add(OnQueryChangedTV(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVBloc, SearchTVState>(
              builder: (context, state) {
                if (state is SearchTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTVHasData) {
                  final result = state.result;
                  if (result.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = result[index];
                          return TVCard(tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('Result is empty'),
                      ),
                    );
                  }
                } else if (state is SearchTVError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}