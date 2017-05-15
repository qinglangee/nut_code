<?php
require ("mysql2.php");

echo "sss\n";

$ppp = new pdomysql();

$one = $ppp->fetOne("php_user");

print $one["name"] . $one["age"];

class AA{
	public function hi(){
		echo "hi..";
	}
}

$people = new AA();
// $people->hi();


$DB = new PDO ( "mysql:host=localhost;port=3306;dbname=zhch", "zhch", "zhch", array (
     PDO::ATTR_PERSISTENT => true
   ) );


$DB->setAttribute ( PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true );
$DB->setAttribute ( PDO::ATTR_EMULATE_PREPARES, true );

$sql = "SELECT * FROM `zhch`";
  // $sql .= ($where) ? " WHERE $where" : '';
$stmt = $DB->query ( $sql );
// $stmt->setFetchMode ( PDO::FETCH_ASSOC );
// $result = self::$stmt->fetch ();
$stmt = null;



// $one = $result;
// print $one["name"] . $one["age"];