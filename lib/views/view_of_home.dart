import 'package:flutter/material.dart';
import '../model/post_model.dart';
import 'item_of_post.dart';

Widget viewOfHome(List<Post> items, bool isLoading){
  return Stack(
    children: [
      ListView.builder(
        itemBuilder: (context,index){
          return itemOfPost(context,items[index]);
        },
        itemCount: items.length,
      ),
      isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) :const SizedBox.shrink()
    ],
  );
}