import 'package:get/get.dart';

//   validInput(String val, int min, int max, String? type) {
//   if (val.isEmpty) {
//     return " cant be Empty";
//   }

//   if (type == "id") {
//     if (!GetUtils.isUsername(val)) {
//       return "not valid phone";
//     }
//   }

//   if (val.length < min) {
//     return "can't be less than $min";
//   }
//   if (val.length > max) {
//     return " can't be larger than $max";
//   }
//   if (type! == "phone") {
//     if (!GetUtils.isPhoneNumber(val)) {
//       return "not valid phone";
//     }
//   }
// }

String? validInput(String val, int min, int max, String? type,
    {bool isNumber = false}) {
  if (val.isEmpty) {
    return "Veuillez remplir ce champ";
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "Le numéro de téléphone n'est pas valide";
    }
  }
  if (isNumber) {
    if (!GetUtils.isNum(val)) {
      return "Veuillez entrer un nombre";
    }
    // Ce champ doit contenir uniquement des nombres décimaux
  }
  if (type == "id") {
    if (!GetUtils.isUsername(val)) {
      return "Identifiant non valide.";
    }
  }
  if (val.length < min) {
    return "Mot de passe doit contenir au moins $min caractères.";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }

  return null;
}
