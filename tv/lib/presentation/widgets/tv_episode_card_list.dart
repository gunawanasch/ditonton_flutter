import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TVEpisodeCard extends StatelessWidget {
  final TVEpisode tvEpisode;

  TVEpisodeCard(this.tvEpisode);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvEpisode.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  SizedBox(height: 16),
                  Text(
                    tvEpisode.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${tvEpisode.stillPath}',
                width: 80,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}