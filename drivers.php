<!DOCTYPE html>
<html>
<head>
<link href="animaldb.css" type="text/css" rel="stylesheet" >
</head>

<body>
<?php
$orgName = $_POST["name"];
echo "<h2>Drivers working at $orgName</h2>";


#run a query to get driver information from a particular rescue organization
$dbh = new PDO('mysql:host=localhost;dbname=animalrescueinfo', "root", "");
#user name and password for mysql when using XAMPP is "root" and a blank password

$rows = $dbh->query("SELECT Driver.fname, Driver.lname, Driver.license_number,
	Driver.license_plate, Driver.phone_num FROM drivesfor, Driver, organization
	WHERE organization.name = '$orgName' AND drivesfor.resc_ID 
	= organization.ID and drivesfor.Lic_num = driver.license_number");

if ($rows->rowCount() == 0)
	echo "<h3>No drivers found</h3>";

else {
	echo "<table>
	<tr><th>First Name</th><th>Last Name</th><th>License Number</th><th>License
	Plate</th><th>Phone Number</th></tr>";

	foreach($rows as $row) {
		echo "<tr><td>".$row[0]."</td><td>".$row[1]."</td><td>".$row[2]."</td><td>"
		.$row[3]."</td><td>".$row[4]."</td></tr>";
	}
	echo "</table><br />";
}
$dbh = null;

?>

<a href="rescuer_org_drivers.html">Search a different organization</a>

</body>
</html>
