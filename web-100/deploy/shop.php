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
        <li><a href="news.php">&middot; news &middot;</a></li>
        <li><a href="shop.php" class="selected">&middot; shop &middot;</a></li>
        <li><a href="logout.php">&middot; logout &middot;</a></li>
      </ul>
    </nav>
  </header>

  <section id="main">
  <h2>Shop</h2>
  <p>See our products in below table.</p>
  <table>
    <tr>
      <th>&nbsp;</th><th>Name</th><th>Price</th>
    </tr><tr>
      <td width="100px"><img src="tulpen_430.JPG" width="100px"></td><td>Yellow Tulip</td><td>&euro; 0,79</td>
    </tr><tr>
      <td><img src="Tulpe32.jpg" width="100px"></td><td>White Tulip</td><td>&euro; 0,79</td>
      </tr><tr>
      <td><img src="Tulpe35.jpg" width="100px"></td><td>Pink Tulip</td><td>&euro; 0,89</td>
      </tr><tr>
      <td><img src="Tulpe7.JPG" width="100px"></td><td>Red/Yellow Tulip</td><td>&euro; 1,99</td>
      </tr>
    </table>
  </section>
<footer>
   &copy;2013 Eindbazen
</footer>
</body>
</html>
