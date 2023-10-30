<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include('db.php');

if (!isset($_POST['title']) && !isset($_POST['content'])) {
  echo json_encode("No Data Sent!");
} else {
  $title = htmlspecialchars($_POST['title']);
  $content = htmlspecialchars($_POST['content']);

  $query = "INSERT INTO blog
            VALUES 
          ('', '$title', '$content')";
  $result = mysqli_query($db, $query);

  if ($result) {
    echo json_encode("Success!");
  } else {
    echo json_encode("Failed!");
  }
}
