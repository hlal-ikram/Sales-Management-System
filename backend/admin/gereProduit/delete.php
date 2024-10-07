<?php
include "../../connect.php" ;

$id = filterRequest("ProduitID") ; 

$Imagep = filterRequest("Imagep") ; 

deleteFile("../../upload/produits"  , $Imagep) ; 

//deleteData("produit" , "ProduitID = $id ") ; 
$data = array(
    "etat" =>0
);
updateData("produit", $data, "ProduitID = $id ");
?>