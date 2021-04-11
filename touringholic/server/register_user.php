<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);

$sqlregister = "INSERT INTO tbl_user(user_email,password,otp) VALUES('$email','$passha1','$otp')";
if ($conn->query($sqlregister) === TRUE){
    sendEmail($otp,$email);
    echo "success";
}else{
    echo "failed";
}

function sendEmail($otp,$email){
    $from = "noreply@touringholic.com";
    $to = $email;
    $subject = "From TouringHolic. Please Verify your account";
    $message = "Use the following link to verify your account :"."\n https://slumberjer.com/touringholic/php/verify_account.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}


?>