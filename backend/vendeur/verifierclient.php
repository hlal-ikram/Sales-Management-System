<?php
include "../connect.php";
// Vérifier si des données ont été envoyées depuis le formulaire
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupérer les données du formulaire
    $secteurSelectionne = $_POST['secteur'];
    $nomClient = $_POST['nom'];
    $prenomClient = $_POST['prenom'];
    $telephoneClient = $_POST['telephone'];
    $adresseClient = $_POST['adresse'];

    // Requête pour vérifier si le client existe déjà
    $existingClientQuery = $con->prepare("SELECT * FROM client WHERE CONCAT(Nomc, Prenomc, telephone) = :concatenation");
    $existingClientQuery->bindParam(':concatenation', $nomClient.$prenomClient.$telephoneClient);
    $existingClientQuery->execute();
    $existingClient = $existingClientQuery->fetch(PDO::FETCH_ASSOC);

    if ($existingClient) {
        // Le client existe déjà, afficher un message d'erreur
        $response = array('error' => 'Le client existe déjà.');
        echo json_encode($response);
        return;
    }

    // Le client n'existe pas, continuer avec l'ajout du client

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

    // Réponse JSON indiquant le succès de l'enregistrement
    $response = array('success' => true);
    echo json_encode($response);
}