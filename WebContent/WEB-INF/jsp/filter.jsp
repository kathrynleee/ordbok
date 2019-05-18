<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="sv">
<head>
    <title>SVENSK ORDBOK</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="resources/css/bootstrap.min.css"> 
    <link rel="stylesheet" href="resources/css/fontawesome.min.css">
    <link rel="stylesheet" href="resources/css/main.css">
    <script type="text/javascript" src="resources/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" charset="utf8" src="resources/js/jquery.dataTables.min.js"></script>  
    <script type="text/javascript" src="resources/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="resources/js/pdfmake.min.js"></script>
    <script type="text/javascript" src="resources/js/vfs_fonts.js"></script>
    <script type="text/javascript" src="resources/js/buttons.html5.min.js"></script>
   
    <script>
        $(document).ready(function(){
        	
            $(window).resize(function() {
                if($(".hamburger").hasClass("change")==true)
                    $(".navbar .hamburger").click();
            });
            
            $(".hamburger").click(function(){
                $(".hamburger").toggleClass("change");
                $(".overlay").toggleClass("on");
                if($(".navbar .hamburger").hasClass( "change" )==true)
                    $(".sidenav").width(400);
                else
                    $(".sidenav").width(0); 
            });

            if (window.location.hash){
                $("a[href='"+window.location.hash+"']").click();
            } 
        
            $.get("restapi/getPrefixList", function(data){
                var json = JSON.parse(data);
                $.each(json, function() {
                	$(".tab_prefix ul").append("<li class='"+this.prefix+"'>"+this.prefix+"</li>");
                });
            }).done(function( data ) {
            	$(".tab_prefix li").click(function(){
                    table.columns(4).search($(this).attr("class")).draw();
                    $(".filter_header h5").empty().append("<spring:message code='morphemes' /><i class='fa fa-angle-right'></i><spring:message code='prefix' /><i class='fa fa-angle-right'></i>" + $(this).attr("class"));
                    $(".filter_menu").hide();
                    $(".filter_header, .filtertable").show();
            	});
            });
            
            $.get("restapi/getSuffixList", function(data){
                var json = JSON.parse(data);
                $.each(json, function() {
                	$(".tab_suffix ul").append("<li class='"+this.suffix+"'>"+this.suffix+"</li>");
                });
            }).done(function( data ) {
            	$(".tab_suffix li").click(function(){
                    table.columns(5).search($(this).attr("class")).draw();
                    $(".filter_header h5").empty().append("<spring:message code='morphemes' /><i class='fa fa-angle-right'></i><spring:message code='suffix' /><i class='fa fa-angle-right'></i>" + $(this).attr("class"));
                    $(".filter_menu").hide();
                    $(".filter_header, .filtertable").show();
            	});
            });
            
            $.get("restapi/getCategoryList", function(data){
                var json = JSON.parse(data);
                $.each(json, function() {
                	$("#categories ul").append("<li class='"+this.category+"'>"+this.category+"</li>");
                });
            }).done(function( data ) {
            	$("#categories li").click(function(){
                    table.columns(2).search($(this).attr("class")).draw();
                    $(".filter_header h5").empty().append("<spring:message code='category' /><i class='fa fa-angle-right'></i>" + $(this).attr("class"));
                    $(".filter_menu").hide();
                    $(".filter_header, .filtertable").show();
            	});
            });
            
            $(".filter_header, .filtertable").hide();
            
            $(".filter_header button").click(function() {
            	$(".filter_header, .filtertable").hide();
                $(".filter_menu").show();
                table.search("").columns().search("").draw();
            });
            
            var table = $(".filtertable table").DataTable( {
                "ajax": "restapi/getTable",
                "dom": 'Britp',
                "columns": [
                    {   "data": "ord" },
                    {   "data": "meaning",
                        "orderable": false
                    },
                    {   "data": "category", //2
                        "visible": false
                    },
                    {   "data": "partofspeech", //3
                        "visible": false
                    },
                    {   "data": "prefix", //4
                        "visible": false
                    },
                    {   "data": "suffix",  //5
                        "visible": false
                    }
                ],
                "buttons": [
                    {
                        extend: "pdfHtml5",
                        orientation: "portrait",
                        pageSize: "A4", 
                        download: "open",
                        exportOptions: { columns: [0,1] }
                    }
                ],
                "language": { 
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    },
                    "info": "_TOTAL_ <spring:message code='records' />",
                    "infoFiltered": "",
                    "infoEmpty": "<spring:message code='norecords' />",
                },
                "pageLength": 50,
                "drawCallback": function( settings ) {
                    if($(".dataTables_paginate span a").length<=1) {
                        $(".dataTables_paginate").hide();
                    } else {
                        $(".dataTables_paginate").show();
                    }
                    if($(".dataTables_info").text()=="1 <spring:message code='records' /> ") 
                    	$(".dataTables_info").text("1 <spring:message code='record' />");
                }
            });
            
            $("#partsofspeech li").click(function(){
                table.columns(3).search($(this).attr("class")).draw();
                $(".filter_header h5").empty().append("<spring:message code='partofspeech' /><i class='fa fa-angle-right'></i>" + $(this).text());
                $(".filter_menu").hide();
                $(".filter_header, .filtertable").show();
                if($("td").hasClass("dataTables_empty")) {
                	$(".dt-buttons, .result").hide();
                } else {
                	$(".filtertable, .dt-buttons, .result").show();
                }
            });
            
            $("#morphemes li").click(function(){
                $("button[value='back']").show();
                $(".filter .tab_mor").hide();
                if($(this).attr("class")=="prefix") {
                    $(".filter .tab_prefix").show();
                } else {
                    $(".filter .tab_suffix").show();
                }
            });
            
            $("button[value='back']").click(function(){
                $(".filter .tab_mor").show();
                $(".filter .tab_prefix, .filter .tab_suffix").hide();
                $("button[value='back']").hide();
            });
            
        });
    </script>
