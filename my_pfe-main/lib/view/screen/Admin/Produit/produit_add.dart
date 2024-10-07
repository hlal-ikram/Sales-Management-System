import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/produits/produitA_controller.dart';
import 'package:my_pfe/core/class/handlingdataview.dart';
import 'package:my_pfe/core/function/valideInput.dart';

import '../../../widget/auth/custombuttomauth.dart';
import '../../../widget/auth/customtextfromauth.dart';

class ProduitAdd extends StatelessWidget {
  const ProduitAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProduitAddController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
        shadowColor: const Color.fromARGB(255, 2, 249, 15),
        backgroundColor: Colors.green[600],
      ),
      body: GetBuilder<ProduitAddController>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest!,
          widget: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: <Widget>[
                  CustonTextFormAuth(
                      // isNumber: false,
                      valid: (val) {
                        return validInput(
                          val!,
                          1,
                          400,
                          "",
                        );
                      },
                      hinttext: 'Entrer le nom',
                      labeltext: 'Nom du produit',
                      mycontroller: controller.nomp,
                      iconData: Icons.category),
                  CustonTextFormAuth(
                      //  isNumber: true,
                      valid: (val) {
                        return validInput(val!, 1, 400, "", isNumber: true);
                      },
                      hinttext: 'Entrer le prix',
                      labeltext: 'Prix du produit par kilo',
                      mycontroller: controller.prixp,
                      iconData: Icons.category),
                  ListTile(
                    title: const Text('Type du produit'),
                    subtitle: Column(
                      children: [
                        RadioListTile<int>(
                          title: const Text('5 kg'),
                          value: 5,
                          groupValue: controller.selectedType,
                          onChanged: (value) {
                            controller.setSelectedType(value!);
                          },
                        ),
                        RadioListTile<int>(
                          title: const Text('10 kg'),
                          value: 10,
                          groupValue: controller.selectedType,
                          onChanged: (value) {
                            controller.setSelectedType(value!);
                          },
                        ),
                        RadioListTile<int>(
                          title: const Text('25 kg'),
                          value: 25,
                          groupValue: controller.selectedType,
                          onChanged: (value) {
                            controller.setSelectedType(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  // CustomTextFormGlobal(
                  //     hinttext: 'Entrer le type',
                  //     labeltext: 'Type du produit',
                  //     mycontroller: controller.typep,
                  //     iconData: Icons
                  //         .category),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MaterialButton(
                      color: Colors.green[100],
                      textColor: Colors.green[800],
                      onPressed: () {
                        controller.chooseImage();
                      },
                      child: const Text('Choisir une image'),
                    ),
                  ),
                  if (controller.file != null)
                    Image.file(
                      controller.file!,
                      width: 200,
                      height: 200,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtomAuth(
                    text: 'Ajouter',
                    onPressed: () {
                      controller.addData();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
