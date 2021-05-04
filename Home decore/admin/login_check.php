<?php session_start();
	if(isset($_POST["username"])){
		$email = $_POST["username"];
		$password = $_POST["password"];
		
		$con = mysqli_connect("localhost","root","","homedecore") or die("Error: " . mysqli_error($con));
		$qr = "select * from admin where email ='". $email."' and pass = '".$password."'";


		$result = mysqli_query($con,$qr);
		
		if(mysqli_num_rows($result) > 0){
			$row = mysqli_fetch_assoc($result);
			$_SESSION["user_id"] = $row["id"];
			header("location:index.php");
		}else{
			$_SESSION["error"] = "1";
			header("location:login.php");
		}
	}
?>