import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../blocks/list_post_cubit.dart';
import '../model/post_model.dart';

Widget itemOfPost( BuildContext context, Post post){

  return Slidable(
    startActionPane: ActionPane(
      motion:const ScrollMotion(),

      // dismissible: DismissiblePane(onDismissed: (){
      //
      // },),

      children: [
        SlidableAction(
          flex: 1,
          onPressed: (context) => {
          BlocProvider.of<ListPostCubit>(context).apiPostDelete(post)
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),

      ],
    ),
    endActionPane:  ActionPane(
      motion:const ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          onPressed:(context) => {
            BlocProvider.of<ListPostCubit>(context).callUpdatePage(context,post)
          },
          backgroundColor: const Color(0xFF7BC043),
          foregroundColor: Colors.white,
          icon: Icons.update,
          label: 'Update',
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