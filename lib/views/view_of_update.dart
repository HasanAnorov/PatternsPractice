import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/blocks/update_post_cubit.dart';
import 'package:provider_practice/model/post_model.dart';

Widget viewOfUpdate(
    BuildContext context,
    bool isLoading,
    Post post,
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
              color: Colors.blue,
              onPressed: (){
                BlocProvider.of<UpdatePostCubit>(context).apiPostUpdate(post);
              },
              child:const Text(
                "Update a Post",
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