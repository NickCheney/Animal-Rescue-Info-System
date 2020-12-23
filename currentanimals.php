<!DOCTYPE html>
<html>
<head>
<link href="animaldb.css" type="text/css" rel="stylesheet" >
</head>

<body>
<?php
$spcaName = $_POST["name"];
echo "<h2>Drivers working at $spcaName</h2>";


#run a query to get driver information from a particular rescue organization
$dbh = new PDO('mysql:host=localhost;dbname=animalrescueinfo', "root", "");
#user name and password for mysql when using XAMPP is "root" and a blank password

$rows = $dbh->query("select a.ID, a.species, l.date from animal a, (select
r.animal_ID, c.date, r.org_ID from relocates r join (select animal_ID,
max(move_Date) as date from relocates group by animal_ID) c where r.move_Date
= c.date and r.animal_ID = c.animal_ID) l, organization o where a.id =
l.animal_id and a.adopt_fam_name is null and o.name = '$spcaName' and
o.ID = l.org_id
");

if ($rows->rowCount() == 0)
	echo "<h3>No animals found</h3>";

else {
	echo "<table>
	<tr><th>Animal ID</th><th>Species</th><th>Arrival Date</th></tr>";

	foreach($rows as $row) {
		echo "<tr><td>".$row[0]."</td><td>".$row[1]."</td><td>".$row[2]."</td></tr>";
	}
	echo "</table><br />";
}
$dbh = null;

?>

<a href="spca_animal_info.html">Search a different organization</a>

</body>
</html>
