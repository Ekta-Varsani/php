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
  <nav class="navbar navbar-toggleable-sm navbar-inverse bg-inverse p-0">
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" data-target="#mynavbar" data-toggle="collapse">
        <span class="navbar-toggler-icon"></span>
        
      </button>
      <a href="index.php" class="navbar-brand mr-3">Blogan</a>
      <div class="collapse navbar-collapse id="mynavbar>
      <ul class="navbar-nav">
        <li class="nav-item px-2">
          <a href="index.php" class="nav-link ">Dashboard</a>
        </li>
         <li class="nav-item px-2">
          <a href="posts.php" class="nav-link ">Posts</a>
        </li>
         <li class="nav-item px-2">
          <a href="categories.php" class="nav-link">Categories</a>
        </li>
         <li class="nav-item px-2">
          <a href="users.php" class="nav-link">Users</a>
        </li>
        
      </ul>
      <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown mr-3">
          <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-user"> </i>   welcome deep
          </a>
          <div class="dropdown-menu">
            <a href="profile.php" class="dropdown-item"><i class="fa fa-user-circle"></i> Profile</a>
            <a href="Settings.php" class="dropdown-item"><i class="fa fa-user-circle"></i> Settings</a>
            
          </div>
        </li>
        <li class="nav-item">
          <a href="login.php" class="nav-link"><i class="fa fa-user-times"></i> logout</a>
          
        </li>
      </ul>
    </div>
  </div>
</nav>


  <!-- header -->
<header id="main-header" class="bg-primary py-2 text-white">
  <div class="container"> 
    <div class="row">
      <div class="col-md-6">
        <h1><i class="fa fa-gear"></i> Settings</h1>
      </div>
    </div>  
  </div>
</header>


    <!-- section -->

<section id="sections" class="py-4 mb-4 bg-faded">
  <div class="container">
    <div class="row">
      <div class="col-md-3 mr-auto">
        <a href="index.php" class="btn btn-secondary btn-block"><i class="fa fa-arrow-left"></i> Back To Dashboard</a>
      </div>
       <div class="col-md-3">
        <a href="index.php" class="btn btn-success btn-block"><i class="fa fa-check"></i> Save Changes</a>
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
             <h4>Edit Settings</h4>
           </div>
           <div class="card-block">
              <form>
                <fieldset class="from-group">
                  <legend>Allow User Registration</legend>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input type="radio" class="form-check-input" value="yes" checked> Yes
                    </label>
                  </div>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input type="radio" class="form-check-input" value="no"> No
                    </label>
                  </div>
                </fieldset>
                 <fieldset class="from-group">
                  <legend>Homepage Format</legend>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input type="radio" class="form-check-input" value="yes" checked> Post Index
                    </label>
                  </div>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input type="radio" class="form-check-input" value="no"> Single Page
                    </label>
                  </div>
                </fieldset>
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
