import 'package:get/get.dart';
import '../model/post_model.dart';
import '../service/network_service.dart';

class HomeController extends GetxController{

  var isLoading = false.obs;
  var items = <Post>[].obs;

  void  onDeletePost(Post post){
    apiDeletePost(post).then((value) => {
      if(value){
        apiPostList(),
      }
    });
  }
  void onEdit(){}

  Future apiPostList() async{

      isLoading(true);

    var response = await NetworkService.GET(NetworkService.api_list, NetworkService.paramsEmpty());

      if(response !=null){
        print("response not null");
        items.value = NetworkService.parsePostList(response);
      }
      isLoading(false);
  }

  void apiUpdatePost(Post post) async {

      isLoading(true);

    var response = await NetworkService.PUT(NetworkService.api_put+post.id.toString(), NetworkService.paramsUpdate(post));

      if(response !=null){
        apiPostList();
      }else{
        items.value = List<Post>.empty();
      }
      isLoading(false);
  }

  Future<bool> apiDeletePost(Post post) async{
    isLoading(true);
    var response = await NetworkService.PUT(NetworkService.api_delete+post.id.toString(), NetworkService.paramsEmpty());
    isLoading(false);
    return response!=null;
  }

}