</head>
<body>
    <div class="overlay"></div>
    <div>
        <nav class="navbar navbar-custom">
            <div class="navbar-header mr-auto">
                <h1><a href="index">Svensk Ordbok</a></h1>
            </div>
            <div class="hamburger">
            	<div class="bar1"></div>
            	<div class="bar2"></div>
            	<div class="bar3"></div>
            </div>
            <ul class="nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="create"><spring:message code="create" /></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="edit"><spring:message code="edit" /></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="filter"><spring:message code="filter" /></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="search"><spring:message code="search" /></a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="sidenav">
        <nav>
            <div class="hamburger">
                <div class="bar1"></div>
                <div class="bar2"></div>
                <div class="bar3"></div>
            </div>
            <div class="navlist">
                <h3><a href="create"><spring:message code="create" /></a></h3>
                <h3><a href="edit"><spring:message code="edit" /></a></h3>
                <h3><a href="filter"><spring:message code="filter" /></a></h3>
                <h3><a href="search"><spring:message code="search" /></a></h3>
            </div>
        </nav>
    </div>
    <div class="main filter content container-fluid" >
        <h2><spring:message code="filterrecords" /></h2>
        <div class="filter_menu">
            <nav>
                <ul class="nav nav-pills nav-justified align-middle">
                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#categories"><spring:message code="categories" /></a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#partsofspeech"><spring:message code="partofspeech" /></a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#morphemes"><spring:message code="morphemes" /></a></li>
                </ul>
            </nav>
            <div class="tab-content content-wrap">
                <div id="categories" class="tab-pane active">
                    <ul class="filter_list"></ul>
                </div>
                <div id="partsofspeech" class="tab-pane">
                        <ul class="filter_list">
                            <li class="noun"><spring:message code="noun" /></li>
                            <li class="verb"><spring:message code="verb" /></li>
                            <li class="adjective"><spring:message code="adj" /></li>
                            <li class="adv"><spring:message code="adv" /></li>
                            <li class="preposition"><spring:message code="prepos" /></li>
                            <li class="conjunction"><spring:message code="conj" /></li>
                            <li class="interjection"><spring:message code="interj" /></li>
                            <li class="expression"><spring:message code="expression" /></li>
                            <li class="idiom"><spring:message code="idiom" /></li>
                            <li class="slang"><spring:message code="slang" /></li>
                        </ul>
                </div>
                <div id="morphemes" class="tab-pane">
                    <button value="back"><i class="fa fa-arrow-left"></i></button>
                    <div class="tab_mor">
                        <ul>
                            <li class="prefix"><spring:message code="prefix" /></li>
                            <li class="suffix"><spring:message code="suffix" /></li>
                        </ul>
                    </div>
                    <div class="tab_prefix">
                        <h5><spring:message code="prefix" /></h5>
                        <ul class="filter_list"></ul>
                    </div>
                    <div class="tab_suffix">
                        <h5><spring:message code="suffix" /></h5>
                        <ul class="filter_list"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="filter_header">
        	<button value="reset"><i class="fa fa-undo"></i></button><h5></h5>
        </div>
        <div class="filtertable">
            <table class="result">
                <thead>
                    <tr>
                        <th><spring:message code="word" /></th>
                        <th><spring:message code="meaning" /></th>
                        <th>Category</th>
                        <th>Part of Speech</th>
                        <th>Prefix</th>
                        <th>Suffix</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</body>
</html>
