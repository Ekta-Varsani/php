<?php session_start();

if(isset($_SESSION["error"]) and $_SESSION["error"] == "1"){ ?>
<script>
	window.alert("Invalid username or password!");
</script>
<?php 
unset($_SESSION["error"]);
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
  
  <title>USER LOGIN</title>
</head>
<body>
  

  <!-- header -->
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
        <h1> <i class="fa fa-user"></i> HOME DECORE</h1>
      </div>
    </div>  
  </div>
</header>


    <!-- section -->

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
    <div class="row">
      
        
    </div>
  </div>  
</section>


  <!-- POSTS -->

  <section id="posts">
    <div class="container">
      <div class="row">
        <div class="col-md-6 offset-md-3">
          <div class="card">
            <div class="card-header">
            <h4>Account Login</h4>
            </div>
            <div class="card-block">
            <form action="login_check.php" method="post">
				<div class="form-group">
				<label for="email">Email</label>
				<input type="email" name="username" class="form-control" required>
				</div>
				<div class="form-group">
				<label for="password">Password</label>
				<input type="password" name="password" class="form-control" required>
				</div>
				<div class="form-group">
					<input type="submit" value="Login" class="btn btn-primary btn-block" />
				</div>
            </form>
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

  <script src="js/jquery.min.js"></script>
  <script src="js/tether.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="https://cdn.ckeditor.com/4.10.1/standard/ckeditor.js"></script>
  <script>
    CKEDITOR.replace('editor1');
  </script>
</body>
</html>
