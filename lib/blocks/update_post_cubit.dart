

import 'package:bloc/bloc.dart';
import 'package:provider_practice/blocks/update_post_state.dart';
import 'package:provider_practice/model/post_model.dart';
import 'package:provider_practice/service/network_service.dart';

class UpdatePostCubit extends Cubit<UpdatePostState>{
  UpdatePostCubit() : super(UpdatePostInit());

  void apiPostUpdate(Post post) async{

    //post.userId = 1;
    print(post.toJson());
    emit(UpdatePostLoading());
    final response = NetworkService.PUT(NetworkService.api_put + post.id.toString(), NetworkService.paramsUpdate(post));
    print("--------------response-------------$response");
    if(response != null){
      emit(UpdatePostLoaded(isUpdated:  true));
    }else{
      emit(UpdatePostError(error: "Couldn't update Post !"));
    }
  }
}