<?php
include_once("dbconnect.php");
$user_email = $_POST['email'];
$gram_desc = $_POST['gram_desc'];
$encoded_string = $_POST["encoded_string"];

$sqlinsert = "INSERT INTO tbl_grams(gram_desc,user_email) VALUES('$gram_desc','$user_email')";
if ($conn->query($sqlinsert) === TRUE){
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($conn);
    $path = '../images/gram_pictures/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}

?>