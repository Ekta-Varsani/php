
<nav class="navbar navbar-toggleable-sm navbar-inverse bg-inverse p-0">
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" data-target="#mynavbar" data-toggle="collapse">
        <span class="navbar-toggler-icon"></span>
        
      </button>
      <a href="index.php" class="navbar-brand mr-3">Home Decor</a>
      <div class="collapse navbar-collapse id="mynavbar">
      <ul class="navbar-nav">
        <li class="nav-item px-2">
          <a href="index.php" class="nav-link ">Dashboard</a>
        </li>
         <li class="nav-item px-2">
          <a href="bedroom.php" class="nav-link ">Bedroom</a>
        </li>
         <li class="nav-item px-2">
          <a href="hall.php" class="nav-link">Hall</a>
        </li>
         <li class="nav-item px-2">
          <a href="kitchen.php" class="nav-link">Kitchen</a>
        </li>
        
      </ul>
      <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown mr-3">
          <a href="" class="nav-link" >
            <i class="fa fa-user"> </i>   Welcome Admin <?/*= $row["fname"] */?> 
          </a>
          
        </li>
        <li class="nav-item">
          <a href="logout.php" class="nav-link"><i class="fa fa-user-times"></i> logout</a>
          
        </li>
      </ul>
    </div>
  </div>
</nav>