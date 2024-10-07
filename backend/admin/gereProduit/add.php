<?php 

include '../../connect.php';
$msgError=array();
$table = "produit";
$Nomp = filterRequest("Nomp");
$Prixp = filterRequest("Prixp"); 
$Typep = filterRequest("Typep"); 

$imagename = imageUpload( "../../upload/produits" , "files") ;

$data = array( 
"Nomp" => $Nomp,
"PrixP" => $Prixp,
"Typep" => $Typep,
"Imagep" => $imagename,
);

insertData($table , $data);

