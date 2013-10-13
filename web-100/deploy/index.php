<?php
session_start();
if(!$_SESSION['loggedin']){
        header("Location: login.php");
        exit;
} else {
        header("Location: home.php");
};
?>
