<?php
// Connexion à la base de données
include "../connect.php";

// Récupérer la valeur de VendeurID depuis l'URL
$vendeurId = $_GET['vendeurId'];

// Récupérer la valeur de selectedButton depuis l'URL
$selectedButton = $_GET['selectedButton'];

// Convertir la date en format Y-m-d
$date = date('Y-m-d', strtotime($selectedButton));

// Récupérer la valeur de VendeurID correspondante dans la table vendeur
$query = "SELECT VendeurID FROM vendeur WHERE idV = :vendeurId";
$stmt = $con->prepare($query);
$stmt->bindParam(':vendeurId', $vendeurId, PDO::PARAM_STR);
$stmt->execute();
$vendeur = $stmt->fetch(PDO::FETCH_ASSOC);

if ($vendeur) {
    $vendeurId = $vendeur['VendeurID'];

    // Récupérer les SecteurID distincts depuis la table affectation pour le VendeurID et la date sélectionnée
    $query = "SELECT DISTINCT SecteurID FROM affectation WHERE VendeurID = :vendeurId AND Datea = :date";
    $stmt = $con->prepare($query);
    $stmt->bindParam(':vendeurId', $vendeurId, PDO::PARAM_INT);
    $stmt->bindParam(':date', $date, PDO::PARAM_STR);
    $stmt->execute();
    $secteurIds = $stmt->fetchAll(PDO::FETCH_COLUMN);

    $data = array();

    foreach ($secteurIds as $secteurId) {
        // Récupérer le nom du secteur depuis la table secteur
        $query = "SELECT Noms FROM secteur WHERE SecteurID = :secteurId";
        $stmt = $con->prepare($query);
        $stmt->bindParam(':secteurId', $secteurId, PDO::PARAM_INT);
        $stmt->execute();
        $secteur = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($secteur) {
            $secteurNom = $secteur['Noms'];

            // Récupérer tous les VehiculeID pour le SecteurID et le VendeurID depuis la table affectation
            $query = "SELECT VehiculeID FROM affectation WHERE SecteurID = :secteurId AND VendeurID = :vendeurId AND Datea = :date";
            $stmt = $con->prepare($query);
            $stmt->bindParam(':secteurId', $secteurId, PDO::PARAM_INT);
            $stmt->bindParam(':vendeurId', $vendeurId, PDO::PARAM_INT);
            $stmt->bindParam(':date', $date, PDO::PARAM_STR);
            $stmt->execute();
            $vehiculeIds = $stmt->fetchAll(PDO::FETCH_COLUMN);

            // Récupérer les informations des clients depuis la table client
            $query = "SELECT Nomc, Prenomc, Adressec, telephone FROM client WHERE SecteurID = :secteurId ";
            $stmt = $con->prepare($query);
            $stmt->bindParam(':secteurId', $secteurId, PDO::PARAM_INT);
            $stmt->execute();
            $clients = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Construire un tableau contenant les données récupérées
            $secteurData = array(
                'secteur' => $secteurNom,
                'vehiculeIds' => $vehiculeIds,
                'clients' => $clients
            );

            $data[] = $secteurData;
        }
    }

    header('Content-Type: application/json');
    echo json_encode($data);
}