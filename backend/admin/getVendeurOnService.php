<?php
//GetAllVendeurs on service 
include "../connect.php";
$result =$con->query( "SELECT CONCAT(v.Nomv, ' ', v.Prenomv) AS nom_complet , u.id,v.VendeurID
      FROM vendeur v 
      INNER JOIN users u ON v.idV = u.id
          WHERE u.service = 1;");
if ($result) {
    $vendeurs = array();
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
       // $vendeurs[] = $row['nom_complet'];
       $vendeurs[] = $row;
    }
   // echo json_encode( $vendeurs);

    echo json_encode(array("status" => "success", "data" => $vendeurs));
 }
?>
