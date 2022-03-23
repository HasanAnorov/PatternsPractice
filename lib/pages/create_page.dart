
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/blocks/create_post_cubit.dart';
import 'package:provider_practice/blocks/create_post_state.dart';
import 'package:provider_practice/views/view_of_create.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  var id = 12;
  var userId = 12;

  void _finish(BuildContext context){
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context,"result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Post"),
          centerTitle: true,
        ),
        body: BlocBuilder<CreatePostCubit,CreatePostState>(
          builder: (BuildContext context, CreatePostState state){
            if(state is CreatePostLoading){
              return viewOfCreate(context, true, id, userId, titleController, bodyController);
            }
            if(state is CreatePostLoaded){
              _finish(context);
            }
            return viewOfCreate(context, false, id, userId, titleController, bodyController);
          }
        ),
      ),
    );
  }
}
