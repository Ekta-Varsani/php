<?php 
session_start();
	$con = mysqli_connect("localhost","root","","homedecore") or die("Error: " . mysqli_error($con));
?>

<?php 
	if(isset($_GET["id"]) and isset($_GET["del"])){
		 
		$did = $_GET["id"];
		$design_res = mysqli_query($con,"delete from designs where did = ".$did);
	
		if(mysqli_affected_rows($con) > 0){ ?>
			<script>
				window.alert("Design deleted successfully!");	
				window.location.assign("index.php");
			</script>
<?php 	}else{ ?>
			<script>
				window.alert("Error while deleting!" + <?= mysqli_error($con) ?>);
			</script>
	<?php
		}				
		 
	}	
?>

<?php
$bedroom_count = "";
$hall_count = "";
$kitchen_count = "";
 if(!isset($_SESSION["user_id"])){ 
	header("location:login.php");
} else{
	
	$user_id = $_SESSION["user_id"];
	

		
	$result = mysqli_query($con,"select * from designs");
	
	if(mysqli_num_rows($result) > 0){
		$row = mysqli_fetch_assoc($result);
	}
	
	$m = mysqli_query($con,"select count(*) from designs where design_placement = 'bedroom'");
	$c = mysqli_query($con,"select count(*) from designs where design_placement = 'hall'");
	$a = mysqli_query($con,"select count(*) from designs where design_placement = 'kitchen'");
	
	if(mysqli_num_rows($m) > 0){
		$mr = mysqli_fetch_array($m);
		$bedroom_count = $mr[0];
	}
	if(mysqli_num_rows($c) > 0){
		$mr = mysqli_fetch_array($c);
		$hall_count = $mr[0];
	}
	if(mysqli_num_rows($a) > 0){
		$mr = mysqli_fetch_array($a);
		$kitchen_count = $mr[0];
	}
	

}
?>

