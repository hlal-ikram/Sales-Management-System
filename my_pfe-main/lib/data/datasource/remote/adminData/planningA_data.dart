import 'package:my_pfe/core/class/crud.dart';
import 'package:my_pfe/core/constant/linkapi.dart';

class PlanningAData {
  Crud crud;
  PlanningAData(this.crud);
  getData(String dateStart, String dateEnd) async {
    var response = await crud.postData(AppLink.consulterPlaningA,
        {"dateStart": dateStart, "dateEnd": dateEnd});
    return response.fold((l) => l, (r) => r);
  }
}
