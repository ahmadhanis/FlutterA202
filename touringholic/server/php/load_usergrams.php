<?php
include_once("dbconnect.php");
$user_email = $_POST['email'];

$sqlloadgrams= "SELECT * FROM tbl_grams WHERE user_email = '$user_email' ORDER BY date_post DESC";
$result = $conn->query($sqlloadgrams);

if ($result->num_rows > 0){
    $response["grams"] = array();
    while ($row = $result -> fetch_assoc()){
        $gramlist = array();
        $gramlist[gramid] = $row['gram_id'];
        $gramlist[gramdesc] = $row['gram_desc'];
        $gramlist[user_email] = $row['user_email'];
        $gramlist[date_post] = $row['date_post'];
        array_push($response["grams"],$gramlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}


?>