import 'dart:io';

import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../../core/class/crud.dart';

class ProduitData {
  Crud crud;
  ProduitData(this.crud);

  get() async {
    var response = await crud.postData(AppLink.prodduitV, {});
    return response.fold((l) => l, (r) => r);
  }

  add(Map data, File file) async {
    var response =
        await crud.addRequestWithImageOne(AppLink.prodduitA, data, file);
    return response.fold((l) => l, (r) => r);
  }

  delete(Map data) async {
    var response = await crud.postData(AppLink.prodduitD, data);
    return response.fold((l) => l, (r) => r);
  }

  edit(Map data, [File? file]) async {
    dynamic response;
    if (file == null) {
      response = await crud.postData(AppLink.prodduitE, data);
    } else {
      response =
          await crud.addRequestWithImageOne(AppLink.prodduitE, data, file);
    }

    return response.fold((l) => l, (r) => r);
  }
}
