import 'package:scoped_model/scoped_model.dart';

import '../model/post_model.dart';
import '../service/network_service.dart';

class HomeScoped extends Model{

  bool isLoading = false;
  var items =  <Post>[];

  void  onDelete(Post post){
    apiDeletePost(post).then((value) => {
      if(value){
        apiPostList(),
      }
    });
  }
  void onEdit(){}

  Future apiPostList() async{

      isLoading = true;
      notifyListeners();

    var response = await NetworkService.GET(NetworkService.api_list, NetworkService.paramsEmpty());

      if(response !=null){
        print("response not null");
        items = NetworkService.parsePostList(response);
      }
      isLoading = false;
      notifyListeners();
  }

  void apiUpdatePost(Post post) async {

      isLoading = true;
      notifyListeners();

    var response = await NetworkService.PUT(NetworkService.api_put+post.id.toString(), NetworkService.paramsUpdate(post));

      if(response !=null){
        apiPostList();
      }else{
        items = List<Post>.empty();
      }
      isLoading = false;
      notifyListeners();
  }

  Future<bool> apiDeletePost(Post post) async{

    isLoading = true;
    notifyListeners();

    var response = await NetworkService.PUT(NetworkService.api_delete+post.id.toString(), NetworkService.paramsEmpty());

      isLoading =false;
      notifyListeners();

    return response!=null;

  }
}