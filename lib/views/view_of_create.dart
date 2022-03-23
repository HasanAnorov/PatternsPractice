import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/model/post_model.dart';

import '../blocks/create_post_cubit.dart';

Widget viewOfCreate(
    BuildContext context,
    bool isLoading,
    int id,
    int userId,
    TextEditingController titleController,
    TextEditingController bodyController
    ){

  return Container(
    padding: EdgeInsets.all(30),
    child: Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: titleController,
              decoration:const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
            TextField(
              controller: bodyController,
              decoration:const InputDecoration(
                  hintText: "Body",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FlatButton(
              color: Colors.grey,
              onPressed: (){
                Post post = Post(
                    id: id,
                    title: titleController.text.toString(),
                    body: bodyController.text.toString(),
                    userId: userId);
                BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
              },
              child:const Text(
                "Create a Post",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            )
          ],
        ),

        isLoading ? Center(
          child: CircularProgressIndicator(),
        ):SizedBox.shrink()
      ],
    ),
  );
}