<?php
include "../connect.php";

// Requête pour récupérer les options de secteur
// Requête pour récupérer les options de secteur
$secteurQuery = $con->query("SELECT Noms FROM secteur");
$secteurOptions = $secteurQuery->fetchAll(PDO::FETCH_COLUMN);

// Créer un tableau associatif avec les options de secteur
$response = array('secteurOptions' => $secteurOptions);

// Vérifier si des données ont été envoyées depuis le formulaire
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupérer les données du formulaire
    $secteurSelectionne = $_POST['secteur'];
    $nomClient = $_POST['nom'];
    $prenomClient = $_POST['prenom'];
    $telephoneClient = $_POST['telephone'];
    $adresseClient = $_POST['adresse'];

    // Requête pour vérifier si un client existe déjà
    $checkClientQuery = $con->prepare("SELECT * FROM client WHERE CONCAT(Nomc, Prenomc, Adressec) = :concatenation");
    $concatenation = $nomClient . $prenomClient . $adresseClient;
    $checkClientQuery->bindParam(':concatenation', $concatenation);
    $checkClientQuery->execute();

    // Vérifier si un enregistrement correspondant a été trouvé
    if ($checkClientQuery->rowCount() > 0) {
        // Client existe déjà, ajouter un champ 'error' à la réponse JSON
        $response['error'] = 'Un client avec les mêmes informations existe déjà.';
    } else {
        // Requête pour récupérer l'ID du secteur correspondant
        $secteurQuery = $con->prepare("SELECT SecteurID FROM secteur WHERE Noms = :nom");
        $secteurQuery->bindParam(':nom', $secteurSelectionne);
        $secteurQuery->execute();
        $secteur = $secteurQuery->fetch(PDO::FETCH_ASSOC);

        $secteurID = $secteur['SecteurID'];

        // Requête pour insérer les données dans la table "client"
        $insertQuery = $con->prepare("INSERT INTO client (SecteurID, Nomc, Prenomc, telephone, Adressec) VALUES (:secteurID, :nom, :prenom, :telephone, :adresse)");
        $insertQuery->bindParam(':secteurID', $secteurID);
        $insertQuery->bindParam(':nom', $nomClient);
        $insertQuery->bindParam(':prenom', $prenomClient);
        $insertQuery->bindParam(':telephone', $telephoneClient);
        $insertQuery->bindParam(':adresse', $adresseClient);
        $insertQuery->execute();

        // Ajouter un champ 'success' à la réponse JSON
        $response['success'] = true;
    }
}

// Renvoyer la réponse JSON complète
header('Content-Type: application/json');
echo json_encode($response);