<?php
session_start();

?>

<link href="bootstrap.css" rel="stylesheet">

<?php

if ($_SESSION["lTweet"] !== "") {
    echo "Last tweet: " . $_SESSION["lTweet"] ."<br>";
}


?>

<form method="post" action="tweet.php">
<input type="text" id="tweet" name="tweet" placeholder="Tweet">
<input type="submit" class="twitter" value="Post Tweet!">

</form> 