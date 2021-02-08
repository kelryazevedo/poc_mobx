import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poc_mobx/src/components/infinite_list_widget.dart';
import 'package:poc_mobx/src/model/ResultGitHubDTO.dart';
import 'package:poc_mobx/src/screens/home/home_controller.dart';
import 'package:poc_mobx/src/utils/colors_style.dart';
import 'package:poc_mobx/src/utils/global.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyle.white,
      appBar: AppBar(
        title: Text("GitHub"),
      ),
      body: Observer(
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    if (value.length >= 3 ) controller.searchList(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Busca..."),
                ),
              ),
              Expanded(child: Observer(
                builder: (_) {
                  if (!controller.listUsers.isDone) {
                    return Center(
                      child: Text(
                        'Quem você procura?',
                        style: TextStyle(fontSize: 14, color: ColorsStyle.grey),
                      ),
                    );
                  }

                  if (controller.listUsers.isPending) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return InfiniteListWidget(
                    key: Key("listUsers"),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    noResultString: 'Não encontramos usuarios com este nome...',
                    itemBuilder: (_, index) {
                      var user = controller.listUsers.getData[index];
                      return _buildItem(user);
                    },
                    itemCount: controller.listUsers.getData.length,
                    hasNext: controller.listUsers.hasNextPage,
                    nextData: () {
                      controller.searchList("kelry");
                    },
                  );
                },
              ))
            ],
          );
        },
      ),
    );
  }

  _buildItem(ResultSearchModel result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(result.avatar_url),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result.login ?? "",
                style: TextStyle(
                    fontSize: 14,
                    color: ColorsStyle.grey,
                    fontWeight: FontWeight.bold),
              ),
              Text(result.html_url ?? "",
                  style: TextStyle(fontSize: 14, color: ColorsStyle.grey))
            ],
          )
        ],
      ),
    );
  }
}
