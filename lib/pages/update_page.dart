
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/blocks/update_post_cubit.dart';
import 'package:provider_practice/blocks/update_post_state.dart';
import 'package:provider_practice/model/post_model.dart';
import 'package:provider_practice/views/view_of_update.dart';

class UpdatePage extends StatelessWidget {

  //you should identify this
  Post post;

  UpdatePage({required this.post});

  bool isLoading = true;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  void _finish(BuildContext context){
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context,"result");
    });
  }

  @override
  Widget build(BuildContext context) {

    titleController.text = post.title;
    bodyController.text = post.body;

    return BlocProvider(
        create: (context) => UpdatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Update Post"),
          centerTitle: true,
        ),
        body: BlocBuilder<UpdatePostCubit,UpdatePostState>(
            builder: (BuildContext context, UpdatePostState state){
              if(state is UpdatePostLoading){
                String title = titleController.text.toString();
                String body = bodyController.text.toString();
                Post post = Post(id: this.post.id, title: title, body: body, userId: this.post.userId);
                return viewOfUpdate(context, true, post, titleController, bodyController);
              }
              if(state is UpdatePostLoaded){
                _finish(context);
              }
              return viewOfUpdate(context, false,post,  titleController, bodyController);
            }
        ),
      ),
    );
  }
}
