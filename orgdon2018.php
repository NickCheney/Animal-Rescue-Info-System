<!DOCTYPE html>
<html>
<head>
<link href="animaldb.css" type="text/css" rel="stylesheet" >
</head>

<body>
<?php
$orgName = $_POST["name"];

#run a query to get driver information from a particular rescue organization
$dbh = new PDO('mysql:host=localhost;dbname=animalrescueinfo', "root", "");
#user name and password for mysql when using XAMPP is "root" and a blank password

$rows = $dbh->query("select sum(d.amount) from Donation d, Organization o WHERE
o.ID = d.Org_ID and o.name = '$orgName' and Year(d.don_date) = 2018");



foreach ($rows as $row){
  if ($row[0] > 0)
    echo "<h2>Total donations to $orgName in 2018: $$row[0] </h2>";
  else
    echo "<h2>No donations found</h2>";
}

$dbh = null;

?>

<a href="orgdon2018.html">Search a different organization</a>

</body>
</html>
