<?php
error_reporting(0);
include_once("dbconnect.php");
$gramid = $_POST['gramid'];
$sqldelete = "DELETE FROM tbl_grams WHERE gram_id = '$gramid'";
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>