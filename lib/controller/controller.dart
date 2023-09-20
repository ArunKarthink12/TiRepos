import 'package:get/get.dart';
import 'package:ti/model/firstscreenmodel.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ti/service/firstscreenservice.dart';

class Controller extends GetxController {
  var pagnationscreen = 1;
  var clint = FirsCreenService();
  RxList<Welcome> dataList = <Welcome>[].obs;
  RxBool loadingindicator = false.obs;
  fetchDataController() async {
    try {
      var data = await clint.fetchData();
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
