import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_practice/controller/homr_controlller.dart';
import 'package:provider_practice/pages/detail_page.dart';

import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  static const id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = Get.put(HomeController());

  @override
  void initState() {
    _controller.apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Patterns Practice"),
        centerTitle: true,
      ),
      body: Obx(
          () => Stack(
            children: [
              ListView.builder(
                itemBuilder: (ctx,index){
                  return itemOfPost(_controller, _controller.items[index]);
                },
                itemCount: _controller.items.length,
              ),
              _controller.isLoading() ? const Center(
                child: CircularProgressIndicator(),
              ) :const SizedBox.shrink()
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, route);
          // Navigator.pushNamed(context, routeName);

          Get.to(DetailPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}