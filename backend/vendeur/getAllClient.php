<?php

include "../connect.php";
$id = filterRequest("idv") ;
$data = array();
$date = date("Y-m-d", strtotime("-1 day"));

 //$date1 = date("Y-m-d");
//echo $date;
//echo $date1;
$result = $con->query("SELECT distinct concat ( c.Nomc ,' ', c.Prenomc)  as nomc  , c.ClientID FROM client c , affectation a , vendeur v
 where a.VendeurID=v.VendeurID and v.idV='$id' and  c.SecteurID=a.SecteurID   and a.Datea='$date'
"); 
if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }
     //echo json_encode($data);
     echo json_encode(array("status" => "success", "data" => $data));
    //echo json_encode(array("data" => $data)); //, affectation a , vendeur v
    
}



?>



