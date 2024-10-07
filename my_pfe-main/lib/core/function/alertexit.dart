import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertexitApp() {
  Get.defaultDialog(
      title: "Attention",
      middleText: "do you went to go out",
      actions: [
        ElevatedButton(
            onPressed: () {
              exit(0);
            },
            child: const Text("Confirm")),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("cancel"))
      ]);

  return Future.value(true);
}
