import 'dart:convert';

import 'package:http/http.dart';

import '../model/post_model.dart';

class NetworkService{

  // static String BASE_URL = "api.github.com";
  static String BASE_URL = "jsonplaceholder.typicode.com";
  //static String BASE_URL = "dummy.restapiexample.com";
  static Map<String,String> headers = {"Content-Type":"application/json; charset=UTF-8"};

  /*Http apis*/
  // static String api_list = "/users/HasanAnorov";
  static String api_list = "/posts";
  //static String api_list = "/api/v1/employees";
  static String api_single_user = "/api/v1/employee/"; //id
  static String api_create = "/posts";
  static String api_put = "/posts/"; //{id}
  static String api_delete = "/posts/"; //{id}

  /*Http requests*/

  static Future<String?> GET(String api,Map<String,String> params) async{
    var uri = Uri.http(BASE_URL,api,params);
    print("request_url - $uri");
    var response = await get(uri,headers: headers);
    if(response.statusCode==200){
      print('success');
      return response.body;
    }else{
      return "Error";
    }
  }

  static Future<String?> POST(String api,Map<String,String> params) async{
    var uri = Uri.https(BASE_URL,api);
    var response = await post(uri,headers: headers,body: jsonEncode(params));
    if(response.statusCode==200 || response.statusCode == 201){
      return response.body;
    }else{
      return "Error";
    }
  }

  static Future<String?> PUT(String api,Map<String,String> params) async{
    var uri = Uri.https(BASE_URL,api);
    var response = await put(uri,headers: headers,body: jsonEncode(params));
    if(response.statusCode==200){
      return response.body;
    }else{
      return "Error";
    }
  }

  static Future<String?> DELETE(String api,Map<String,String> params) async{
    var uri = Uri.https(BASE_URL,api);
    var response = await post(uri,headers: headers,body: jsonEncode(params));
    if(response.statusCode==200){
      return response.body;
    }else{
      return "Error";
    }
  }

  /*Empty params*/
  static Map<String,String> paramsEmpty(){
    Map<String,String> params = Map();
    return params;
  }

  static Map<String,String> paramsCreate(Post post){
    Map<String,String> params = Map();
    params.addAll({
      'title':post.title,
      "body": post.body,
      'userId' : post.userId.toString(),
    });
    return params;
  }

  static Map<String,String> paramsUpdate(Post post){
    Map<String,String> params = Map();
    params.addAll({
      "id": post.id.toString(),
      'title':post.title,
      "body": post.body,
      'userId' : post.userId.toString(),
    });
    return params;
  }

  /*Http request parsing*/

  // static UserList parseUserList(String response){
  //   dynamic json = jsonDecode(response);
  //   var data  = UserList.fromJson(json);
  //   return data;
  // }
  //
  // static SingleUser parseSingleUser(String response){
  //   dynamic json = jsonDecode(response);
  //   var data  = SingleUser.fromJson(json);
  //   return data;
  // }

  static List<Post> parsePostList(String response){
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }

}