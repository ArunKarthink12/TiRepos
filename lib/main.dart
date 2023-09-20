import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti/controller/secondpagecontroller.dart';
import 'package:ti/view/secondscreen.dart';

import 'controller/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirstScreen());
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Controller controller = Get.put(Controller());

  SecondPageController secondPageController = Get.put(SecondPageController());
  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    secondfetchdata();
    super.initState();
  }

  fetchdata() {
    Future.delayed(
      Duration.zero,
      () async {
        await controller.fetchDataController();
      },
    );
  }

  secondfetchdata() {
    Future.delayed(
      Duration.zero,
      () async {
        await secondPageController.secondfetchDataController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                value == 0
                    ? controller.pagnationscreen = 1
                    : controller.pagnationscreen = 2;
                print(controller.pagnationscreen);
              });
            },
            selectedFontSize: 0,
            unselectedFontSize: 0,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.contact_page_rounded),
              ),
              BottomNavigationBarItem(
                  label: '', icon: Icon(Icons.contact_page_rounded))
            ]),
        body: SafeArea(
          child: SizedBox(child: SingleChildScrollView(child: Obx(() {
            if (controller.pagnationscreen == 1
                ? controller.loadingindicator.value == false
                : secondPageController.loadingindicator.value == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.pagnationscreen == 2
                ? secondPageController.dataList.isEmpty
                : controller.dataList.isEmpty) {
              return Center(
                child: Text("No Datas"),
              );
            } else {
              return Center(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.pagnationscreen == 1
                      ? controller.dataList.first.data.length
                      : secondPageController.dataList.first.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var datasfetch = controller.dataList.first.data;
                    var seconddatasfetch =
                        secondPageController.dataList.first.data;
                    if (controller.pagnationscreen == 1) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(SecondScreen(
                            id: datasfetch[index].id,
                          ));
                        },
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: NetworkImage(datasfetch[index].avatar),
                                  fit: BoxFit.cover,
                                  opacity: 0.4)),
                          child: Text(
                            datasfetch[index].firstName.toString(),
                            style: TextStyle(
                                fontFamily: '.SF UI Text',
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Get.to(SecondScreen(id: seconddatasfetch[index].id));
                        },
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      seconddatasfetch[index].avatar),
                                  fit: BoxFit.cover,
                                  opacity: 0.4)),
                          child: Text(
                            seconddatasfetch[index].firstName.toString(),
                            style: TextStyle(
                                fontFamily: '.SF UI Text',
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }
          }))),
        ));
  }
}
