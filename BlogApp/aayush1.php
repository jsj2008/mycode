


<?php




$con = mysql_connect("localhost","root","");

if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

  
if (mysql_query("CREATE DATABASE my_db",$con))
  {
  echo "Database created";
  }
mysql_select_db("my_db", $con);

if ( !empty($_POST) ) 
{

$title=$_REQUEST[Title];
$blog=$_REQUEST[Blog];
mysql_query("INSERT INTO blogger
(title, blog) VALUES('$title', '$blog' ) ") 
or die(mysql_error());
}

mysql_select_db("my_db") or die(mysql_error());
$result = mysql_query("SELECT * FROM blogger");

$kv = array();

while ($row = mysql_fetch_array($result, MYSQL_NUM)) 
{
    $kv[$row[0]] = "'$row[1]'";
 
}

echo json_encode($kv);
mysql_close($con);

?>
