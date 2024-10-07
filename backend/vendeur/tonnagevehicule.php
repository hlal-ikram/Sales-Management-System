<?php
// Connexion à la base de données
include "../connect.php";

// Récupération du vendeur ID depuis les paramètres GET
$vendeurId = $_GET['vendeurId'];

$queryVendeurID = "SELECT VendeurID FROM vendeur WHERE idV = :vendeurId";
$stmtVendeurID = $con->prepare($queryVendeurID);
$stmtVendeurID->bindParam(':vendeurId', $vendeurId);
$stmtVendeurID->execute();
$vendeurID = $stmtVendeurID->fetchColumn();

// Récupération du tonnage maximal du véhicule avec lequel le vendeur travaille
$queryVehiculeId = "SELECT VehiculeID FROM affectation WHERE Datea = CURDATE() AND VendeurID = :vendeurID";
$stmtVehiculeId = $con->prepare($queryVehiculeId);
$stmtVehiculeId->bindParam(':vendeurID', $vendeurID);
$stmtVehiculeId->execute();
$vehiculeId = $stmtVehiculeId->fetchColumn();

$queryTonnageMax = "SELECT tonagemax FROM vehicule WHERE VehiculeID = :vehiculeId";
$stmtTonnageMax = $con->prepare($queryTonnageMax);
$stmtTonnageMax->bindParam(':vehiculeId', $vehiculeId);
$stmtTonnageMax->execute();
$tonnageMax = $stmtTonnageMax->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: application/json');
echo json_encode($tonnageMax);