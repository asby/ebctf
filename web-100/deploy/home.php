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
        <li><a href="home.php" class="selected">&middot; home &middot;</a></li>
        <li><a href="news.php">&middot; news &middot;</a></li>
        <li><a href="shop.php">&middot; shop &middot;</a></li>
        <li><a href="logout.php">&middot; logout &middot;</a></li>
      </ul>
    </nav>
  </header>

  <section id="main">
  <h2>Home</h2>
  <p>Welcome to the new Tulip Shop website. Soon we will launch our new webshop so that you can buy Tulips online, but for now you can look at our <a href="shop.php">fantastic products</a> and order them by email.</p>
<footer>
   &copy;2013 Eindbazen
</footer>
</body>
</html>
