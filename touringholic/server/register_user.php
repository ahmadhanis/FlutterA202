<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/slumber6/public_html/PHPMailer/src/Exception.php';
require '/home8/slumber6/public_html/PHPMailer/src/PHPMailer.php';
require '/home8/slumber6/public_html/PHPMailer/src/SMTP.php';

include_once("dbconnect.php");

$name = $_POST['name'];
$user_email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$rating = "0";
$credit = "0";
$status = "active";

$sqlregister = "INSERT INTO tbl_user(name,user_email,password,otp,rating,credit,status) VALUES('$name','$user_email','$passha1','$otp','$rating','$credit','$status')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$user_email);
}else{
    echo "failed";
}

function sendEmail($otp,$user_email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = '';                          //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = '';                  //SMTP username
    $mail->Password   = '';                                 //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "touringholic@slumberjer.com";
    $to = $user_email;
    $subject = "From TouringHolic. Please Verify your account";
    $message = "<p>Click the following link to verify your account<br><br><a href='https://slumberjer.com/touringholic/php/verify_account.php?email=".$user_email."&key=".$otp."'>Click Here</a>";
    
    $mail->setFrom($from,"TouringHolic");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}


?>