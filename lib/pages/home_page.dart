import 'package:flutter/material.dart';
import 'package:provider_practice/scopes/home_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeScoped scoped = HomeScoped();

  @override
  void initState() {
    scoped.apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scoped Model Practice"),
        centerTitle: true,
      ),
      body: ScopedModel<HomeScoped>(
        model: scoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (context, child, model) {
            return Stack(
              children: [
                ListView.builder(
                  itemBuilder: (ctx,index){
                    return itemOfPost(scoped,scoped.items[index]);
                  },
                  itemCount: scoped.items.length,
                ),
                scoped.isLoading ? const Center(
                  child: CircularProgressIndicator(),
                ) :const SizedBox.shrink()
              ],
            );
          }),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.add),
      ),
    );
  }

}