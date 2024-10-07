import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/ajouterVendeur_controller.dart';
import 'package:my_pfe/core/function/valideInput.dart';
import '../../widget/auth/custombuttomauth.dart';
import '../../widget/auth/customtextfromauth.dart';

class AjouterVendeur extends StatelessWidget {
  const AjouterVendeur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AjouterVendeurController controller = Get.put(AjouterVendeurController());
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
                  "Ajouter Vendeur ",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      decorationThickness: 60,
                      overflow: TextOverflow.clip),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Center(
            //     child: Text(
            //       "Ajouter Vendeur",
            //       style: TextStyle(
            //         color: Colors.green,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 1, 100, "nom");
              },
              mycontroller: controller.nomv,
              //  hinttext: "  Nom ",
              iconData: Icons.person_outline,
              labeltext: "Le nom ",
            ),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 1, 100, "prenom");
              },
              mycontroller: controller.prenomv,
              // hinttext: " Prenom ",
              iconData: Icons.person_outline,
              labeltext: " Le prenom",
            ),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 10, 10, "phone");
              },
              mycontroller: controller.telev,
              //hinttext: "Numero de Telephone",
              iconData: Icons.phone_android_outlined,
              labeltext: "Numero de Telephone",
            ),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 1, 100, "id");
              },
              mycontroller: controller.id,

              hinttext: " ",
              iconData: Icons.person_rounded,
              //open_in_full_outlined
              labeltext: "Id",
              // mycontroller: ,
            ),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 4, 100, "mot de passe");
              },
              mycontroller: controller.cin,
              // hinttext: "mot de passe",
              iconData: Icons.lock_outline,
              labeltext: "mot de passe",
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
                        width: 120,
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
