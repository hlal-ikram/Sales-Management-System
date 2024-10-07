<?php
include '../connect.php';

$idv = filterRequest("idv");
$resultv = $con->query("SELECT VendeurID FROM vendeur WHERE idV='$idv'");
if ($resultv) {
    $row = $resultv->fetch(PDO::FETCH_ASSOC);
    $vendeurID = $row['VendeurID'];
}
$datef = date("Y-m-d");
$clientID = filterRequest('clientID');
$result1 = $con->query("INSERT INTO facture (Datef, ClientID, VendeurID) VALUES ('$datef', '$clientID', '$vendeurID')");
if ($result1) {
    $factureID = $con->lastInsertId();
   // echo json_encode(array("status" => "success"));

   $produitID = json_decode($_POST['produitID']);
   $quantite = json_decode($_POST['quantite']);

   for ($i = 0; $i < count($produitID); $i++) {
       $id = $produitID[$i];
       $qty = $quantite[$i];
       $result2 = $con->query("INSERT INTO quantite (ProduitID, Quantite, FactureID) VALUES ('$id', '$qty', '$factureID')");
   }
  

    $prixTotal = filterRequest('prixTotal');
    $prixAvecReduction = filterRequest('prixAvecReduction');
    $result3 = $con->query("INSERT INTO factureprix (FactureID, Prix, PrixR) VALUES ('$factureID', '$prixTotal', '$prixAvecReduction')");
    if ($result3) {
        $allData['status'] = "success";
        echo json_encode($allData);
    } 
  
}
?>