<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>::: ladies and gents :::</title>
<meta content="" name="description">
<meta content="" name="keywords">
  
  <!-- Favicons(추후 변경) -->
  <link href="bootstrap/assets/img/favicon.png" rel="icon">
  <link href="bootstrap/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
  
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="bootstrap/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="bootstrap/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="bootstrap/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="bootstrap/assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="bootstrap/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="bootstrap/assets/vendor/aos/aos.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=ctxPath%>/kimdanim/bootstrap/assets/css/style.css" rel="stylesheet">

<style type="text/css">
</style>
</head>
<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top">
    <div class="container d-flex">

      <div class="logo mr-auto">
        <h1 class="text-light"><a href="index.html"><span>Scaffold</span></a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
      </div>

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li class="active"><a href="index.html">Home</a></li>
          <li class="drop-down"><a href="">About</a>
            <ul>
              <li><a href="#about">About Us</a></li>
              <li><a href="#team">Team</a></li>
              <li><a href="#testimonials">Testimonials</a></li>
              <li class="drop-down"><a href="#">Deep Drop Down</a>
                <ul>
                  <li><a href="#">Deep Drop Down 1</a></li>
                  <li><a href="#">Deep Drop Down 2</a></li>
                  <li><a href="#">Deep Drop Down 3</a></li>
                  <li><a href="#">Deep Drop Down 4</a></li>
                  <li><a href="#">Deep Drop Down 5</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li><a href="#services">Services</a></li>
          <li><a href="#portfolio">Portfolio</a></li>
          <li><a href="#pricing">Pricing</a></li>

          <li><a href="#contact">Contact</a></li>

        </ul>
      </nav><!-- .nav-menu -->

      <div class="header-social-links">
        <a href="#" class="twitter"><i class="icofont-twitter"></i></a>
        <a href="#" class="facebook"><i class="icofont-facebook"></i></a>
        <a href="#" class="instagram"><i class="icofont-instagram"></i></a>
        <a href="#" class="linkedin"><i class="icofont-linkedin"></i></i></a>
      </div>

    </div>
  </header><!-- End Header -->



</body>
</html>