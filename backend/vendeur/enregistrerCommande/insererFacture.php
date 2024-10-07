<?php
include '../../connect.php';


$id = filterRequest("idv");
$resultv = $con->query("SELECT VendeurID FROM vendeur WHERE idV='$id'");
if ($resultv) {
    $row = $resultv->fetch(PDO::FETCH_ASSOC);
    $vendeurID = $row['VendeurID'];
}
$datef = date("Y-m-d");
$clientID = filterRequest('clientID');
$result1 = $con->query("INSERT INTO facture (Datef, ClientID, VendeurID) VALUES ('$datef', '$clientID', '$vendeurID')");
if ($result1) {
    $factureID = $con->lastInsertId();
    echo json_encode(array("status1" => "success", "factureID" => $factureID));
}
?>