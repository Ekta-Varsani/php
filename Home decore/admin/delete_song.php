<?php session_start(); ?>

<?php 

	if(isset($_GET["id"]) and isset($_GET["del"])){
		$con = mysqli_connect("localhost","root","","jingle_final") or die("Error: " . mysqli_error($con));
		$music_id = $_GET["id"];
		$music_res = mysqli_query($con,"delete from music where id = ".$music_id);
	
		if(mysqli_affected_rows($con) > 0){ ?>
			<script>
				window.alert("Song deleted successfully!");
			</script>
<?php 	}
	
		mysqli_close($con);
	} else if(isset($_GET["cat_id"]) and isset($_GET["del"])){
		$con = mysqli_connect("localhost","root","","jingle_final") or die("Error: " . mysqli_error($con));
		$music_id = $_GET["cat_id"];
		$music_res = mysqli_query($con,"delete from categories where id = ".$music_id);
	
		if(mysqli_affected_rows($con) > 0){ ?>
			<script>
				window.alert("Category deleted successfully!");
			</script>
<?php 	}
	
		mysqli_close($con);
	} else if(isset($_GET["art_id"]) and isset($_GET["del"])){
		$con = mysqli_connect("localhost","root","","jingle_final") or die("Error: " . mysqli_error($con));
		$music_id = $_GET["art_id"];
		$music_res = mysqli_query($con,"delete from artists where id = ".$music_id);
	
		if(mysqli_affected_rows($con) > 0){ ?>
			<script>
				window.alert("Artist deleted successfully!");
			</script>
<?php 	}
	
		mysqli_close($con);
	}	
?>