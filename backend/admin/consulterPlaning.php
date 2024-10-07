<?php

include "../connect.php";
$dateStart = filterRequest("dateStart");
$dateEnd = filterRequest("dateEnd");

$data = array();
$result = $con->prepare("SELECT a.Datea, a.VehiculeID, CONCAT(v.Nomv, ' ', v.Prenomv) AS VendeurNom, s.Noms
    FROM affectation a
    JOIN vendeur v ON a.VendeurID = v.VendeurId
    JOIN secteur s ON a.SecteurID = s.SecteurID
    WHERE a.Datea BETWEEN :startDate AND :endDate
    ORDER BY a.Datea");
$result->execute(array(":startDate" => $dateStart, ":endDate" => $dateEnd));

if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}


?>

