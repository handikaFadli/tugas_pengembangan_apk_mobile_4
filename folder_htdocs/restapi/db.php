<?php
$db = mysqli_connect('localhost', 'root', '', 'userdata');

if (!$db) {
  echo "Database connection failed!";
}
