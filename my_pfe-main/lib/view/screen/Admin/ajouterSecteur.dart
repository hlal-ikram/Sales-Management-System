import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/admin_controller/ajouterSecteurController.dart';
import '../../../core/function/valideInput.dart';
import '../../widget/auth/custombuttomauth.dart';
import '../../widget/auth/customtextfromauth.dart';

class AjouterSecteur extends StatelessWidget {
  const AjouterSecteur({super.key});

  @override
  Widget build(BuildContext context) {
    AjouterSecteurController controller = Get.put(AjouterSecteurController());
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
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Ajouter Secteur",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(15.0),
            //   child: Center(
            //     child: Text(
            //       "Ajouter Secteur",
            //       style: TextStyle(
            //           color: Colors.green,
            //           fontSize: 30,
            //           fontWeight: FontWeight.w400,
            //           decorationThickness: 60,
            //           overflow: TextOverflow.clip),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 100),
            CustonTextFormAuth(
              valid: (val) {
                return validInput(val!, 3, 100, "");
              },
              mycontroller: controller.noms,

              hinttext: " Entrer le nom du secteur",
              iconData: Icons.open_in_full_outlined,
              labeltext: "Nom",
              // mycontroller: ,
            ),
            const SizedBox(height: 100),
            Center(
              child: SizedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CustomButtomAuth(
                        text: "Enregister",
                        onPressed: () {
                          controller.enregister();
                        },
                        width: 130,
                      ),
                    ),
                    CustomButtomAuth(
                      text: "Annuler",
                      onPressed: () {
                        controller.annuler();
                      },
                      width: 130,
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
