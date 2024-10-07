<?php

// ==========================================================
//  Copyright Reserved Hanane Hbaly (Projet PFE)
// ==========================================================

define("MB", 1048576);

function filterRequest($requestname)
{
    return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function getAllData($table, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
    }
    return $count;
}

function getData($table, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($count > 0) {
        $type=$data['type']; 
        $etat=$data['service']; 
        echo json_encode(array("status" => "success","message"=>$type,"etat"=>$etat, "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
   }
    return $count;
}

function getDataFromDeuxtable($table1, $table2, $where = null, $values = null)
{
   global $con;
    $data = array();
    $stmt = $con->prepare("SELECT $table1.*, $table2.*
                           FROM $table1
                           INNER JOIN $table2 ON $table1.cin = $table2.Cinv
                           WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    //$row=$stmt->fetch();
    $type=$data['type']; 
     if ($count > 0) {
         echo json_encode(array("status" => "success", "data" => $data));
     } else {
         echo json_encode(array("status" => "failure"));
    }
  
    return $count;
}


 


// function insertData($table, $data, $json = true)
// {
//     global $con;
//     foreach ($data as $field => $v)
//         $ins[] = ':' . $field;
//     $ins = implode(',', $ins);
//     $fields = implode(',', array_keys($data));
//     $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

//     $stmt = $con->prepare($sql);
//     foreach ($data as $f => $v) {
//         $stmt->bindValue(':' . $f, $v);
//     }
//     $stmt->execute();
//     $count = $stmt->rowCount();
//     if ($json == true) {
//         if ($count > 0) {
//             echo json_encode(array("status" => "success"));
//         } else {
//             echo json_encode(array("status" => "failure"));
//         }
//     }  
//     return $count;
// }
function insertData($table, $data, $json = true)
{
    global $con;
    
    // Désactiver la vérification des contraintes de clé étrangère
    $con->exec('SET FOREIGN_KEY_CHECKS = 0');
    
    foreach ($data as $field => $v)
        $ins[] = ':' . $field;
    $ins = implode(',', $ins);
    $fields = implode(',', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) {
        $stmt->bindValue(':' . $f, $v);
    }
    $stmt->execute();
    $count = $stmt->rowCount();
    
    // Réactiver la vérification des contraintes de clé étrangère
    $con->exec('SET FOREIGN_KEY_CHECKS = 1');
    
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }  
    return $count;
}



function insertDatasansSu($table, $data, $json = true)
{
    global $con;
    foreach ($data as $field => $v)
        $ins[] = ':' . $field;
    $ins = implode(',', $ins);
    $fields = implode(',', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) {
        $stmt->bindValue(':' . $f, $v);
    }
    $stmt->execute();
    $count = $stmt->rowCount();
 
    return $count;
}


function updateData($table, $data, $where, $json = true)
{
    global $con;
    $cols = array();
    $vals = array();

    foreach ($data as $key => $val) {
        $vals[] = "$val";
        $cols[] = "`$key` =  ? ";
    }
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function imageUpload($dir,$imageRequest)
{
    global $msgError;
    if (isset($_FILES[$imageRequest])){
        $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
        $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
        $imagesize  = $_FILES[$imageRequest]['size'];
        $allowExt   = array("jpg", "png", "gif", "mp4", "pdf","svg");
        $strToArray = explode(".", $imagename);
        $ext        = end($strToArray);
        $ext        = strtolower($ext);
    
        if (!empty($imagename) && !in_array($ext, $allowExt)) {
            $msgError = "EXT";
        }
        if ($imagesize > 2 * MB) {
            $msgError = "size";
        }
        if (empty($msgError)) {
            move_uploaded_file($imagetmp, $dir."/".$imagename);
            return $imagename;
        } else {
            return "fail";
        }
    }else {
        return 'empty';
    }
  
}



function deleteFile($dir, $imagename)
{
    if (file_exists($dir . "/" . $imagename)) {
        unlink($dir . "/" . $imagename);
    }
}

function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345") {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }


}


function   printFailure($message = "none") 
{
    echo     json_encode(array("status" => "failure" , "message" => $message));
}
function   printSuccessVendeur($message = "vendeur",) 
{
    echo     json_encode(array("status" => "success" , "message" => $message));
}

function   printSuccessAdmin($message = "admin",) 
{
    echo     json_encode(array("status" => "success" , "message" => $message));
}



function result($count,$type,){
   if ($count > 0 && $type=='admin'  ){
    printSuccessAdmin() ;  
   }else if($count > 0 && $type=='vendeur') {
    printSuccessVendeur()  ; 
   }else{
    printFailure();
   }
}


