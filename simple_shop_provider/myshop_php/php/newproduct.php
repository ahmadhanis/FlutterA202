<?php
include_once("dbconnect.php");

if (!isset($_POST)) {
    echo 'failed';
    die();
}
$productName = $_POST['productName'];
$productType = $_POST['productType'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$encoded_base64string = $_POST["encoded_base64string"];

//product file name
$picture = uniqid() . '.png';

$stmt = $conn->prepare("INSERT INTO tbl_products (prid, prname, prtype, prprice,prqty, picture) VALUES (NULL, ?, ?,?, ?, ?)");
$stmt->bind_param('ssdis', $productName, $productType, $price, $quantity, $picture);
if ($stmt->execute()) {
    // image base64 user profile
    $decoded_string = base64_decode($encoded_base64string);
    $path = '../images/' . $picture;
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
} else {

    echo "failed";
}