<?php
if(isset($_GET["add"])){

	if(isset($_POST["desc"])){ 
		$con = mysqli_connect("localhost","root","","homedecore") or die("Error: " . mysqli_error($con));
    $design_img = "";
		$design_desc = $_POST["desc"];
		$design_location = $_POST["loc"];
		
		if($_FILES["design_image_path"]['error'] == "0"){
			$target="img/".basename($_FILES['design_image_path']['name']);
			if(move_uploaded_file($_FILES['design_image_path']['tmp_name'],$target)) {
				$fname = "img/".basename($_FILES['design_image_path']['name']);
        $design_img = $_FILES['design_image_path']['name'];	
			}
		}
    else{
      $msg = "Image Not Uploaded!";
      $design_img = "";	

    }

    $sql = "insert into designs(description,design_placement,dimg_path) values('".$design_desc."','".$design_location."','".$design_img."')";

    //echo $sql;
		
		$music_res = mysqli_query($con,$sql);
		
		if(mysqli_affected_rows($con) > 0){ 
      $x = mysqli_query($con,"delete from temp");
      $x = mysqli_query($con,"call split_string()");
      ?>
			<script>
				window.alert("Design added successfully!");	
				window.location.assign("index.php");
				
			</script>
<?php 	}else{ ?>
			<script>
				window.alert("Error while adding!" + <?= mysqli_error($con) ?>);
			</script>
	<?php
		}				
		 
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
  <title>Home Decor Admin Panel</title>
</head>
<body>
    <?php include("master_header.php"); ?>

  <!-- header -->
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
        <h1> <i class="fa fa-gear"></i> Dashboard</h1>
      </div>
    </div>  
  </div>
</header>


    <!-- section -->

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
      <div class="col-md-3">
        <a href="#" class="btn btn-success btn-block" data-toggle="modal" data-target="#addCategoryModal">
          <i class="fa fa-plus"></i> Add New Design
        </a>
      </div>
    </div>
  </div>
</section>


  <!-- POSTS -->

  <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col-md-9">
          <div class="card">
            <div class="card-header">
              <h4>All Designs</h4>
            </div>
           
              <table class="table table-striped">
                <thead class="thead-inverse">
                  <tr>
                    <th>#</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Location</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
				<?php
						$sql = "SELECT * from designs ";
            $result = mysqli_query($con, $sql);
            $rows = mysqli_num_rows($result);
            echo "<tbody>";
            if($rows){
              $i = 0;
              while($post = mysqli_fetch_assoc($result)) {
                ?>
                  <tr>
                  <td><?=$post["did"]?></td>
                  <td><img src="img/<?=$post['dimg_path']?>" style="height:100; width:75px;"> </td>
                  <td><?=$post["description"]?></td>
                  <td><?=ucwords($post["design_placement"])?></td>
                  <td><a href="<?=$_SERVER['PHP_SELF']?>?id=<?=$post["did"]?>&del=1" class="fa fa-trash"></a></td>
                  </tr>
                <?php
              }
            }
					
				?>
               
                </tbody>
              </table>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card card-primary mb-3 text-center text-white">
              <div class="card-block">
                <h4>Bedroom</h4>
                <h1 class="display-4"><i class="fa fa-pencil">&nbsp; </i><?=$bedroom_count?> </h1>
                <a href="bedroom.php" class="btn btn-sm btn-outline-secondary text-white">View</a>
              </div>
            </div>
             <div class="card card-success mb-3 text-center text-white">
              <div class="card-block">
                <h4>Hall</h4>
                <h1 class="display-4"><i class="fa fa-pencil">&nbsp; </i><?=$hall_count?> </h1>
                <a href="hall.php" class="btn btn-sm btn-outline-secondary text-white">View</a>
              </div>
            </div>
             <div class="card card-warning mb-3 text-center text-white">
              <div class="card-block">
                <h4>Kitchen</h4>
                <h1 class="display-4"><i class="fa fa-pencil">&nbsp; </i><?=$kitchen_count?> </h1>
                <a href="kitchen.php" class="btn btn-sm btn-outline-secondary text-white">View</a>
              </div>
            </div>
            
          </div>
        </div>  
      </div>
    </div>
  </section>


  <footer id="main-footer" class="text-center text-white bg-inverse mt-5 p-5">
    <div class="container">
      <div class="row">
        <div class="col">
          <p class="lead">Copyright 2019  &copy; JINGLE</p>
          
        </div>
      </div>
    </div>
    
  </footer>




  <!-- Posts Modal-->

  <div class="modal fade" id="addPostModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Add Music</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form id="form_add_music" action="<?=$_SERVER['PHP_SELF']?>?add=1" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="text" name="title" class="form-control">
            </div>
            <div class="form-group">
              <label for="title" class="form-control-label">Artists</label>
              <input type="text" name="artists" class="form-control">
            </div>
            <div class="form-group">
              <label for="category" class="form-control-label">Category</label>
              <select name="category" class="form-control">
                <?php
					 
					
					$result = mysqli_query($con,"select * from categories");
					if(mysqli_num_rows($result) > 0){
						while($row = mysqli_fetch_assoc($result)){
							echo "<option value='".$row["id"]."'>".$row["name"]."</option>";							
						}
					}
					 
				?>
              </select>
            </div>
            <div class="form-group">
              <label for="category" class="form-control-label">Type</label>
              <select name="type" class="form-control">
                <option value="">None</option>
                <option value="new_release">New Release</option>
                <option value="most_popular">Most Popular</option>
                <option value="trending">Trending</option>
              </select>
            </div>
			<div class="form-group">
              <label for="file">Video URL</label>
              <input name="video_url" type="url" class="form-control" id="file">              
            </div>
			<div class="form-group">
              <label for="date">Date:</label>
              <input name="date_added" type="date" class="form-control-sm" id="date" value="<?=date('Y-m-d')?>">              
            </div>
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input name="image_path" type="file" class="form-control-file" id="file">
              <small class="form-text text-muted">Max 3MB</small>
            </div>
             <div class="form-group">
              <label for="file">Audio Upload</label>
              <input name="audio_path" type="file" class="form-control-file" id="file">
              <small class="form-text text-muted">Max 3MB</small>
            </div>
            
            <div class="form-group">
              <label for="body">Body</label>
              <textarea name="lyrics" class="form-control"></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button type="submit" form="form_add_music" class="btn btn-primary" data-dismiss="modal" onclick="event.preventDefault();document.getElementById('form_add_music').submit();" >Add Music</button>
        </div>
      </div>
    </div>
  </div>


  <!-- Modal Category -->
  <div class="modal fade" id="addCategoryModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title">Add Design</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form id="form_add_category" action="<?=$_SERVER['PHP_SELF']?>?add=1" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="desc" class="form-control-label">Design Description</label>
              <input type="text" name="desc" class="form-control">
            </div>
            <div class="form-group">
              <label for="loc" class="form-control-label">Design Location</label>
              <select name="loc" class="form-control">
                <option value="bedroom">Bedroom</option>
                <option value="hall">Hall</option>
                <option value="kitchen">Kitchen</option>
              </select>
            </div>
            <div class="form-group">
              <label for="file">Select Design Image</label>
              <input type="file" name="design_image_path" class="form-control-file" id="file">
              <small class="form-text text-muted">Max 3MB</small>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button type="submit" form="form_add_category" class="btn btn-success" data-dismiss="modal" onclick="event.preventDefault();document.getElementById('form_add_category').submit();">Add Design</button>
        </div>
      </div>
    </div>
  </div> 


<!-- Header Users -->

  <div class="modal fade" id="addUserModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-warning text-white">
          <h5 class="modal-title">Add Artist</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form id="form_add_artist" action="<?=$_SERVER['PHP_SELF']?>?add=1" method="post" enctype="multipart/form-data">
		  <div class="form-group">              
              <input id="ar_image_path" name="img" type="hidden"  />
            </div>
			<div class="form-group">
              <label for="artist_name" class="form-control-label">Name</label>
              <select id="artist_name" name="artist_name" class="form-control">
                <?php
					 
					
					$result = mysqli_query($con,"select * from artists");
					if(mysqli_num_rows($result) > 0){
						echo "<script>var body = {};</script>";
						echo "<script>var img = {};</script>";
						while($row = mysqli_fetch_assoc($result)){
							echo "<option value='".$row["id"]."'>".$row["name"]."</option>";	
							echo "<script>body[".$row["id"]."] = '".$row['desc']."';</script>";
							echo "<script>img[".$row["id"]."] = '".$row['image_path']."';</script>";
						}
					}
					
					 					
				?>
              </select>
            </div>
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input type="file" name="artist_image_path" class="form-control-file" id="file">
              <small class="form-text text-muted">Max 3MB</small>
            </div>
			<div class="form-group">
              <label for="body">Body</label>
              <textarea id="artist_desc" name="artist_desc" class="form-control"></textarea>
            </div>
		  </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button type="submit" form="form_add_artist" class="btn btn-warning" data-dismiss="modal" onclick="event.preventDefault();document.getElementById('form_add_artist').submit();">Save</button>
        </div>
      </div>
    </div>
  </div>

  <script src="js/jquery.min.js"></script>
  <script src="js/tether.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="https://cdn.ckeditor.com/4.10.1/standard/ckeditor.js"></script>
  <script>
    CKEDITOR.replace('editor1');
  </script>
  <script>
	var artist = document.getElementById("artist_name");
	artist.addEventListener("change", function() {		
		document.getElementById('artist_desc').value = body[artist.value];
		document.getElementById('ar_image_path').value = img[artist.value];
	});

  </script>
</body>
</html>