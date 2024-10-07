import 'package:my_pfe/core/class/crud.dart';
import 'package:my_pfe/core/constant/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postdata(String id, String cin) async {
    var response = await crud.postData(AppLink.linkLogin, {
      "id": id,
      "cin": cin,
    });
    return response.fold((l) => l, (r) => r);
  }
}
