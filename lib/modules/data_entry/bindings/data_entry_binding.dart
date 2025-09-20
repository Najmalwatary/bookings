import 'package:get/get.dart';
import '../controllers/data_entry_controller.dart';

class DataEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataEntryController>(() => DataEntryController());
  }
}
