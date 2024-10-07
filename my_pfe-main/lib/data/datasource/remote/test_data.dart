import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../core/class/crud.dart';

class TestData {
  Crud crud;
  TestData(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.testphp, {});
    return response.fold((l) => l, (r) => r);
  }
}
