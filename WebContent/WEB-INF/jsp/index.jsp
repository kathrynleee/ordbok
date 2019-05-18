<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="sv">
<head>
    <title>SVENSK ORDBOK</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="resources/css/main.css">
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">
    <script type="text/javascript" src="resources/js/jquery-3.3.1.js"></script>

    <script>
        $(document).ready(function(){
            $(".menu").toggleClass("show");
        });
    </script>
</head>
<body>
    <div class="bg">
        <div class="menu">
            <div class="main_title">
                <div>Svensk</div>
                <div>Ordbok</div>
            </div>
            <nav class="main_navbar">
                <ul>
                    <li><a href="create"><spring:message code="create" /></a></li>
                    <li><a href="edit"><spring:message code="edit" /></a></li>
                    <li><a href="filter"><spring:message code="filter" /></a></li>
                    <li><a href="search"><spring:message code="search" /></a></li>
                </ul>
            </nav>
            <div class="language">
            	<a href="?lang=en"><spring:message code="lang.english" /></a>
				<a href="?lang=sv"><spring:message code="lang.swedish" /></a>
			</div>
        </div>
    </div>
    <div class="credit"><spring:message code="photocredit" />: Per Pixel Petersson/imagebank.sweden.se</div>
</body>
</html>