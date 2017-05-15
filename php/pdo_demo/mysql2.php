<?php
class pdomysql {
 public static $charset = '';
 public static $stmt = null;
 public static $DB = null;
 public static $connect = true; // 是否長连接
 public static $debug = false;
 private static $parms = array ();
  
 /**
  * 构造函数
  */
 public function __construct() {
  self::$charset = 'UTF8';
  self::connect ();
  self::$DB->setAttribute ( PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true );
  self::$DB->setAttribute ( PDO::ATTR_EMULATE_PREPARES, true );
 }
 public function connect() {
   self::$DB = new PDO ( "mysql:host=localhost;port=3306;dbname=zhch", "zhch", "zhch", array (
     PDO::ATTR_PERSISTENT => true
   ) );
 }
  
 public function fetOne($table, $field = '*', $where = false) {
  $sql = "SELECT {$field} FROM `{$table}`";
  //$sql = "SELECT {*} FROM `{'zhch'}`";

  $result = array ();
  self::$stmt = self::$DB->query ( $sql );
  self::$stmt->setFetchMode ( PDO::FETCH_ASSOC );
    $result = self::$stmt->fetch ();
  return $result;
 }
  
}