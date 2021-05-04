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

	if(isset($_GET["id"])){
		$music_id = $_GET["id"];
		$music_res = mysqli_query($con,"select * from music where id = ".$music_id);
	
		if(mysqli_num_rows($music_res) > 0){
			$music_row = mysqli_fetch_assoc($music_res);
		}
	}else if(isset($_GET["cat_id"])){
		$music_id = $_GET["cat_id"];
		$music_res = mysqli_query($con,"select * from categories where id = ".$music_id);
	
		if(mysqli_num_rows($music_res) > 0){
			$music_row = mysqli_fetch_assoc($music_res);
		}
	}else if(isset($_GET["art_id"])){
		$music_id = $_GET["art_id"];
		$music_res = mysqli_query($con,"select * from artists where id = ".$music_id);
	
		if(mysqli_num_rows($music_res) > 0){
			$music_row = mysqli_fetch_assoc($music_res);
		}
	}else{
		header("location:index.php");
	}
	if(isset($_GET["id"])){
		if(isset($_POST["title"])){ 
	
			$title = $_POST["title"];
			$artist = $_POST["artist"];
			$category = $_POST["category"];
			$type = $_POST["type"];
			$video_url = $_POST["video_url"];
			// $image = $_POST["title"];
			// $audio = $_POST["title"];
			$lyrics = $_POST["editor1"];	
			
			if($_FILES["image_path"]['error'] == "0"){
				$target="../images/".basename($_FILES['image_path']['name']);
				if(move_uploaded_file($_FILES['image_path']['tmp_name'],$target)) {
					$fname = "images/".basename($_FILES['image_path']['name']);
				}
			}else{
				$fname  =$music_row["image_path"];				
			}
				
			if($_FILES["audio_path"]['error'] == "0"){
				$target="../audio/".basename($_FILES['audio_path']['name']);
				if(move_uploaded_file($_FILES['audio_path']['tmp_name'],$target)) {
					$aname = "audio/".basename($_FILES['audio_path']['name']); 				
				}
			}else{
				$aname  =$music_row["audio_path"];				
			}
			
			$sql = "update music set name='".$title."',artist='".$artist."', category_id='".$category."',video_url='".$video_url."',lyrics='".$lyrics."',type='".$type."',image_path='".$fname."',audio_path='".$aname."' where id = ".$music_id;
			
			$r = mysqli_query($con,$sql);
			
			if(mysqli_affected_rows($con) > 0){ ?>
				<script>
					window.alert("Song updated successfully!");
					window.location.assign("posts.php");
				</script>
<?php	 	} else{ ?>
				<script>
					window.alert("Error while updating!" + <?= mysqli_error($con) ?>);
				</script>
<?php
			}			
		} 
	}else if(isset($_GET["cat_id"])){
		if(isset($_POST["title"])){ 
	
			$title = $_POST["title"];
			if($_FILES["image_path"]['error'] == "0"){
				$target="../images/".basename($_FILES['image_path']['name']);
				if(move_uploaded_file($_FILES['image_path']['tmp_name'],$target)) {
					$fname = "images/".basename($_FILES['image_path']['name']);
				}
			}else{
				$fname  =$music_row["image_path"];				
			}
			
			$sql = "update categories set name='".$title."',image_path='".$fname."' where id = ".$music_id;
			
			$r = mysqli_query($con,$sql);
			
			if(mysqli_affected_rows($con) > 0){ ?>
				<script>
					window.alert("Category updated successfully!");
					window.location.assign("categories.php");
				</script>
<?php	 	} else{ ?>
				<script>
					window.alert("Error while updating!" + <?= mysqli_error($con) ?>);
				</script>
<?php
			}			
		} 
	}else if(isset($_GET["art_id"])){
		if(isset($_POST["title"])){ 
	
			$title = $_POST["title"];
			$desc = $_POST["artist_desc"];
			// $image = $_POST["title"];
			if($_FILES["image_path"]['error'] == "0"){
				$target="../images/".basename($_FILES['image_path']['name']);
				if(move_uploaded_file($_FILES['image_path']['tmp_name'],$target)) {
					$fname = "images/".basename($_FILES['image_path']['name']);
				}
			}else{
				$fname  =$music_row["image_path"];				
			}
			
			$sql = "update artists set name='".$title."',image_path='".$fname."',`desc`='".$desc."' where id = ".$music_id;
			
			$r = mysqli_query($con,$sql);
			
			if(mysqli_affected_rows($con) > 0){ ?>
				<script>
					window.alert("Artist updated successfully!");
					window.location.assign("users.php");
				</script>
<?php	 	} else{ ?>
				<script>
					window.alert("Error while updating!" + <?= mysqli_error($con) ?>);
				</script>
<?php
			}			
		} 
	}else{
		header("location:index.php");
	}
}	
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>EDIT DETAIL</title>
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

<?php
if(isset($_GET["id"])){ ?>
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
	<h1> Music Details</h1>
<?php
}else if(isset($_GET["cat_id"])){ ?>
<header id="main-header" class="bg-success py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
	<h1> Category Details</h1>
<?php
}else if(isset($_GET["art_id"])){ ?>
<header id="main-header" class="bg-warning py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
	<h1> Artist Details</h1>
<?php
}	
?>     
		</div>
    </div>  
  </div>
