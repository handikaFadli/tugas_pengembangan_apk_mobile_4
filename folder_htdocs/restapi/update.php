<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include('db.php');

var_dump($_POST['id']);

if (!isset($_POST['id'])  && !isset($_POST['title']) && !isset($_POST['content'])) {
  echo json_encode("No Data Sent!");
} else {
  $id = $_POST['id'];
  $title = htmlspecialchars($_POST['title']);
  $content = htmlspecialchars($_POST['content']);

  $query = "UPDATE blog SET
				title = '$title',
				content = '$content'
				WHERE id = $id
			";

  $result = mysqli_query($db, $query);
  if ($result) {
    echo json_encode("Success!");
  } else {
    echo json_encode("Failed!");
  }
}
