<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM tbl_user WHERE user_email = '$email' AND password = '$password' AND otp = '0'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        //echo $data = "success,".$row["NAME"].",".$row["PHONE"].",".$row["DATEREG"];
        echo "success";
    }
}else{
    echo "failed";
}

?>