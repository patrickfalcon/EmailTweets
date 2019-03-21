<?php

session_start();
if ($_POST["tweet"]=="") {
	header("Location: index.php");
	return;
} else {
	tweet($_POST["tweet"]);
	$_SESSION["lTweet"]=$_POST["tweet"];
	header("Location: index.php");
}

/**
 * Posts a tweet
 */
function tweet($tweetMSG) {
	$tweetMSG=wordwrap($tweetMSG,70);
	mail("pf313@live.mdx.ac.uk","tweet: ".$tweetMSG,"Sent from: ".$_SERVER["REMOTE_ADDR"]);
}

?>