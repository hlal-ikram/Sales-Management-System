import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/admin_controller/ajouterrespo_controller.dart';
import '../../../core/function/valideInput.dart';
import '../../widget/auth/custombuttomauth.dart';
import '../../widget/auth/customtextfromauth.dart';

class AjouterRespo extends StatelessWidget {
  const AjouterRespo({super.key});

  @override
  Widget build(BuildContext context) {
    AjouterAdminController controller = Get.put(AjouterAdminController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Minoterie Othman ")),
      ),
      body: Form(
        key: controller.formstate,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  "Ajouter responsable ",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      decorationThickness: 60,
                      overflow: TextOverflow.clip),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 1, 100, "id");
              },
              mycontroller: controller.id,

              // hinttext: " Id",
              iconData: Icons.open_in_full_outlined,
              labeltext: "Id",
              // mycontroller: ,
            ),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 3, 100, "mot de passe");
              },
              mycontroller: controller.cin,
              // hinttext: "mot de passe",
              iconData: Icons.lock_outline,
              labeltext: "Mot de passe",
            ),
            Center(
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CustomButtomAuth(
                        text: "Enregister",
                        onPressed: () {
                          controller.enregister();
                        },
                        width: 150,
                      ),
                    ),
                    CustomButtomAuth(
                      text: "Annuler",
                      onPressed: () {
                        controller.annuler();
                      },
                      width: 120,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
