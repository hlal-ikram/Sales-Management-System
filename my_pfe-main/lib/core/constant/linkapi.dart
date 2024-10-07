//const String linkServerName = "http://10.0.2.2/ProjetPfe";
import 'dart:io';

class AppLink {
  static String get linkServerName {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'http://10.0.2.2/ProjetPfe'; // Lien pour l'émulateur Android
    } else {
      return 'http://localhost/ProjetPfe'; // Lien générique pour les autres plates-formes
    }
  }

  // static const String linkServerName = "http://localhost/ProjetPfe";

  static String linkLogin = "$linkServerName/auth/sighnup.php";
  static String editUsersProfile = "$linkServerName/auth/editUsersProfile.php";
  static String ajouterV = "$linkServerName/admin/ajouterVendeur.php";
  static String ajouterAdmin = "$linkServerName/admin/ajouterAdmin.php";
  static String ajouterSecteur = "$linkServerName/admin/ajouterSecteur.php";
  static String affe = "$linkServerName/admin/Affectation.php";
  static String saveData = "$linkServerName/admin/Savedata.php";
  static String getAllV = "$linkServerName/admin/getAllVendeur.php";
  static String getAllVS = "$linkServerName/admin/getVendeurOnService.php";
  // static String getAllcommandA = "$linkServerName/admin/consultercommande.php";
  static String bloquerV = "$linkServerName/admin/bloquerVendeur.php";
  static String getvendeurById = "$linkServerName/admin/getVendeurById.php";
  static String getadminById = "$linkServerName/admin/getadminById.php";
  static String consulterPlaningA =
      "$linkServerName/admin/consulterPlaning.php";
  static String prodduitV = "$linkServerName/admin/gereProduit/view.php";
  static String prodduitA = "$linkServerName/admin/gereProduit/add.php";
  static String prodduitE = "$linkServerName/admin/gereProduit/edit.php";
  static String prodduitD = "$linkServerName/admin/gereProduit/delete.php";
  static String testphp = "$linkServerName/test.php";
  static String imagep = "$linkServerName/upload/produits";
  static String imageUsers = "$linkServerName/upload/users";
  static String getAllC = "$linkServerName/vendeur/getAllClient.php";
  static String enregistrerClient =
      "$linkServerName/vendeur/enregisterClient.php";
  static String getAllProuduit = "$linkServerName/vendeur/getAllproduit.php";
  static String enregistrerCommabde =
      "$linkServerName/vendeur/enregisterCommande.php";

  static String inserFacture =
      "$linkServerName/vendeur/enregistrerCommande/insererFacture.php";
  static String inserQuantite =
      "$linkServerName/vendeur/enregistrerCommande/insererFacturPrix.php";
  static String inserFacturePrix =
      "$linkServerName/vendeur/enregistrerCommande/insererQantite.php";
  static String consulterPlaning =
      "$linkServerName/vendeur/ConsulterPlaning.php";
  static String consultercommande =
      "$linkServerName/admin/consultercommande.php";

  static String enregistrerCommandeI =
      "$linkServerName/vendeur/EnregistrerCommandeI.php";

  static String tonnagevehicule = "$linkServerName/vendeur/tonnagevehicule.php";
  static String savecommande = "$linkServerName/vendeur/savecommande.php";
  static String vehiculeid = "$linkServerName/vendeur/vehicule.php";
  static String infosvend = "$linkServerName/vendeur/infosvendeur.php";
}
