<?php session_start();

$con = mysqli_connect("localhost","root","","homedecore") or die("Error: " . mysqli_error($con));

?>


<?php 
	if(isset($_GET["id"]) and isset($_GET["del"])){
		$did = $_GET["id"];
    $sql = "delete from designs where did = ".$did;

		$temp = mysqli_query($con,$sql);
	
		if(mysqli_affected_rows($con) > 0){ ?>
			<script>
				window.alert("Design deleted successfully!");		
        
        window.location.assign("hall.php");		
			</script>
<?php 	}else{ ?>
			<script>
				window.alert("Error while deleting!");

        window.location.assign("hall.php");    
			</script>
	<?php
		}				
		mysqli_close($con);
	}	
?>

<?php
 if(!isset($_SESSION["user_id"])){ 
	header("location:login.php");
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
  <title>DESIGN DETAIL</title>
</head>
<body>
   <?php include("master_header.php"); ?>

  <!-- header -->
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
        <h1> <i class="fa fa-pencil"></i> Hall</h1>
      </div>
    </div>  
  </div>
</header>


    <!-- section -->

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-6">
       <form action="search.php" method="get">
	   <div class="input-group">
       <input type="text" name="search_music" class="form-control" placeholder="Search Something...." />
       <span class="input-group-btn">
         <button type="submit" class="btn btn-primary">Search</button>
       </span>
        </div>
		</form>
      </div>
      </div>
    </div>
  </div>
</section>


  <!-- POSTS -->

  <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="card">
            <div class="card-header">
              <h4>All Hall Design</h4>
            </div>
			<table class="table table-striped" >
			<thead class="thead-inverse">
						  <tr>
							<th>#</th>
              <th>Image</th>
							<th>Description</th>
              <th>Action</th>

					
						  </tr>
						</thead>
				<?php
				
				$sql = "SELECT * from designs WHERE design_placement = 'hall' ";
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
							<td><a href="<?=$_SERVER['PHP_SELF']?>?id=<?=$post["did"]?>&del=1" class="fa fa-trash"></a></td>
						  </tr>
						<?php
					}
				}
				?>
				</tbody>		
			</table>
			
			<nav class="ml-4">			
				<ul class="pagination">
					<?php
					$url = $_SERVER['PHP_SELF'];
					if(isset($page)){
						$result = mysqli_query($con,"select Count(*) As Total from music");
						$rows = mysqli_num_rows($result);
						if($rows){
							$rs = mysqli_fetch_assoc($result);
							$total = $rs["Total"];
						}
						$totalPages = ceil($total / $perpage);
						if($page <=1 ){
							echo "<li id='page_links' class='page-item disabled'><a href='#' class='page-link'>Prev</a></li>";
						}
						else{
							$j = $page - 1;
							echo "<li class='page-item'><a class='page-link' id='page_a_link' href='$url?page=$j'> Prev</a></li>";
						}
						for($i=1; $i <= $totalPages; $i++){
							if($i<>$page){
								echo "<li class='page-item'><a class='page-link' id='page_a_link' href='$url?page=$i'>$i</a></li>";
							}else{
								echo "<li id='page_links' class='page-item active'><a href='#' class='page-link'>$i</a></li>";
							}
						}
						if($page == $totalPages ){
							echo "<li id='page_links' class='page-item disabled'><a href='#' class='page-link'>Next </a></li>";
						}else{
							$j = $page + 1;
							echo "<li class='page-item'><a class='page-link' id='page_a_link' href='$url?page=$j'>Next</a></li>";
						}
					}
					?>
				</td>
				</ul>
			</nav>
           
			
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
          <h5 class="modal-title">Add Post</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="text" class="form-control">
            </div>
            <div class="form-group">
              <label for="category" class="form-control-label">Category</label>
              <select class="form-control">
                <option>Web Developement</option>
                <option>Tech Gadgets</option>
                <option>Bussiness</option>
                <option>Health & welleness</option>
              </select>
            </div>
            <div class="form-group">
              <label for="file">Image Upload</label>
              <input type="file" class="form-control-file" id="file">
              <small class="form-text text-muted">Max 3MB</small>
            </div>
             <div class="form-group">
              <label for="body">Body</label>
              <textarea name="editor1" class="form-control"></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button class="btn btn-primary" data-dismiss="modal">Add Post</button>
        </div>
      </div>
    </div>
  </div>


  <!-- Modal Category -->
  <div class="modal fade" id="addCategoryModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title">Add Category</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="title" class="form-control-label">Title</label>
              <input type="title" class="form-control">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button class="btn btn-success" data-dismiss="modal">Add Category</button>
        </div>
      </div>
    </div>
  </div> 


<!-- Header Users -->

  <div class="modal fade" id="addUserModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-warninng text-white">
          <h5 class="modal-title">Add User</h5>
          <button class="close" data-dismiss="modal"><span>&times;</span></button>
        </div>
        <div class="modal-body">
          <form>
           <div class="form-group">
             <label for="name">Name</label>
             <input type="name" class="form-control">
           </div>
           <div class="form-group">
             <label for="email">Email</label>
             <input type="email" class="form-control">
           </div>
           <div class="form-group">
             <label for="password">Password</label>
             <input type="password" class="form-control">
           </div>
           <div class="form-group">
             <label for="psd">Confirm Password</label>
             <input type="psd" class="form-control">
           </div>
          </form>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-dismiss="modal">Close</button>
           <button class="btn btn-warning" data-dismiss="modal">Add User</button>
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
</body>
</html>
