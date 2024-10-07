// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_pfe/controller/admin_controller/bloquer_vendeur_controller.dart';

// class BloquerVendeur extends StatelessWidget {
//   const BloquerVendeur({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Get.put(BlocageController());
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green[700],
//           title: const Center(child: Text("Minoterie Othman")),
//         ),
//         body: GetBuilder<BlocageController>(builder: (controller) {
//           return Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(30),
//                 child: Text(
//                   "Gestion de blocage des vendeurs",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: controller.vendeur.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {

//                         controller.showDialogBox(context, index);
//                       },
//                       child: Card(
//                         elevation: 2,
//                         child: ListTile(
//                           title: Text(
//                               '${controller.vendeur[index]["Nomv"]}  ${controller.vendeur[index]["Prenomv"]}'),
//                           subtitle: Text(controller.vendeur[index]["idV"]),
//                           trailing: Icon(
//                             controller.vendeur[index]["service"] == 1
//                                 ? Icons.check_circle
//                                 : Icons.cancel, // je veut faire comme une label pour les icons blouer vendeur et pour debloquer vendeur
//                             color: controller.vendeur[index]["service"] == 1
//                                 ? Colors.green
//                                 : Colors.red,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/bloquer_vendeur_controller.dart';

class BloquerVendeur extends StatelessWidget {
  const BloquerVendeur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BlocageController());
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Minoterie Othman")),
      ),
      body: GetBuilder<BlocageController>(builder: (controller) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Gestion de blocage des vendeurs",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.vendeur.length,
                itemBuilder: (context, index) {
                  final bool isBlocked =
                      controller.vendeur[index]["service"] == 1;

                  return GestureDetector(
                    onTap: () {
                      controller.showDialogBox(context, index);
                    },
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          '${controller.vendeur[index]["Nomv"]} ${controller.vendeur[index]["Prenomv"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(controller.vendeur[index]["idV"]),
                        trailing: Tooltip(
                          message: isBlocked ? "Bloquer" : "Débloquer",
                          child: Icon(
                            isBlocked ? Icons.check_circle : Icons.cancel,
                            color: isBlocked ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
