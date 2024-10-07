import 'dart:io';

import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../../core/class/crud.dart';

class EditProfileData {
  Crud crud;
  EditProfileData(this.crud);

  editProfile([File? file]) async {
    var response =
        await crud.addRequestWithImageOne(AppLink.prodduitE, {}, file);
    return response.fold((l) => l, (r) => r);
  }
}
