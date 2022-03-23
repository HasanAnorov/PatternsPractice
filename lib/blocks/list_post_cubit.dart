import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_practice/blocks/list_post_state.dart';
import 'package:provider_practice/model/post_model.dart';
import 'package:provider_practice/pages/create_page.dart';
import 'package:provider_practice/pages/update_page.dart';
import '../service/network_service.dart';

class ListPostCubit extends Cubit<ListPostState>{
  ListPostCubit() :super(ListPostInit());

  void apiPostList() async {
    emit(ListPostLoading());
    final response = await NetworkService.GET(NetworkService.api_list, NetworkService.paramsEmpty());
    print(response);
    if(response != null){
      emit(ListPostLoaded(posts: NetworkService.parsePostList(response), isDeleted: true));
    }else{
      emit(ListPostError(error: "Could not fetch posts"));
    }
  }

  void apiPostDelete(Post post) async {
    emit(ListPostLoading());
    final response = await NetworkService.DELETE(NetworkService.api_delete + post.id.toString(), NetworkService.paramsEmpty());
    print(response);
    if(response != null){
      apiPostList();
    }else{
      emit(ListPostError(error: "Could not fetch posts"));
    }
  }

  void callCreatePage(BuildContext context) async {
    var results = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CreatePage()));
    if(results != null){
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }

  void callUpdatePage(BuildContext context,Post post) async{
    print(post.toJson());
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UpdatePage(
          post : post
        )));
    if(result != null){
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }
}