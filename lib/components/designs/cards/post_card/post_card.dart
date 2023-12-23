// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/post_card/post_image.dart';
import 'package:sheeta/components/designs/global/papa.dart';
import 'package:sheeta/components/designs/cards/post_card/post_actions/parent.dart';
import 'package:sheeta/components/designs/cards/post_card/post_comments.dart';
import 'package:sheeta/components/designs/cards/post_card/post_date.dart';
import 'package:sheeta/components/designs/cards/post_card/post_headline.dart';
import 'package:sheeta/components/designs/cards/post_card/post_likes_count.dart';
import 'package:sheeta/components/designs/cards/post_card/post_title.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/sizes.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  UserData? user;

  fetchUser() async {
    var u = await Auth().getById(uid: widget.post.uid);
    setState(() {
      user = u;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    // post card parent
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: large),
          //* post headlinew
          PostHeadline(post: widget.post, user: user),
          const SizedBox(height: large),
          // post details (image, action area, likes count, title, comments, date)
          //* image
          PostImage(post: widget.post),
          const SizedBox(height: large - 8),

          //* action area
          PostActionArea(post: widget.post),
          const SizedBox(height: xs),

          //* post details
          Papa(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // * likes count
                PostLikesCount(likes: widget.post.likes),
                const SizedBox(height: xs),

                // * title
                PostTitle(user: user, description: widget.post.description),
                // * comments area
                const SizedBox(height: small - 3),
                PostComments(post: widget.post),
                const SizedBox(height: xs),

                // * date published
                PostDate(datePublished: widget.post.createdTime),
                const SizedBox(height: large),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
