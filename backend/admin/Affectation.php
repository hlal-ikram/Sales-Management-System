<?php
try {
    include "../connect.php";

    // Récupérer les options de sélection pour la colonne "Secteurs" depuis la table "secteur"
    $stmtSecteurs = $con->prepare("SELECT Noms FROM secteur");
    $stmtSecteurs->execute();
    $secteurs = $stmtSecteurs->fetchAll(PDO::FETCH_COLUMN);

    // Récupérer les options de sélection pour la colonne "Nom et Prénom" depuis la table "vendeur"
    $stmtNoms = $con->prepare("SELECT CONCAT(Nomv, ' ', Prenomv) AS NomPrenom FROM vendeur v,users u where u.id=v.idV and u.service=1");
    $stmtNoms->execute();
    $noms = $stmtNoms->fetchAll(PDO::FETCH_COLUMN);

    // Récupérer les options de sélection pour la colonne "Véhicules" depuis la table "vehicule"
    $stmtVehicules = $con->prepare("SELECT VehiculeID FROM vehicule");
    $stmtVehicules->execute();
    $vehicules = $stmtVehicules->fetchAll(PDO::FETCH_COLUMN);

    // Définir les en-têtes de la réponse comme JSON
    header('Content-Type: application/json');

    // Retourner les options au format JSON
    echo json_encode(array(
        'secteurs' => $secteurs,
        'noms' => $noms,
        'vehicules' => $vehicules
    ));
} catch (PDOException $e) {
    // Afficher l'erreur en cas de problème de connexion ou d'exécution de la requête
    echo "Erreur : " . $e->getMessage();
}
?>