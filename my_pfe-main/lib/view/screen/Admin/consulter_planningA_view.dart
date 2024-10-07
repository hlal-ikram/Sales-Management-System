/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_pfe/controller/admin_controller/planning_controller.dart';

class PlanningView extends StatefulWidget {
  const PlanningView({super.key});

  @override
  _PlanningViewState createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  @override
  Widget build(BuildContext context) {
    PlanningController controller = Get.put(PlanningController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 167, 12),
        title: const Center(child: Text("Planning d'affectation")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: controller.startDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2054),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          controller.startDate = date;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          'Début : ${DateFormat('yyyy/MM/dd').format(controller.startDate)}'),
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: controller.endDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2055),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          controller.endDate = date;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          'Fin  : ${DateFormat('yyyy/MM/dd').format(controller.endDate)}'), // Mettez à jour le texte avec la date sélectionnée
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Color.fromARGB(255, 11, 11, 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                controller.getAffectation();
              },
              child: const Text('Charger les affectations'),
            ),
            // ),
            const SizedBox(height: 20.0),

            // GetBuilder<PlanningController>(
            //   builder: (_) {
            //     if (_.hasAffectations.value == false) {
            //       return const Text('Aucune affectation disponible');
            //     } else {
            //       return SizedBox(
            //         //  height: 300,
            //         width: 600,
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: SizedBox(
            //             height: 600,
            //             child: SingleChildScrollView(
            //               scrollDirection: Axis.vertical,
            //               child: FittedBox(
            //                 child: PaginatedDataTable(
            //                   rowsPerPage: _.rowsPerPage,
            //                   onPageChanged: (newPage) {
            //                     setState(() {
            //                       _.currentPage = newPage;
            //                     });
            //                   },
            //                   source: _.dataTableSource,
            //                   columns: _.columns,
            //                   availableRowsPerPage: const [
            //                     6,
            //                     10,
            //                   ],
            //                   onRowsPerPageChanged: (newRowsPerPage) {
            //                     if (newRowsPerPage != _.rowsPerPage) {
            //                       setState(() {
            //                         _.onRowsPerPageChanged(newRowsPerPage);
            //                       });
            //                     }
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ),

            GetBuilder<PlanningController>(
              builder: (_) {
                if (_.hasAffectations.value == false) {
                  return const Text('Aucune affectation disponible');
                } else {
                  return Expanded(
                    // je veut ajouter SingleChildScrollView vertical et horizental
                    child: Center(
                      child: PaginatedDataTable(
                        //dataRowHeight: 50,
                        rowsPerPage: _.rowsPerPage,
                        onPageChanged: (newPage) {
                          setState(() {
                            _.currentPage = newPage;
                          });
                        },
                        source: _.dataTableSource,
                        columns: _.columns,
                        availableRowsPerPage: const [
                          6,
                          10,
                        ], // Modifier le nombre de lignes par page ici
                        onRowsPerPageChanged: (newRowsPerPage) {
                          if (newRowsPerPage != _.rowsPerPage) {
                            setState(() {
                              _.onRowsPerPageChanged(newRowsPerPage);
                            });
                          }
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_pfe/controller/admin_controller/planning_controller.dart';

class PlanningView extends StatefulWidget {
  const PlanningView({super.key});

  @override
  _PlanningViewState createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  @override
  Widget build(BuildContext context) {
    PlanningController controller = Get.put(PlanningController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 167, 12),
        title: const Center(child: Text("Planning d'affectation")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: controller.startDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2054),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          controller.startDate = date;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          'Début : ${DateFormat('yyyy/MM/dd').format(controller.startDate)}'),
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: controller.endDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2055),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          controller.endDate = date;
                        });
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          'Fin  : ${DateFormat('yyyy/MM/dd').format(controller.endDate)}'), // Mettez à jour le texte avec la date sélectionnée
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Color.fromARGB(255, 11, 11, 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            SizedBox(
              width: 90,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  controller.getAffectation();
                },
                child: const Text('Charger les affectations'),
              ),
            ),
            // ),
            const SizedBox(height: 20.0),

            GetBuilder<PlanningController>(
              builder: (_) {
                if (_.hasAffectations.value == false) {
                  return const Text('Aucune affectation disponible');
                } else {
                  return Expanded(
                    // je veut ajouter SingleChildScrollView vertical et horizental
                    child: Center(
                      child: PaginatedDataTable(
                        dataRowHeight: 90,
                        rowsPerPage: _.rowsPerPage,
                        onPageChanged: (newPage) {
                          setState(() {
                            _.currentPage = newPage;
                          });
                        },
                        source: _.dataTableSource,
                        columns: _.columns,
                        availableRowsPerPage: const [
                          1,
                          2,
                          3,
                          4,
                          5,
                          6,
                          7,
                          10
                        ], // Modifier le nombre de lignes par page ici
                        onRowsPerPageChanged: (newRowsPerPage) {
                          if (newRowsPerPage != _.rowsPerPage) {
                            setState(() {
                              _.onRowsPerPageChanged(newRowsPerPage);
                            });
                          }
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
