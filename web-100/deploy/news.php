<?php
session_start();
if(!$_SESSION['loggedin']){
        header("Location: login.php");
        exit;
};
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
        <li><a href="news.php" class="selected">&middot; news &middot;</a></li>
        <li><a href="shop.php">&middot; shop &middot;</a></li>
        <li><a href="logout.php">&middot; logout &middot;</a></li>
      </ul>
    </nav>
  </header>

  <section id="main">
  <h2>News</h2>
  <p>This is the first version of the new website. It is still in progress, but we do have a login form now. ;-)</p>
<footer>
   &copy;2013 Eindbazen
</footer>
</body>
</html>
