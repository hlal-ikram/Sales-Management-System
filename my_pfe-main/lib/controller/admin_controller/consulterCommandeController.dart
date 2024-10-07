import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:my_pfe/data/datasource/remote/adminData/consulterCommandedata.dart';

import 'package:my_pfe/data/model/vendeur_model.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../data/model/consultercommandemodel.dart';

class ConsulterCommandeController extends GetxController {
  ConsulterCommandeData consulterCommandeData =
      ConsulterCommandeData(Get.find());

  late StatusRequest statusRequest;

  List<VendeurModel> vendeur = [];
  List<ConsulterCommandeModel> commandes = [];

  String? selectedValue;
  DateTime datee = DateTime.now();
  VendeurModel? selectedVendeur;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showCommandes = false;

  Future<void> getVendeurs() async {
    statusRequest = StatusRequest.loading;
    var response = await consulterCommandeData.getvendeurOnservice();
    print("**************Vendeur*** $response");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List datalist = response['data'];
        vendeur.addAll(datalist.map((e) => VendeurModel.fromJson(e)));
      }
    }
    update();
  }

  setSelectedvalue(value) {
    selectedValue = value.toString();
    selectedVendeur =
        vendeur.firstWhere((vendeur) => vendeur.nom_complet == selectedValue);
    update();
  }

  void showCalendar(BuildContext context, DateTime date) {
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((selectedDate) {
      if (selectedDate != null) {
        datee = selectedDate;
        date = selectedDate;
        update();
      }
    });
  }

  Widget afficherlescommande() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: commandes.length,
      itemBuilder: (context, index) {
        final commande = commandes[index];

        return Card(
          child: ListTile(
            title: Text("Client: ${commande.client}"),
            subtitle: Text("Adresse: ${commande.adressec}"),
            trailing: Text("Prix commande: ${commande.prixCommande}"),
            onTap: () {
              // Action à effectuer lorsqu'une commande est sélectionnée
            },
          ),
        );
      },
    );
  }

  getCommandes() async {
    commandes.clear();
    statusRequest = StatusRequest.loading;
    if (formKey.currentState!.validate()) {
      final DateFormat formatter = DateFormat('yyyy/MM/dd');
      final String startDateText = formatter.format(datee);
      var response = await consulterCommandeData.getCommandeFac(
          selectedVendeur?.vendeurID, startDateText);
      statusRequest = handlingData(response);
      print("********************** $response");

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];
          commandes
              .addAll(datalist.map((e) => ConsulterCommandeModel.fromJson(e)));
          update();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      //  update();
    }
  }

  @override
  void onInit() async {
    await getVendeurs();
    datee = DateTime.now();
    showCommandes == false;
    super.onInit();
  }
}
