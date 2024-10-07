<?php

include "../connect.php";
$data = array();
// $list = array();
$result = $con->query("SELECT * FROM produit WHERE etat=1

ORDER BY Nomp , Typep");
if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        // $row['Prixp'] = number_format($row['Prixp'], 2);
      //$row['Prixp'] = floatval($row['Prixp']);
      $row['Prixp'] = doubleval(number_format($row['Prixp'], 2));
 
        $data[] = $row;
    }
    // echo json_encode($data);
    echo json_encode(array("status" => "success", "data" => $data));

}
?>





