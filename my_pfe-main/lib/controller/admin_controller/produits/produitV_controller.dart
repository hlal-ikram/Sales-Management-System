import 'package:get/get.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/constant/routes.dart';
import 'package:my_pfe/data/model/categoriesModel.dart';
import '../../../core/function/handilingdata.dart';
import '../../../data/datasource/remote/adminData/produitData.dart';

class ProduitController extends GetxController {
  ProduitData produitData = ProduitData(Get.find());
  List<CategoriesModel> data = [];
  late StatusRequest statusRequest;
  getData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await produitData.get();
    statusRequest = handlingData(response);
    print("********************** $response");

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List datalist = response['data'];
        data.addAll(datalist.map((e) => CategoriesModel.fromJson(e)));

        //data.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  deleteProduit(int id, String imagename) {
    produitData.delete({"ProduitID": id.toString(), "Imagep": imagename});
    data.removeWhere((element) => element.ProduitID! == id);
    update();
  }

  goToPageEdit(CategoriesModel categoriesModel) {
    Get.toNamed(AppRoute.produitAEdit,
        arguments: {"categoriesModel": categoriesModel});
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
