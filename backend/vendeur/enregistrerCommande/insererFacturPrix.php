<?php
include '../../connect.php';

    $factureID = filterRequest('factureID');
    $prixTotal = filterRequest('prixTotal');
    $prixTotal = filterRequest('prixTotal');
    $prixAvecReduction = filterRequest('prixAvecReduction');
    $result3 = $con->query("INSERT INTO factureprix (FactureID, Prix, PrixR) VALUES ('$factureID', '$prixTotal', '$prixAvecReduction')");
    if ($result3) {
        echo json_encode(array("status3" => "success"));
    }
?>