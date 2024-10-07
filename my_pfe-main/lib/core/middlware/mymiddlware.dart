import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/core/constant/routes.dart';
import 'package:my_pfe/core/serices.dart';

class MyMiddlWare extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("setp") == "2" &&
        myServices.sharedPreferences.getString("type") == "admin") {
      return const RouteSettings(name: AppRoute.homaAdmin);
    }
    if (myServices.sharedPreferences.getString("setp") == "2" &&
        myServices.sharedPreferences.getString("type") == "vendeur") {
      return const RouteSettings(name: AppRoute.homaVendeur);
    }
    return null;
  }
}
