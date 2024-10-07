import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant/linkapi.dart';

class AffectationView extends StatefulWidget {
  const AffectationView({super.key});

  @override
  _AffectationViewState createState() => _AffectationViewState();
}

class _AffectationViewState extends State<AffectationView> {
  List<Map<String, dynamic>> tableData = [];
  List<String> secteurs = [];
  List<String> noms = [];
  List<String> vehicules = [];
  Set<int> selectedRows = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var url = AppLink.affe;
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          secteurs = List<String>.from(
              data['secteurs'].map((sector) => sector.toString()));
          noms = List<String>.from(data['noms'].map((name) => name.toString()));
          vehicules = List<String>.from(
              data['vehicules'].map((vehicle) => vehicle.toString()));
        });
      } else {
        throw Exception('Erreur lors de la récupération des données');
      }
    } catch (error) {
      print('Erreur lors de la récupération des données: $error');
    }
  }

  void addRow() {
    setState(() {
      tableData.add({
        'secteur': secteurs.isNotEmpty ? secteurs[0] : '',
        'nom': noms.isNotEmpty ? noms[0] : '',
        'vehicule': vehicules.isNotEmpty ? vehicules[0] : '',
      });
    });
  }

  void deleteSelectedRows() {
    if (selectedRows.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aucune ligne sélectionnée'),
            content: const Text('Aucune ligne n\'a été sélectionnée.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showConfirmationDialogsupp(() {
        setState(() {
          tableData.removeWhere(
            (data) => selectedRows.contains(tableData.indexOf(data)),
          );
          selectedRows.clear();
        });
      });
    }
  }

  void showConfirmationDialogsupp(Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Êtes-vous sûr de vouloir supprimer les lignes sélectionnées ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
              child: const Text('supprimer '),
            ),
          ],
        );
      },
    );
  }

  void showConfirmationDialog(Function callback) {
    if (tableData.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aucune ligne à enregistrer'),
            content: const Text(
                'Aucune ligne n\'a été ajoutée pour l\'enregistrement.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      List<String> uniqueNoms = [];

      for (final row in tableData) {
        String nom = row['nom'];
        if (!uniqueNoms.contains(nom)) {
          uniqueNoms.add(nom);
        }
      }

      for (final uniqueNom in uniqueNoms) {
        final vehicles = tableData
            .where((row) => row['nom'] == uniqueNom)
            .map((row) => row['vehicule'])
            .toSet();
        if (vehicles.length > 1) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erreur'),
                content: const Text(
                  'Le même vendeur doit utiliser le même véhicule dans toutes ses occurrences.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text(
                'Êtes-vous sûr de vouloir enregistrer les données ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  callback();
                  Navigator.of(context).pop();
                },
                child: const Text('Enregistrer'),
              ),
            ],
          );
        },
      );
    }
  }

  void saveData() async {
    try {
      // Création d'une liste pour stocker les données à enregistrer
      List<Map<String, dynamic>> dataToSave = [];

      // Parcourir les lignes du tableau modifiées
      for (final row in tableData) {
        // Récupérer les valeurs de chaque colonne pour la ligne en cours
        String secteur = row['secteur'];
        String nom = row['nom'];
        String vehicule = row['vehicule'];

        // Créer un objet contenant les valeurs à enregistrer
        Map<String, dynamic> rowData = {
          'secteur': secteur,
          'nom': nom,
          'vehicule': vehicule,
        };

        // Ajouter l'objet à la liste des données à enregistrer
        dataToSave.add(rowData);
      }

      // Création du corps de la requête HTTP
      var requestBody = json.encode({'data': dataToSave});

      // Envoi de la requête HTTP au backend
      var url = AppLink.saveData;
      var response = await http.post(Uri.parse(url), body: requestBody);

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Les données ont été enregistrées avec succès
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Succès'),
              content:
                  const Text('Les données ont été enregistrées avec succès.'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Réinitialiser la liste des données du tableau à une liste vide
                      tableData = [];
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Une erreur s'est produite lors de l'enregistrement des données
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: const Text(
                  'Une erreur s\'est produite lors de l\'enregistrement des données.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erreur lors de l\'enregistrement des données: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Affectation'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 99, 29),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addRow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Changer la couleur du bouton
                  ),
                  child: const Text('Ajouter'),
                ),
                ElevatedButton(
                  onPressed: deleteSelectedRows,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Changer la couleur du bouton
                  ),
                  child: const Text('Supprimer'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: FittedBox(
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Secteur',
                            style: TextStyle(
                                color: Colors
                                    .blue)), // Changer la couleur du nom de colonne
                      ),
                      DataColumn(
                        label: Text('Nom et Prenom',
                            style: TextStyle(
                                color: Colors
                                    .blue)), // Changer la couleur du nom de colonne
                      ),
                      DataColumn(
                        label: Text('Véhicule',
                            style: TextStyle(
                                color: Colors
                                    .blue)), // Changer la couleur du nom de colonne
                      ),
                    ],
                    rows: tableData.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final isSelected = selectedRows.contains(index);

                        return DataRow(
                          selected: isSelected,
                          onSelectChanged: (value) {
                            setState(() {
                              if (value != null && value) {
                                selectedRows.add(index);
                              } else {
                                selectedRows.remove(index);
                              }
                            });
                          },
                          cells: [
                            DataCell(
                              DropdownButton<String>(
                                value: data['secteur'],
                                items: secteurs.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    data['secteur'] = newValue;
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              DropdownButton<String>(
                                value: data['nom'],
                                items: noms.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    data['nom'] = newValue;
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              DropdownButton<String>(
                                value: data['vehicule'],
                                items: vehicules.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    data['vehicule'] = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showConfirmationDialog(saveData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Changer la couleur du bouton
                ),
                child: const Text('Enregistrer'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
