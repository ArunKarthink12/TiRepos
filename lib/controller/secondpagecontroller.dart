import 'package:get/get.dart';
// import 'package:ti/model/firstscreenmodel.dart';
import 'package:ti/model/secondpagemodel.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:ti/service/secondpageservice.dart';

class SecondPageController extends GetxController {
  var clint = SecondScreenService();
  RxList<Second> dataList = <Second>[].obs;
  RxBool loadingindicator = false.obs;
  secondfetchDataController() async {
    try {
      var data = await clint.secondfetchData();
      if (data != null) {
        loadingindicator(false);
        dataList.clear();
        dataList.add(data);
        loadingindicator(true);
      } else {
        loadingindicator(true);
      }
    } catch (e) {
      print(e);
    }
  }
}