</header>


    <!-- section -->

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
    <div class="row">
      <div class="col-md-3 mr-auto">
<?php
if(isset($_GET["id"])){ ?>
	<a href="posts.php" id="music" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Music</a>
<?php
}else if(isset($_GET["cat_id"])){ ?>
	<a href="categories.php" id="cat" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Categories</a>
<?php
}else if(isset($_GET["art_id"])){ ?>
	<a href="users.php"  id="art" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Artists</a>
<?php
}	
?>
		
		
      </div>
       <div class="col-md-3">
<?php
if(isset($_GET["id"])){ ?>
	<button type="submit" name="submit" form="form_id" class="btn btn-success btn-block"><i class="fa fa-check"></i> Save Changes</button>
<?php
}else if(isset($_GET["cat_id"])){ ?>
	<button type="submit" name="submit" form="form_cat_id" class="btn btn-success btn-block"><i class="fa fa-check"></i> Save Changes</button>
<?php
}else if(isset($_GET["art_id"])){ ?>
	<button type="submit" name="submit" form="form_art_id" class="btn btn-success btn-block"><i class="fa fa-check"></i> Save Changes</button>
<?php
}	
?>
	
      </div>    
     </div>
    </div>
  </div>
  
</section>


  <!-- POSTS -->
<?php

if(isset($_GET["id"])){ ?>
 <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="card">
           <div class="card-header">
             <h4>Edit Music</h4>
           </div>
           <div class="card-block">
              <form action="details.php?id=<?=$music_id?>" id="form_id" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="text" name="title" class="form-control" value="<?=$music_row["name"]?>">
            </div>
			<div class="form-group">
              <label for="title" class="form-control-label">Artists</label>
              <input type="text" name="artist" class="form-control" value="<?=$music_row["artist"]?>">
            </div>
            <div class="form-group">
              <label for="category" class="form-control-label">Category</label>
              <select name="category" class="form-control">
                <?php
					$result = mysqli_query($con,"select * from categories");
					if(mysqli_num_rows($result) > 0){
						while($row = mysqli_fetch_assoc($result)){
							if($music_row["category_id"] == $row["id"]){
								echo "<option selected='selected' value='".$row["id"]."'>".$row["name"]."</option>";
							}else{
								echo "<option value='".$row["id"]."'>".$row["name"]."</option>";
							}
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
              <input type="url" name="video_url" class="form-control" value="<?=$music_row["video_url"]?>">
            </div>
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input type="file" name="image_path" value="not" class="form-control-file" id="file" />
              <small class="form-text text-muted">Max 3 MB</small>
            </div>
			<div class="form-group">
              <label for="file">Audio Upload</label>
              <input type="file"  name="audio_path" class="form-control-file" id="file">              
            </div>
            
            <div class="form-group">
              <label for="body">Body</label>
              <textarea name="editor1" class="form-control">
				<?=$music_row["lyrics"]?>
			  </textarea>
            </div>
          </form>
           </div>
          </div>  
          </div>
      </div>
    </div>
  </section>

	
<?php

}else if(isset($_GET["cat_id"])){ ?>
	 <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="card">
           <div class="card-header">
             <h4>Edit Category</h4>
           </div>
           <div class="card-block">
              <form action="details.php?cat_id=<?=$music_id?>" id="form_cat_id" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="text" name="title" class="form-control" value="<?=$music_row["name"]?>">
            </div>			
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input type="file"  name="image_path" class="form-control-file" id="file" />
              <small class="form-text text-muted">Max 3 MB</small>
            </div>			
          </form>
           </div>
          </div>  
          </div>
      </div>
    </div>
  </section>


<?php

}else if(isset($_GET["art_id"])){ ?>
	 <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="card">
           <div class="card-header">
             <h4>Edit Artist</h4>
           </div>
           <div class="card-block">
              <form action="details.php?art_id=<?=$music_id?>" id="form_art_id" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="text" name="title" class="form-control" value="<?=$music_row["name"]?>">
            </div>			
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input type="file"  name="image_path" class="form-control-file" id="file" />
              <small class="form-text text-muted">Max 3 MB</small>
            </div>	
            <div class="form-group">
              <label for="body">Body</label>
              <textarea id="artist_desc" name="artist_desc" class="form-control" >
              	<?=$music_row["desc"]?>
              </textarea>
            </div>		
          </form>
           </div>
          </div>  
          </div>
      </div>
    </div>
  </section>


<?php

}

?>
 
  <footer id="main-footer" class="text-center text-white bg-inverse mt-5 p-5">
    <div class="container">
      <div class="row">
        <div class="col">
          <p class="lead">Copyright 2018  &copy; JINGLE</p>
          
        </div>
      </div>
    </div>
    
  </footer>
  <script src="js/jquery.min.js"></script>
  <script src="js/tether.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="https://cdn.ckeditor.com/4.10.1/standard/ckeditor.js"></script>
  <script>
    CKEDITOR.replace('editor1');
  </script>
</body>
</html>
<?php 	mysqli_close($con);	
?>
