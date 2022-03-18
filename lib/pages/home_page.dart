import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/viewmodel/home_view_model.dart';
import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Practice"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel ,
        child: Consumer<HomeViewModel>(
          builder: (cts, model, index) => Stack(
            children: [
              ListView.builder(
                itemBuilder: (ctx,index){
                  return itemOfPost(viewModel,viewModel.items[index]);
                },
                itemCount: viewModel.items.length,
              ),
              viewModel.isLoading ? const Center(
                child: CircularProgressIndicator(),
              ) :SizedBox.shrink()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.add),
      ),
    );
  }
}
