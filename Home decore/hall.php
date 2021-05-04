<?php session_start();

$con = mysqli_connect("localhost","root","","homedecore") or die("Error: " . mysqli_error($con));





?>

<!DOCTYPE html>
<html>
    <head>
        <title>Hall</title>
        <link rel="stylesheet" type="text/css"
        href="css/style.css">
    </head>
    <body>
        
        <header>
            <div class="home">
                <div class="row">
                    <table>
                        <tr>
                            <td><img class="header-logo" src="images/logo1.png"></td>
                            
                            <td>
                                <div class="header-nav">
                                <nav>
                                    <a href="index.php">Home</a>
                                    <a href="bedroom.php" >Bedroom</a>
                                    <a href="kitchen.php">Kitchen</a>
                                    <a href="hall.php" class="active">Hall</a>
                                    <a href="contactus.php" >Contact Us</a>
                                </nav>
                                </div> 
                            </td>  
                        </tr>
                    </table>
                </div>
            </div>
        </header>
        
 <?php
 $sql = "SELECT * from designs WHERE design_placement = 'hall' ";
 $result = mysqli_query($con, $sql);
 $rows = mysqli_num_rows($result);
 
 if($rows){
     $i = 0;
     while($post = mysqli_fetch_assoc($result)) {
         ?>
 ?>
        <div class="bedroom_row">
            <div class="sub_row">
              
              <?php 
                 if($i%2==0){
                ?>

                 <div> 
                    <img class="i1" src="admin/img/<?=$post['dimg_path']?>" height="345px" width="345px">
                 </div>
                 <div class="grid1">
                        <p><?=$post["description"]?></p>
                </div>

                  <?php
                  }
                else{
                  ?>
                  <div class="grid1">
                        <p><?=$post["description"]?></p>
                </div>
                <div> 
                    <img class="i1" src="admin/img/<?=$post['dimg_path']?>" height="345px" width="345px">
                 </div>
                  <?php
                        }?>
              

            
             
             
            </div>
          </div>

<?php
$i++;    
}
}
?>
       
  
        <footer>
            <div class="footer">
                <div class="footer-create">
                     &nbsp &nbsp Created and designed by <br> Ekta Varsani and Mihir Vamja
                </div>
                <div class="name">
                    HOME DECOR
                </div>
                <div class="footer-nav">
                    <nav>
                        <a href="index.php">Home</a>
                        <a href="bedroom.php">Bedroom</a>
                        <a href="kitchen.php">Kitchen</a>
                        <a href="hall.php">Hall</a>
                        <a href="contactus.php">Contact Us</a>
                    </nav>
                </div>
            </div>
        </footer>
  
    </body>
</html>