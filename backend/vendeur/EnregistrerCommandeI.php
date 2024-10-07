<?php
// Connexion à la base de données
include "../connect.php";

// Récupération des produits depuis la base de données
$query = "SELECT Nomp, Imagep, Prixp, Typep FROM produit where etat =1 ORDER BY Nomp , Typep "; 
$stmt = $con->prepare($query);
$stmt->execute();
$produits = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Renvoyer les produits au format JSON
header('Content-Type: application/json');
echo json_encode($produits);
?>