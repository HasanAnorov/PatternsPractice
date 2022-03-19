import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/post_model.dart';
import '../service/network_service.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;
  var items =  <Post>[];

  void  onDelete(Post post){
    apiDeletePost(post).then((value) => {
      if(value){
        _apiPostList(),
      }
    });
  }
  void onEdit(){}

  Future _apiPostList() async{

    setState(() {
      isLoading = true;
    });

    var response = await NetworkService.GET(NetworkService.api_list, NetworkService.paramsEmpty());

    //set state
    setState(() {
      if(response !=null){
        print("response not null");
        items = NetworkService.parsePostList(response);
      }
      isLoading = false;
    });
  }

  void _apiUpdatePost(Post post) async {

    setState(() {
      isLoading = true;
    });

    var response = await NetworkService.PUT(NetworkService.api_put+post.id.toString(), NetworkService.paramsUpdate(post));

    setState(() {
      if(response !=null){
        _apiPostList();
      }else{
        items = List<Post>.empty();
      }
      isLoading = false;
    });
  }

  Future<bool> apiDeletePost(Post post) async{

    isLoading = true;

    var response = await NetworkService.PUT(NetworkService.api_delete+post.id.toString(), NetworkService.paramsEmpty());

    setState(() {
      if(response != null){
        _apiPostList();
      }else{
        items = List<Post>.empty();
      }
      isLoading =false;
    });

    return response!=null;
  }

  @override
  void initState() {
    _apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MobX Practice"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (ctx,index){
              return itemOfPost(items[index]);
            },
            itemCount: items.length,
          ),
          isLoading ? const Center(
            child: CircularProgressIndicator(),
          ) :const SizedBox.shrink()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
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