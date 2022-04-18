<?php
include_once("dbconnect.php");
if (!isset($_POST['productId'])) {
    echo 'failed';
    die();
}

$productId = $_POST['productId'];

$stmt = $conn->prepare("SELECT * FROM tbl_products WHERE prid = ?");
$stmt->bind_param('i', $productId);
$stmt->execute();
$result = $stmt->get_result();


if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $picture = $row['picture'];
    $stmt = $conn->prepare("DELETE FROM tbl_products WHERE prid = ?");
    $stmt->bind_param('i', $productId);
    if ($stmt->execute()) {
        unlink("../images/$picture");
        echo 'success';
        return;
    }
}
echo 'failed';
