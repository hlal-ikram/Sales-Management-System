<?php
// Connexion à la base de données
include "../connect.php";
    // Récupérer les valeurs "Nomv" et "Prenomv" correspondant à "idV"
    $idV = $_GET['idV']; // Supposons que vous recevez l'idV en tant que paramètre GET

    $stmt = $con->prepare("SELECT Nomv, Prenomv FROM vendeur WHERE idV = :idV");
    $stmt->bindParam(':idV', $idV);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        // Récupérer les valeurs
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $nomVendeur = $row['Nomv'];
        $prenomVendeur = $row['Prenomv'];

        // Retourner les valeurs en tant que réponse JSON
        $response = array(
            'nomVendeur' => $nomVendeur,
            'prenomVendeur' => $prenomVendeur
        );
        echo json_encode($response);
    } else {
        // Aucun enregistrement trouvé
        echo "Aucun enregistrement trouvé";
    }


$con = null;
?>