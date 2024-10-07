import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../../core/class/crud.dart';

class ConsulterCommandeData {
  Crud crud;
  ConsulterCommandeData(this.crud);

  getvendeurOnservice() async {
    var response = await crud.postData(AppLink.getAllVS, {});
    return response.fold((l) => l, (r) => r);
  }

  getCommandeFac(int? vendeurID, String datee) async {
    var response = await crud.postData(AppLink.consultercommande,
        {"vendeurID": vendeurID.toString(), "dateSaisie": datee});
    return response.fold((l) => l, (r) => r);
  }
}
