import 'package:bankproj/models/mydata_model.dart';
import 'package:bankproj/models/user_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {

  RxList<DateTime> startDateTimes = <DateTime>[].obs;
  RxList<DateTime> endDateTimes = <DateTime>[].obs;

  RxList<UserModel> curentUserModels = <UserModel>[].obs;

  RxList<MyDataModel> myDataModels = <MyDataModel>[].obs;
  RxList<MyDataModel> detailMyDataModels = <MyDataModel>[].obs;
  RxList<String> docIdMyDatas = <String>[].obs;
}
