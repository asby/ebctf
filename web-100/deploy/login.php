<?php
//Start session
session_start();
 
// Some vars we use
$ip = $_SERVER['REMOTE_ADDR'];
foreach ($_POST as $key => $value){
    if (preg_match('/^user/', $key)){
        $userField = $key;
        $userName = $value;
    } elseif (preg_match('/^pass/', $key)){
        $passField = $key;
        $password = md5($value);
    }
}

// Connect to database
$db = new PDO('sqlite:users.sqlite');

// Check user/pass fields
if($_SERVER['REQUEST_METHOD'] == "POST")  {

    // Blacklist some items
    $blacklist = array(';','attach','load_extension','pragma','delete','update','create','drop','insert','replace','detach','conflict','reindex','index','vacuum');
    foreach ($blacklist as $bl){
        if (strpos($passField,$bl) !== false){
            print "Be gentle... $bl not allowed";
            header("Location: login.php");
            exit;
        }
    }
    $sth = $db->prepare("SELECT count(*) FROM FieldTable WHERE ipAddress = :ip AND userField = :uf AND passField = '" . $passField . "'"); 
    if (is_object($sth)){
        $sth->bindParam(":ip", $ip);
        $sth->bindParam(":uf", $userField);
        $sth->execute();
        $result = $sth->fetchAll();
        if ($result[0][0] !== '0'){
            print $result[0][0] . ": ";

            // Continue checking user/pass
            $sth = $db->prepare("SELECT COUNT(*) FROM userTable WHERE userName = ? AND password = ?");
            $sth->execute(array($userName,$password));
            if ($sth->fetchColumn() > 0){
                $_SESSION['loggedin'] = true;
            }
        } else {
            print "0: ";
        }
    } else {
        print "ERROR : ";
    }
 
    //If the session variable is true, exit to home page.
    if(isset($_SESSION['loggedin'])){
        print "Logged in\n";
        header("Location: home.php");
        exit;
    } else {
        print "Login failed\n";
        header("Location: login.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8" />

  <title>Tulip Shop 0.1</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body id="home">

  <header>
    <div id="logo">Tulip Shop</div>
    <nav id="menu">
      <ul>
        <li><a href="home.php">&middot; home &middot;</a></li>
        <li><a href="news.php">&middot; news &middot;</a></li>
        <li><a href="shop.php">&middot; shop &middot;</a></li>
        <li><a href="login.php" class="selected">&middot; login &middot;</a></li>
      </ul>
    </nav>
  </header>

  <section id="main">
  <h2>Login</h2>




<div id="box">
        <form action="login.php" method="post">
<?php

    $charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    $userField = 'user';
    $passField = 'pass';
    for($i=0;$i<8;$i++){
        $userField .= $charset[mt_rand(0, strlen($charset)-1)];
        $passField .= $charset[mt_rand(0, strlen($charset)-1)];
    }

    $db->exec("DELETE FROM FieldTable WHERE ipAddress='$ip'");
    $insert = "INSERT INTO FieldTable (ipAddress, userField, passField) VALUES (:ip, :userField, :passField)";
    $sth = $db->prepare($insert);
    $sth->bindParam(':ip', $ip);
    $sth->bindParam(':userField', $userField);
    $sth->bindParam(':passField', $passField);
    $sth->execute();

    print '<p><label for="user">Username:</label> <input name="' . $userField . '" type="text" /></p>';
    print '<p><label for="pass">Password:</label> <input name="' . $passField . '" type="password" /></p>';

?>
    <p><input name="submit" type="submit" value="Login" /></p>
    </form>
        <p><strong>Demo Login: </strong>test/test</p>
</div>
</body>
</html>
