import 'dart:io';

import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../../core/class/crud.dart';

class GetVendeursData {
  Crud crud;
  GetVendeursData(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.getAllV, {});
    return response.fold((l) => l, (r) => r);
  }

  postdata(String id, String action) async {
    var response = await crud.postData(AppLink.bloquerV, {
      "id": id,
      "action": action,
    });
    //print(response);
    return response.fold((l) => l, (r) => r);
  }

  getvedeurbyid(String id) async {
    var response = await crud.postData(AppLink.getvendeurById, {
      "idv": id,
    });
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getadminbyid(String id) async {
    var response = await crud.postData(AppLink.getadminById, {
      "idv": id,
    });
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  editProfile(String id, [File? file]) async {
    var response = await crud.addRequestWithImageOne(
        AppLink.editUsersProfile, {"id": id}, file);
    return response.fold((l) => l, (r) => r);
  }
}
