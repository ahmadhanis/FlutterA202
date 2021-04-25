<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/slumber6/public_html/PHPMailer/src/Exception.php';
require '/home8/slumber6/public_html/PHPMailer/src/PHPMailer.php';
require '/home8/slumber6/public_html/PHPMailer/src/SMTP.php';
include_once("dbconnect.php");

$email = $_POST['email'];
$newotp = rand(1000,9999);
$newpass = random_password(10);
$passha = sha1($newpass);

 $sql = "SELECT * FROM tbl_user WHERE user_email = '$email' AND otp='$otp'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_user SET otp = '$newotp', password = '$passha' WHERE user_email = '$email'";
            if ($conn->query($sqlupdate) === TRUE){
                sendEmail($newotp,$newpass,$email);
                echo 'success';
            }else{
                echo 'failed';
            }
    }else{
        echo "failed";
    }
  

function sendEmail($otp,$newpass,$email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.slumberjer.com';                          //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = 'touringholic@slumberjer.com';                  //SMTP username
    $mail->Password   = 'T0MizfNmCddW';                                 //SMTP password
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "touringholic@slumberjer.com";
    $to = $email;
    $subject = "From TouringHolic. Reset your account";
    $message = "<p>Your account has been reset. Please login again using the information below.</p><br><br><h3>Password:".$newpass.
    "</h3><br><br><a href='https://slumberjer.com/touringholic/php/verify_account.php?email=".$email."&key=".$otp."'>Click Here to activate account</a>";
    
    $mail->setFrom($from,"TouringHolic");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

function random_password($length){
    //A list of characters that can be used in our
    //random password.
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    //Create a blank string.
    $password = '';
    //Get the index of the last character in our $characters string.
    $characterListLength = mb_strlen($characters, '8bit') - 1;
    //Loop from 1 to the $length that was specified.
    foreach(range(1, $length) as $i){
        $password .= $characters[rand(0, $characterListLength)];
    }
    return $password;
}


?>