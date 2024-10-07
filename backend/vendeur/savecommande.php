<?php
// Connexion à la base de données
include "../connect.php";
$stmt = $con->prepare("SET FOREIGN_KEY_CHECKS = 0");
$stmt->execute();

$response = []; // Variable pour la réponse JSON

// Récupérer les données de la requête POST
$nomVendeur = $_POST['nomVendeur'];
$prenomVendeur = $_POST['prenomVendeur'];
$vehiculeId = $_POST['vehiculeId'];
$produits = json_decode($_POST['produits'], true);

// Récupérer l'ID du vendeur correspondant au nom et prénom donnés
$sql = "SELECT VendeurID FROM vendeur WHERE Nomv = :nomVendeur AND Prenomv = :prenomVendeur";
$stmt = $con->prepare($sql);
$stmt->bindParam(':nomVendeur', $nomVendeur);
$stmt->bindParam(':prenomVendeur', $prenomVendeur);
$stmt->execute();

if ($stmt->rowCount() > 0) {
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    $vendeurID = $row["VendeurID"];
     
    // Vérifier si une commande existe déjà avec les mêmes informations
    $datec = date("Y-m-d");
    $sql = "SELECT CommandeID FROM commande WHERE Datec = :datec AND VendeurID = :vendeurID AND VehiculeID = :vehiculeId";
    $stmt = $con->prepare($sql);
    $stmt->bindParam(':datec', $datec);
    $stmt->bindParam(':vendeurID', $vendeurID);
    $stmt->bindParam(':vehiculeId', $vehiculeId);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        // Une commande existe déjà avec les mêmes informations, récupérer son ID
       // $row = $stmt->fetch(PDO::FETCH_ASSOC);
       // $commandeID = $row["CommandeID"];
       $response['success'] = false;
       $response['message'] = "Vous avez déjà fait une commande aujourd'hui.";

    } else {
        // Enregistrer la nouvelle commande dans la table "commande"
        $datec = date("Y-m-d");
        $sql = "INSERT INTO commande (Datec, VendeurID, VehiculeID) VALUES (:datec, :vendeurID, :vehiculeId)";
        $stmt = $con->prepare($sql);
        $stmt->bindParam(':datec', $datec);
        $stmt->bindParam(':vendeurID', $vendeurID);
        $stmt->bindParam(':vehiculeId', $vehiculeId);
        $stmt->execute();

        // Récupérer l'ID de la commande nouvellement insérée
        
        $sql = "SELECT CommandeID FROM commande WHERE Datec = :datec AND VendeurID = :vendeurID AND VehiculeID = :vehiculeId";
$stmt = $con->prepare($sql);
$stmt->bindParam(':datec', $datec);
$stmt->bindParam(':vendeurID', $vendeurID);
$stmt->bindParam(':vehiculeId', $vehiculeId);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);
    $commandeID = $row["CommandeID"];
    

    // Pour chaque produit, récupérer l'ID du produit dans la table "produit" et enregistrer les données dans la table "quantitecom"
    foreach ($produits as $produit) {
        $nomProduit = $produit['nom'];
        $typeProduit = $produit['type'];

        $sql = "SELECT ProduitID FROM produit WHERE Nomp = :nomProduit AND Typep = :typeProduit";
        $stmt = $con->prepare($sql);
        $stmt->bindParam(':nomProduit', $nomProduit);
        $stmt->bindParam(':typeProduit', $typeProduit);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            $produitID = $row["ProduitID"];

           

            // Enregistrer les données dans la table "quantitecom"
            $quantite = $produit['quantite'];

            $sql = "INSERT INTO quantitecom (CommandeID, ProduitID, Quantite) VALUES (:commandeID, :produitID, :quantite)";
            $stmt = $con->prepare($sql);
            $stmt->bindParam(':commandeID', $commandeID);
            $stmt->bindParam(':produitID', $produitID);
            $stmt->bindParam(':quantite', $quantite);
            $stmt->execute();
        }
    }

    $response['success'] = true;
    $response['message'] = "La commande a été enregistrée avec succès.";
}
}

// Rétablir la vérification des clés étrangères
$stmt = $con->prepare("SET FOREIGN_KEY_CHECKS = 1");
$stmt->execute();

// À la fin du script, renvoyer la réponse en tant que JSON
header('Content-Type: application/json');
echo json_encode($response);
?>