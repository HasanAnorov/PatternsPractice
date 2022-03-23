import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider_practice/blocks/list_post_cubit.dart';
import 'package:provider_practice/blocks/list_post_state.dart';
import 'package:provider_practice/views/view_of_home.dart';
import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var items =  <Post>[];

  void  onDelete(Post post){
    // apiDeletePost(post).then((value) => {
    //   if(value){
    //     _apiPostList(),
    //   }
    // });
  }
  void onEdit(){}


  @override
  void initState() {
    BlocProvider.of<ListPostCubit>(context).apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BloC"),
        centerTitle: true,
      ),
      body: BlocBuilder<ListPostCubit,ListPostState>(
        builder: (BuildContext context , ListPostState state){

          if(state is ListPostError){
            return viewOfHome(items, true);
          }

          if(state is ListPostLoaded){
            items = state.posts;
            return  viewOfHome(items, false);
          }

          return viewOfHome(items,true);

        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ListPostCubit>(context).callCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost( Post post){
    return Slidable(
      startActionPane: ActionPane(
        motion:const ScrollMotion(),

        // dismissible: DismissiblePane(onDismissed: (){
        //
        // },),

        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) => onDelete(post),
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
            onPressed:(context) => onEdit(),
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
}