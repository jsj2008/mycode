<?php
$response = print_r($_REQUEST, true);


$keys= (array_keys($_REQUEST));
$i=count($keys);



$con = mysql_connect("localhost","root","");
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
mysql_select_db("my_db", $con);
//mysql_query("drop table blogger");
//mysql_query("CREATE TABLE blogger(
 //title VARCHAR(30), 
 // blog VARCHAR(300))")
// or die(mysql_error());


for ( $counter = 0; $counter <$i; $counter += 1) 
{

$key=$keys[$counter];
$blog=$_REQUEST[$key];
mysql_query("INSERT INTO blogger (title, blog) VALUES('$key', $blog ) ")  or die(mysql_error());
}
mysql_close($con);
echo "done"
?>





