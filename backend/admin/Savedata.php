<?php
try {
    include "../connect.php";
    $con->query("SET FOREIGN_KEY_CHECKS = 0");

    // Vérifier si des données ont été envoyées dans le corps de la requête POST
    $requestData = json_decode(file_get_contents('php://input'), true);
    if (isset($requestData['data'])) {
        $dataToSave = $requestData['data'];

        // Préparer la requête SQL pour l'insertion des données dans la table "affectation"
        $stmt = $con->prepare("INSERT INTO affectation (Datea, VehiculeID, VendeurID, SecteurID) VALUES (:datea, :vehiculeid, :vendeurid, :secteurid)");

        // Parcourir les données à enregistrer
        foreach ($dataToSave as $row) {
            $secteur = $row['secteur'];
            $nom = $row['nom'];
            $vehicule = $row['vehicule'];

            // Récupérer l'ID du secteur correspondant au nom sélectionné
            $stmtSecteurID = $con->prepare("SELECT SecteurID FROM secteur WHERE Noms = :secteur");
            $stmtSecteurID->bindParam(':secteur', $secteur);
            $stmtSecteurID->execute();
            $secteurID = $stmtSecteurID->fetch(PDO::FETCH_COLUMN);

            // Récupérer l'ID du vendeur correspondant au nom sélectionné
            $stmtVendeurID = $con->prepare("SELECT VendeurID FROM vendeur WHERE CONCAT(Nomv, ' ', Prenomv) = :nom");
            $stmtVendeurID->bindParam(':nom', $nom);
            $stmtVendeurID->execute();
            $vendeurID = $stmtVendeurID->fetch(PDO::FETCH_COLUMN);

            // Insérer les données dans la table "affectation"
            $stmt->bindValue(':datea', date('Y-m-d'));
      
            $stmt->bindParam(':vehiculeid', $vehicule);
            $stmt->bindParam(':vendeurid', $vendeurID);
            $stmt->bindParam(':secteurid', $secteurID);
            $stmt->execute();
        }

        $con->query("SET FOREIGN_KEY_CHECKS = 1");
        // Retourner une réponse JSON indiquant le succès de l'enregistrement
        header('Content-Type: application/json');
        echo json_encode(['success' => true]);
    } else {
        // Aucune donnée n'a été envoyée dans la requête
        throw new Exception('Aucune donnée à enregistrer');
    }
} catch (PDOException $e) {
    // Afficher l'erreur en cas de problème de connexion ou d'exécution de la requête
    echo "Erreur : " . $e->getMessage();
}
?>