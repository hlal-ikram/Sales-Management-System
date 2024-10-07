import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_pfe/core/constant/linkapi.dart';
import 'dart:core';

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _secteurOptions = [];
  String? _selectedSector;
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSecteurOptions();
  }

  Future<void> _fetchSecteurOptions() async {
    final response = await http.get(Uri.parse(AppLink.enregistrerClient));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        _secteurOptions = List<String>.from(responseData['secteurOptions']);
      });
    } else {
      // Gérer les erreurs de requête HTTP
    }
  }

  Future<void> _saveClient() async {
    if (_formKey.currentState!.validate()) {
      // Vérifier si l'adresse est null
      if (_adresseController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('Veuillez récupérer l\'adresse'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Enregistrer le client dans la base de données
      final response = await http.post(
        Uri.parse(AppLink.enregistrerClient),
        body: {
          'secteur': _selectedSector!,
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'telephone': _telephoneController.text,
          'adresse': _adresseController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        // Vérifier si une erreur a été retournée par le serveur PHP
        if (responseData.containsKey('error')) {
          // Afficher une boîte de dialogue avec le message d'erreur
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error,
                        color: Colors.red, size: 50.0), // Icône d'erreur
                    SizedBox(width: 20.0),
                    Text(
                      'Erreur',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                content: Text(responseData['error']),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );

          return; // Arrêter l'exécution de la méthode _saveClient()
        }

        // Le client a été enregistré avec succès, afficher une boîte de dialogue de réussite
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle,
                      color: Colors.green, size: 50.0), // Icône d'erreur
                  SizedBox(width: 20.0),
                ],
              ),
              content: Text('Le client a été enregistré avec succès.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Gérer les erreurs de requête HTTP
      }
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 72, 149, 75),
        title: Text('Enregistrer un client'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedSector,
                      items: _secteurOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSector = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Sélectionner un secteur',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.public,
                            color: Color.fromARGB(255, 7, 136, 11)),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner un secteur';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.person_2_outlined,
                            color: Color.fromARGB(255, 7, 136, 11)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un nom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.person_2,
                            color: Color.fromARGB(255, 7, 136, 11)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un prénom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _telephoneController,
                      decoration: InputDecoration(
                        labelText: 'Téléphone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(255, 7, 136, 11)),
                      ),
                      keyboardType:
                          TextInputType.phone, // Afficher le clavier numérique
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un numéro de téléphone';
                        } else if (!_validatePhoneNumber(value)) {
                          return 'Veuillez saisir un numéro de téléphone valide';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      icon: Icon(Icons.location_on, color: Colors.white),
                      label: Text('Obtenir l\'adresse'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 215, 136, 57),
                        elevation: 2.0,
                      ),
                      onPressed: () async {
                        try {
                          Position position =
                              await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );

                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                            position.latitude,
                            position.longitude,
                          );

                          Placemark placemark = placemarks.first;
                          String address =
                              '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}';

                          _adresseController.text = address;
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Erreur'),
                                content: Text(
                                    'Veuillez activer le GPS pour obtenir l\'adresse.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _adresseController,
                      decoration: InputDecoration(
                        labelText: 'Adresse',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.location_on,
                            color: Color.fromARGB(255, 198, 58, 12)),
                      ),
                      maxLines: null,
                      enabled: false,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      child: Text('Enregistrer'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 2.0,
                      ),
                      onPressed: _saveClient,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // Pattern pour valider les numéros de téléphone
    RegExp phoneNumberRegex =
        RegExp(r'^(?:\+212|0)(?:[5-7]\d{8}|6\d{8}|7\d{8})$');

    // Vérifier si le numéro correspond au pattern
    return phoneNumberRegex.hasMatch(phoneNumber);
  }
}
