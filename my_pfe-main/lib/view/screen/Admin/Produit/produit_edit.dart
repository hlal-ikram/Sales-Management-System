import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/core/class/handlingdataview.dart';
import '../../../../controller/admin_controller/produits/produitE_controller.dart';
import '../../../../core/function/valideInput.dart';
import '../../../widget/auth/custombuttomauth.dart';
import '../../../widget/auth/customtextfromauth.dart';

class ProduitEdit extends StatelessWidget {
  const ProduitEdit({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProduitEditController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Modifier produit'),
          shadowColor: const Color.fromARGB(255, 2, 249, 15),
          backgroundColor: Colors.green[600],
        ),
        body: GetBuilder<ProduitEditController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest!,
                  widget: Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(children: <Widget>[
                        CustonTextFormAuth(
                            //  isNumber: true,
                            valid: (val) {
                              return validInput(
                                val!,
                                3,
                                400,
                                "",
                              );
                            },
                            hinttext: 'entrer le nom',
                            labeltext: 'produit name',
                            mycontroller: controller.nomp,
                            iconData: Icons.category),
                        CustonTextFormAuth(
                            //  isNumber: true,
                            valid: (val) {
                              return validInput(val!, 1, 400, "",
                                  isNumber: true);
                            },
                            hinttext: 'entrer le prix',
                            labeltext: 'produit prix',
                            mycontroller: controller.prixp,
                            iconData: Icons.category),
                        // CustomTextFormGlobal(
                        //     hinttext: 'entrer le type',
                        //     labeltext: 'produit type',
                        //     mycontroller: controller.typep,
                        //     iconData: Icons.category),
                        Column(
                          children: [
                            const Text('Type du produit'),
                            RadioListTile<int>(
                              title: const Text('5'),
                              value: 5,
                              groupValue: controller.selectedType,
                              onChanged: (value) {
                                controller.setSelectedType(value!);
                              },
                            ),
                            RadioListTile<int>(
                              title: const Text('10'),
                              value: 10,
                              groupValue: controller.selectedType,
                              onChanged: (value) {
                                controller.setSelectedType(value!);
                              },
                            ),
                            RadioListTile<int>(
                              title: const Text('25'),
                              value: 25,
                              groupValue: controller.selectedType,
                              onChanged: (value) {
                                controller.setSelectedType(value!);
                              },
                            ),
                          ],
                        ),

                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: MaterialButton(
                              color: Colors.green[100],
                              textColor: Colors.green[800],
                              onPressed: () {
                                controller.chooseImage();
                              },
                              child: const Text("choisir une  image"),
                            )),
                        const SizedBox(
                          height: 20,
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
                          text: 'Enregistrer',
                          onPressed: () {
                            controller.editData();
                          },
                        )
                      ]),
                    ),
                  ),
                )));
  }
}
