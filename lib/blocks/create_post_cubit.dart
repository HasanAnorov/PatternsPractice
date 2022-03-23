
import 'package:bloc/bloc.dart';
import 'package:provider_practice/blocks/create_post_state.dart';
import 'package:provider_practice/service/network_service.dart';

import '../model/post_model.dart';

class CreatePostCubit extends Cubit<CreatePostState>{

  CreatePostCubit() : super(CreatePostInit());

  void apiPostCreate(Post post) async{
    print(post.toJson());
    emit(CreatePostLoading());
    final response = await NetworkService.POST(NetworkService.api_create, NetworkService.paramsCreate(post));
    print(response);
    if(response != null){
     emit(CreatePostLoaded(isCreated: true));
    }else{
      emit(CreatePostError(error: "Couldn't create post !"));
    }
  }
}