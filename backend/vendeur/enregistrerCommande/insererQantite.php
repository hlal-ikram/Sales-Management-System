<?php
include '../../connect.php';

    $factureID = filterRequest('factureID'); 
    $produitID = filterRequest('produitID');
    $quantite = filterRequest('quantite');
    $result2 = $con->query("INSERT INTO quantite (ProduitID, Quantite, FactureID) VALUES ('$produitID', '$quantite', '$factureID')");
    if($result){
        echo json_encode(array("status2" => "success"));
    }
 
?>