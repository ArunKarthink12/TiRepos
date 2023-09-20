import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti/controller/nextpagewithdata.dart';

class SecondScreen extends StatefulWidget {
  var id;
  SecondScreen({super.key, required this.id});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  NextPageWithUserDataController nextPageWithUserDataController =
      Get.put(NextPageWithUserDataController());
  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

  fetchdata() {
    Future.delayed(
      Duration.zero,
      () async {
        await nextPageWithUserDataController.userfetchdatacontroller(
            id: widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (nextPageWithUserDataController.loadingindicator.value == false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (nextPageWithUserDataController.dataList.isEmpty) {
          return Center(
            child: Text("NO Datas"),
          );
        } else {
          return Center(
            child: Card(
              child: Container(
                alignment: Alignment.center,
                height: 250,
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  children: [
                    Image.network(nextPageWithUserDataController
                        .dataList.first.data.avatar
                        .toString()),
                    Text("ID : " +
                        nextPageWithUserDataController.dataList.first.data.id
                            .toString()),
                    Text("Name : " +
                        nextPageWithUserDataController
                            .dataList.first.data.firstName
                            .toString()),
                    Text("Email : " +
                        nextPageWithUserDataController.dataList.first.data.email
                            .toString()),
                    Text("lastName : " +
                        nextPageWithUserDataController
                            .dataList.first.data.lastName
                            .toString()),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
