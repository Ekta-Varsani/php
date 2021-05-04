<?php
$conn=mysqli_connect("localhost","root","","jingle_final");
?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link rel="stylesheet" href="css/bootstrap.css">
  <link rel="stylesheet" href="css/style.css">
  <title>JINGLE</title>
</head>
</head>
<body>

	<table class="table table-striped" >
	<thead class="thead-inverse">
                  <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Artists</th>
                    <th>Category</th>
                    <th>Date Posted</th>                    
                  </tr>
                </thead>
		<?php
		$perpage = 3;
		if(isset($_GET["page"])){
			$page = intval($_GET["page"]);
		}
		else {
			$page = 1;
		}
		$calc = $perpage * $page;
		$start = $calc - $perpage;
		$sql = "SELECT m.id id,@a:=@a+1 sr_no,m.name title,c.`name` category,DATE_FORMAT(m.`date_added`,'%e/%c/%Y') date_added, m.artist artist FROM music m ,categories c ,(SELECT @a:= $start ) a WHERE m.`category_id` = c.`id` ORDER BY m.`date_added` DESC LIMIT $start, $perpage";
		$result = mysqli_query($conn, $sql);
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
                    <td><a href="details.php" class="fa fa-edit" ></a></td>
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
			if(isset($page)){
				$result = mysqli_query($conn,"select Count(*) As Total from music");
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
					echo "<li class='page-item'><a class='page-link' id='page_a_link' href='pagination.php?page=$j'> Prev</a></li>";
				}
				for($i=1; $i <= $totalPages; $i++){
					if($i<>$page){
						echo "<li class='page-item'><a class='page-link' id='page_a_link' href='pagination.php?page=$i'>$i</a></li>";
					}else{
						echo "<li id='page_links' class='page-item active'><a href='#' class='page-link'>$i</a></li>";
					}
				}
				if($page == $totalPages ){
					echo "<li id='page_links' class='page-item disabled'><a href='#' class='page-link'>Next </a></li>";
				}else{
					$j = $page + 1;
					echo "<li class='page-item'><a class='page-link' id='page_a_link' href='pagination.php?page=$j'>Next</a></li>";
				}
			}
			?>
		</td>
		</ul>
	</nav>

	</body>
</html>