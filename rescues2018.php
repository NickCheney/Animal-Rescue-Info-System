<!DOCTYPE html>
<html>
<head>
<link href="animaldb.css" type="text/css" rel="stylesheet" >
</head>

<body>
<?php

#run a query to get driver information from a particular rescue organization
$dbh = new PDO('mysql:host=localhost;dbname=animalrescueinfo', "root", "");
#user name and password for mysql when using XAMPP is "root" and a blank password

$rows = $dbh->query("select count(transports.animal_ID) from transports,
relocates where YEAR(relocates.move_Date) = 2018 and transports.animal_ID =
relocates.animal_ID and transports.dropoff_ID = relocates.org_ID");



foreach ($rows as $row){
  if ($row[0] > 0)
    echo "<h2>Total animals saved by a rescue organization in 2018: $row[0] </h2>";
  else
    echo "<h2>No rescues performed in 2018 :(</h2>";
}

$dbh = null;

?>

<a href="animalrescueinfo.html">click to return home</a>

</body>
</html>
