import 'package:flutter/material.dart';

import '../../../core/constant/imagesasset.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Image.asset(
      AppImageAsset.logoFac,

      height: 200,
      // width: 00,
    ));
  }
}
