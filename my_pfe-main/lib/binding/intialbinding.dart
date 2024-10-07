import 'package:get/get.dart';
import 'package:my_pfe/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
