<?php session_start(); ?>

<?php if(!isset($_SESSION["user_id"])){ 
	header("location:login.php");
} else{
	$user_id = $_SESSION["user_id"];
	
	$con = mysqli_connect("localhost","root","","jingle_final") or die("Error: " . mysqli_error($con));
		
	$result = mysqli_query($con,"select * from user where userid = ".$user_id);
	
	if(mysqli_num_rows($result) > 0){
		$row = mysqli_fetch_assoc($result);
	}
}
?>
 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/style.css">
  <title>JINGLE</title>
</head>
<body>
   <?php include("master_header.php"); ?>
  <!-- header -->
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
        <h1> <i class="fa fa-search"></i> Search</h1>
      </div>
    </div>  
  </div>
</header>

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
    <div class="row">      
      <div class="col-md-3 mr-auto">
	  <?php if(isset($_GET["search_music"])){ ?>
        <a href="posts.php" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Music</a>
	  <?php }else if(isset($_GET["search_cat"])){ ?>
		<a href="categories.php" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Categories</a>
	  <?php }else if(isset($_GET["search_artist"])){ ?>
		<a href="users.php" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Artists</a>
	  <?php } ?>
      </div>
    </div>
  </div>
</section>
<section id="posts">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="card">
            <div class="card-header">
              <h4>All Music</h4>
            </div>
			<table class="table table-striped" >
				<?php
				$tblname = "";
				if(isset($_GET["search_music"])){ ?>
				<thead class="thead-inverse">
				  <tr>
					<th>#</th>
					<th>Title</th>
					<th>Artists</th>
					<th>Category</th>
					<th>Date Posted</th>  														
					<th></th>							
					<th></th>							
				  </tr>
				</thead>
					
				<?php
					$query = $_GET['search_music'];     
					$tblname = "music";
					$query = htmlspecialchars($query); 	 
					$query = mysqli_real_escape_string($con,$query);	
									
					$sql = "SELECT * FROM (SELECT m.id id,@a:=@a+1 sr_no,m.name title,c.`name` category,DATE_FORMAT(m.`date_added`,'%e/%c/%Y') date_added, m.artist artist FROM music m ,categories c ,(SELECT @a:= 0 ) a WHERE m.`category_id` = c.`id` ORDER BY m.`date_added` DESC) s WHERE s.title LIKE '%".$query."%' OR s.category LIKE '%".$query."%' OR s.artist LIKE '%".$query."%'";
					
					
					$result = mysqli_query($con, $sql);
					$rows = mysqli_num_rows($result);
					echo "<tbody>";
					if($rows){
						$i = 0;
						while($post = mysqli_fetch_assoc($result)) {
							?>
								<tr>
								<td><?=$post["sr_no"]?></td>
								<td><?=$post["title"]?></td>
								<td><?=$post["artist"]?></td>
								<td><?=$post["category"]?></td>
								<td><?=$post["date_added"]?></td>
								<td><a href="details.php?id=<?=$post["id"]?>" class="fa fa-edit" ></a></td>
								<td><a href="<?=$_SERVER['PHP_SELF']?>?id=<?=$post["id"]?>&del=1" class="fa fa-trash"></a></td>
							  </tr>
							<?php
						}
					}else{ 
					echo "No results";
					}
				}else if(isset($_GET["search_cat"])){ ?>
				<thead class="thead-inverse">
				  <tr>
					<th>#</th>
					<th>Name</th>
					<th></th>							
					<th></th>							
				  </tr>
				</thead>
					
				<?php
					$query = $_GET['search_cat'];     
					$tblname  = "categories";
					$query = htmlspecialchars($query); 	 
					$query = mysqli_real_escape_string($con,$query);	
				
					
					$sql = "SELECT @a:=@a+1 sr_no,id,name FROM categories,(SELECT @a:= 0 ) a WHERE name LIKE '%".$query."%'";
					
					$result = mysqli_query($con, $sql);
					$rows = mysqli_num_rows($result);
					echo "<tbody>";
					if($rows){
						$i = 0;
						while($post = mysqli_fetch_assoc($result)) {
							?>
								<tr>
								<td><?=$post["sr_no"]?></td>
								<td><?=$post["name"]?></td>
								<td><a href="details.php?id=<?=$post["id"]?>" class="fa fa-edit" ></a></td>
								<td><a href="<?=$_SERVER['PHP_SELF']?>?id=<?=$post["id"]?>&del=1" class="fa fa-trash"></a></td>
							  </tr>
							<?php
						}
					}else{ 
					echo "No results";
					}
				} else if(isset($_GET["search_artist"])){ ?>
				<thead class="thead-inverse">
				  <tr>
					<th>#</th>
					<th>Name</th>
					<th></th>							
					<th></th>							
				  </tr>
				</thead>
					
				<?php
					$query = $_GET['search_artist'];     
					$tblname  = "categories";
					$query = htmlspecialchars($query); 	 
					$query = mysqli_real_escape_string($con,$query);	
				
					
					$sql = "SELECT @a:=@a+1 sr_no,id,name FROM artists,(SELECT @a:= 0 ) a WHERE name LIKE '%".$query."%'";
					
					$result = mysqli_query($con, $sql);
					$rows = mysqli_num_rows($result);
					echo "<tbody>";
					if($rows){
						$i = 0;
						while($post = mysqli_fetch_assoc($result)) {
							?>
								<tr>
								<td><?=$post["sr_no"]?></td>
								<td><?=$post["name"]?></td>
								<td><a href="details.php?id=<?=$post["id"]?>" class="fa fa-edit" ></a></td>
								<td><a href="<?=$_SERVER['PHP_SELF']?>?id=<?=$post["id"]?>&del=1" class="fa fa-trash"></a></td>
							  </tr>
							<?php
						}
					}else{ 
					echo "No results";
					}
				}
				?>
				
				</tbody>		
			</table>
			
		  </div>
		</div>
      </div>
    </div>
  </section>
  
   <footer id="main-footer" class="text-center text-white bg-inverse mt-5 p-5">
    <div class="container">
      <div class="row">
        <div class="col">
          <p class="lead">Copyright 2018  &copy; JINGLE</p>
          
        </div>
      </div>
    </div>
    
  </footer>

</body>
</html>