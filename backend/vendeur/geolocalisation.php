<?php
// Connexion à la base de données

include "../connect.php";

    // Requête SQL pour récupérer les adresses des clients
    $query = "SELECT Adressec FROM client";
    $stmt = $con->prepare($query);
    $stmt->execute();

    // Tableau pour stocker les adresses
    $addresses = array();

    // Parcourir les résultats de la requête et ajouter les adresses au tableau
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $addresses[] = $row['Adressec'];
    }

    // Fermer la connexion à la base de données
    $con = null;

    // Renvoyer les adresses au format JSON
    echo json_encode($addresses);

?>