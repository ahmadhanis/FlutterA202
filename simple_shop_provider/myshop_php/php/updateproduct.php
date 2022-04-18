<?php
include_once("dbconnect.php");
if (!isset($_POST['productId'])) {
    echo 'failed';
    die();
}
$productId = $_POST['productId'];
$productName = $_POST['productName'];
$productType = $_POST['productType'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$encoded_base64string = '';

//get the name of the picture
$stmt = $conn->prepare("SELECT picture FROM tbl_products WHERE prid = ?");
$stmt->bind_param('i', $productId);
$stmt->execute();
$result = $stmt->get_result();
$picture = '';
if ($row = $result->fetch_assoc()) {
    $picture = $row['picture'];
}

$result = false;

// if the image is updated
if (isset($_POST['encoded_base64string'])) {
    $encoded_base64string = $_POST["encoded_base64string"];
    // remove old picture
    unlink("../images/$picture");
    // create a new picture name
    $picture = uniqid() . '.png';

    $decoded_string = base64_decode($encoded_base64string);
    $path = '../images/' . $picture;
    $is_written = file_put_contents($path, $decoded_string);

    $result =  updateProduct($conn, $productId, $productName, $productType, $price, $quantity, $picture);
} else {
    $result =  updateProduct($conn, $productId, $productName, $productType, $price, $quantity, $picture);
}
echo $result ? "success" : "failed";


function updateProduct($conn, $productId, $productName, $productType, $price, $quantity, $picture) {
    $stmt = $conn->prepare("UPDATE tbl_products SET prname=?,prtype=?,prprice=?,prqty=?,picture=? WHERE prid=?");
    $stmt->bind_param('ssdisi', $productName, $productType, $price, $quantity, $picture, $productId);
    if ($stmt->execute()) {
        return true;
    }
    return false;
}
