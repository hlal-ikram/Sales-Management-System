import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/auth/login_controller.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/function/alertexit.dart';
import 'package:my_pfe/core/function/valideInput.dart';
import 'package:my_pfe/view/screen/auth/logoauth.dart';
import 'package:my_pfe/view/widget/auth/custombuttomauth.dart';

import '../../../core/constant/color.dart';
import '../../widget/auth/customtextfromauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundcolor,
        elevation: 0.0,
        title: Text('',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColor.grey)),
      ),
      body: WillPopScope(
          onWillPop: alertexitApp,
          child: GetBuilder<LoginController>(
            builder: (controller) => controller.statusRequest ==
                    StatusRequest.loading
                ? const Center(
                    child: Text("loading"),
                  )
                : Form(
                    key: controller.formstate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: ListView(children: [
                        const LogoAuth(),
                        const SizedBox(height: 15),
                        const CustomTextTitleAuth(text: "Welcome Back"),
                        const SizedBox(height: 10),
                        CustonTextFormAuth(
                          valid: (val) {
                            return validInput(val!, 1, 100, "idjh");
                          },
                          hinttext: "Entrer Votre Id",
                          iconData: Icons.person_rounded,
                          labeltext: "id",
                          mycontroller: controller.id,
                        ),
                        GetBuilder<LoginController>(
                          builder: (controller) => CustonTextFormAuth(
                            obscuretext: controller.isshowpassord,
                            onTapIcon: () {
                              controller.showPassword();
                            },
                            valid: (val) {
                              return validInput(val!, 1, 100, "mot de passe");
                            },
                            hinttext: "Entrer Votre mot de passe",
                            iconData: Icons.lock_outline,
                            labeltext: "mot de passe",
                            mycontroller: controller.cin,
                          ),
                        ),
                        CustomButtomAuth(
                          text: "se connecter",
                          onPressed: () {
                            controller.login();
                          },
                          //  width: 100,
                        ),
                      ]),
                    ),
                  ),
          )),
    );
  }
}
