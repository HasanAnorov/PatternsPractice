import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider_practice/viewmodel/home_view_model.dart';
import '../model/post_model.dart';

Widget itemOfPost(HomeViewModel viewModel, Post post){
  return Slidable(
    startActionPane: ActionPane(
      motion:  ScrollMotion(),

      // dismissible: DismissiblePane(onDismissed: (){
      //
      // },),

      children: [
        SlidableAction(
          flex: 1,
          onPressed: (context) => viewModel.onDelete(post),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),

      ],
    ),
    endActionPane:  ActionPane(
      motion: ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          onPressed:(context) => viewModel.onEdit(),
          backgroundColor: const Color(0xFF7BC043),
          foregroundColor: Colors.white,
          icon: Icons.archive,
          label: 'Archive',
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title.toUpperCase(),
            style:const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5,),
          Text(post.body)
        ],
      ),
    ),
  );
}