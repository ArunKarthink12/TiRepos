import 'package:get/get.dart';
import 'package:ti/model/userdatamodel.dart';

import 'package:ti/service/userdataservice.dart';

class NextPageWithUserDataController extends GetxController {
  var clint = UserDataService();
  RxList<SingleuserModelData> dataList = <SingleuserModelData>[].obs;
  RxBool loadingindicator = false.obs;
  userfetchdatacontroller({id}) async {
    try {
      var data = await clint.userservicedata(id: id);
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
