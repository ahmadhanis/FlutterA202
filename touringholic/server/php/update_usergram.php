<?php
error_reporting(0);
include_once("dbconnect.php");
$gramid = $_POST['gramid'];
$newgram = addslashes($_POST['newgram']);

$sqlupdate = "UPDATE tbl_grams SET gram_desc = '$newgram' WHERE gram_id = '$gramid'";
  if ($conn->query($sqlupdate) === TRUE){
      echo 'success';
  }else{
      echo 'failed';
  } 
?>