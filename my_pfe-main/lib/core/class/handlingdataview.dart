import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/constant/imagesasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(child: Lottie.asset(AppImageAsset.loading))
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: Lottie.asset(
                AppImageAsset.loading,
                // repeat: false,
              ))
            : statusRequest == StatusRequest.serverfailure
                ? const Center(child: Text("serverfailure"))
                : statusRequest == StatusRequest.failure
                    ? const Center(child: Text("No data"))
                    : widget;
  }
}
