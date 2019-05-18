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
            
            $(".hamburger").click(function() {
                $(".hamburger").toggleClass("change");
                $(".overlay").toggleClass("on");
                if($(".navbar .hamburger").hasClass( "change" )==true)
                    $(".sidenav").width(400);
                else
                    $(".sidenav").width(0); 
            });
            
            var table = $(".searchtable table").DataTable( {
            	"ajax": "restapi/getTable",
                "dom": 'Britp',
                "columns": [
                    {   "data": "ord" },
                    {   "data": "partofspeech", "orderable": false },
                    {   "data": "meaning", "orderable": false },
                    {   "data": "example" },
                    {	"data": "singularIndefinite" },
                    {	"data": "singularDefinite" },
                    {	"data": "pluralIndefinite" },
                    {	"data": "pluralDefinite" },
                    {	"data": "imperative" },
                    {	"data": "infinitive" },
                    {	"data": "present" },
                    {	"data": "past" },
                    {	"data": "supine" },
                    {	"data": "positive"  },
                    {	"data": "comparative" },
                    {	"data": "superlative" },
                    {	"data": "prefix" },
                    {	"data": "suffix" },
                    {	"data": "compound" },
                    {	"data": "category" },
                    {	"data": "relatedword" },
                    {	"data": "synonym" },
                    {	"data": "antonym" },
                    {	"data": "note" },
                    {	"data": "createdDate" }
                ],
                "order": [[ 0, "asc" ],[ 1, "asc" ]],
    	        "aoColumnDefs": [
    		        { "visible": false, "aTargets": [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24] }
    		    ],
                "buttons": [
                    {
                        extend: "pdfHtml5",
                        orientation: "portrait",
                        pageSize: "A4", //A3, A4, A5, LEGAL, LETTER, TABLOID
                        download: "open",
                        exportOptions: { columns: [0,1,2,3] }
                    }
                ],
                "language": { 
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    },
                    "info": "_TOTAL_ <spring:message code='records' />",
                    "infoFiltered": "",
                    "infoEmpty": "<spring:message code='norecords' />"
                },
                "drawCallback": function( settings ) {
                    if($(".dataTables_paginate span a").length<=1) {
                        $(".dataTables_paginate").hide();
                    } else {
                        $(".dataTables_paginate").show();
                    }
                }
            });
				
            function display() {
                $(".searchtable, .dataTables_info").show();
                if($(".dataTables_info").text()=="<spring:message code='norecords' /> ") 
                    $(".dt-buttons, .result").hide();
                else
                    $(".dt-buttons, .result").show();
                if($(".dataTables_info").text()=="1 <spring:message code='records' /> ") 
                	$(".dataTables_info").text("1 <spring:message code='record' />");
            }
            
            $(".alphabets li").click(function() {
            	$("input[type='search']").val("");
                table.search("").columns().search("").draw();
                $(".filter_selected").removeClass("filter_selected");
                $(this).addClass("filter_selected");
                table.columns(0).search('^'+$(this).text(), true, false).draw();
                display();
            });
            
            $("input[type='search']").on("keyup", function() {
                table.search(this.value, true, false).draw();
                display();
            }); 
            
            $(".searchbar button[value='submit']").on("click", function() {
                table.search($("input[type='search']").val(), true, false).draw();
                display();
            });
            
            $(".searchbar button[value='filter']").on("click", function() {
                $(".alphabets, .filterbar").toggleClass("show_filter");
                if($(".filterbar").hasClass("show_filter")==true)
                    $(".filterbar").show();
                else
                    $(".filterbar").hide();
            });
            
            $(".searchbar button[value='reset']").on("click", function() {
                $("input[type='search']").val("");
                table.search("").columns().search("").draw();
                $(".filter_selected").removeClass("filter_selected");
                display();
            });
            
            $(".filterbar button").on("click", function() {
                $(".filterbar .filter_selected").removeClass("filter_selected");
                $(this).addClass("filter_selected");
                table.columns(1).search($(this).val()).draw();
                display();
            });
        
            $(".result").on("click", "tr", function() {
                $(".modal-title, .view").empty();
                var word = table.row(this).data().ord;
                var partofspeech  = table.row(this).data().partofspeech;
                var meaning = table.row(this).data().meaning;
                var example = table.row(this).data().example;
                var singularIndefinite = table.row(this).data().singularIndefinite;
                var singularDefinite = table.row(this).data().singularDefinite;
                var pluralIndefinite = table.row(this).data().pluralIndefinite;
                var pluralDefinite = table.row(this).data().pluralDefinite;
                var imperative = table.row(this).data().imperative;
                var infinitive = table.row(this).data().infinitive;
                var present = table.row(this).data().present;
                var past = table.row(this).data().past;
                var supine = table.row(this).data().supine;
                var positive = table.row(this).data().positive;
                var comparative = table.row(this).data().comparative;
                var superlative = table.row(this).data().superlative;
                var prefix = table.row(this).data().prefix;
                var suffix = table.row(this).data().suffix;
                var compound = table.row(this).data().compound;
                var category = table.row(this).data().category;
                var relatedword = table.row(this).data().relatedword;
                var synonym = table.row(this).data().synonym;
                var antonym = table.row(this).data().antonym;
                var note = table.row(this).data().note;
                
                $(".modal-body .title, .modal-body .view").hide();
                $(".modal-title").append(word);
                if(partofspeech=="adv") {
                	$(".view.partofspeech").append("adverb");
                } else {
                	$(".view.partofspeech").append(partofspeech);
                }
                $(".partofspeech").show();
                if(meaning!="") {
                	$(".view.meaning").append(meaning);
                	$(".meaning").show();
                }
                if(example!="") {
                	$(".view.example").append(example);
                	$(".example").show();
                }
                if(partofspeech=="noun" && singularIndefinite!="") {
                	if(pluralIndefinite==""){
                		declension = singularIndefinite + ", " + singularDefinite;
                	} else {
                		declension = singularIndefinite + ", " + singularDefinite + ", " + pluralIndefinite + ", " + pluralDefinite;
                	}
                	$(".view.declension").append(declension);
                	$(".declension").show();
                } else if(partofspeech=="verb" && imperative!="") {
                	var declension = imperative + ", " + infinitive + ", " + present + ", " + past + ", " + supine;
                	$(".view.declension").append(declension);
                	$(".declension").show();
                } else if(partofspeech=="adjective" && positive!="") {
                	var declension = "";
                	if(comparative==""){
                		declension = positive;
                	} else {
                		declension = positive + ", " + comparative + ", " + superlative;
                	}
                	$(".view.declension").append(declension);
                	$(".declension").show();
                } 
                
                if(prefix!="") {
                	$(".view.prefix").append(prefix);
                	$(".prefix").show();
                }
                if(suffix!="") {
                	$(".view.suffix").append(suffix);
                	$(".suffix").show();
                }
                if(compound!="") {
                	$(".view.compound").append(compound);
                	$(".compound").show();
                }
                if(category!="") {
                	$(".view.category").append(category);
                	$(".category").show();
                }
                if(relatedword!="") {
                	$(".view.relatedword").append(relatedword);
                	$(".relatedword").show();
                }
                if(synonym!="") {
                	$(".view.synonym").append(synonym);
                	$(".synonym").show();
                }
                if(antonym!="") {
                	$(".view.antonym").append(antonym);
                	$(".antonym").show();
                }
                if(note!="") {
                	$(".view.note").append(note);
                	$(".note").show();
                }
                
                $(".modal_form").modal("toggle");
            });
            
            $(".modal-dialog button").on("click", function() {
                $(".modal_form").modal("toggle");
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
                    <div class="dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="filter"><spring:message code="filter" /></a>
                        <ul class="dropdown-menu">
                            <li><a class="filter-link" href="filter#categories"><spring:message code="categories" /></a></li>
                            <li><a class="filter-link"  href="filter#partsofspeech"><spring:message code="partofspeech" /></a></li>
                            <li><a class="filter-link"  href="filter#morphemes"><spring:message code="morphemes" /></a></li>
                        </ul>
                    </div>
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
                    <ul>
                        <li><h4><a class="filter-link" href="filter#categories"><spring:message code="categories" /></a></h4></li>
                        <li><h4><a class="filter-link"  href="filter#partsofspeech"><spring:message code="partsofspeech" /></a></h4></li>
                        <li><h4><a class="filter-link"  href="filter#morphemes"><spring:message code="morphemes" /></a></h4></li>
                    </ul>
                <h3><a href="search"><spring:message code="search" /></a></h3>
            </div>
        </nav>
    </div>
    <div class="main search content container-fluid" >
        <h2><spring:message code="search" /></h2>
        <div class="alphabets">
            <ul><li>A</li><li>B</li><li>C</li><li>D</li><li>E</li><li>F</li><li>G</li><li>H</li><li>I</li><li>J</li><li>K</li><li>L</li><li>M</li><li>N</li><li>O</li><li>P</li><li>Q</li><li>R</li><li>S</li><li>T</li><li>U</li><li>V</li><li>W</li><li>X</li><li>Y</li><li>Z</li><li>Å</li><li>Ä</li><li>Ö</li></ul>
        </div>
        <div class="searchbar">
            <input type="search" placeholder="<spring:message code="search" />">
            <div class="buttonbar">
                <button value="filter"><i class="fa fa-filter"></i></button><button value="reset"><i class="fa fa-undo"></i></button>
            </div>
        </div>
        <div class="filterbar">
            <button value="noun"><spring:message code="noun" /></button><button value="verb"><spring:message code="verb" /></button><button value="adj"><spring:message code="adj" /></button><button value="adv"><spring:message code="adv" /></button><button value="prepos"><spring:message code="prepos" /></button><button value="conj"><spring:message code="conj" /></button><button value="interj"><spring:message code="interj" /></button><button value="expression"><spring:message code="expression" /></button><button value="idiom"><spring:message code="idiom" /></button><button value="slang"><spring:message code="slang" /></button>
        </div>
        <div class="searchtable">
            <table class="result">
                <thead>
                    <tr>
                        <th><spring:message code="word" />&emsp;<i class="fa fa-exchange-alt"></i></th>
                        <th><spring:message code="partofspeech" /></th>
                        <th><spring:message code="meaning" /></th>
                        <th>Example</th>
                        <th>Singular indefinite</th>
                        <th>Singular definite</th>
                        <th>Plural indefinite</th>
                        <th>Plural definite</th>
                        <th>Imperative</th>
                        <th>Infinite</th>
                        <th>Present</th>
                        <th>Past</th>
                        <th>Supine</th>
                        <th>Positive</th>
                        <th>Comparative</th>
                        <th>Superlative</th>
                        <th>Prefix</th>
                        <th>Suffix</th>
                        <th>Compound</th>
                        <th>Category</th>
                        <th>Related Word</th>
                        <th>Synonym</th>
                        <th>Antonym</th>
                        <th>Note</th>
                        <th>Created_date</th>
                    </tr>
                </thead>
            </table>
        </div>
        <div class="modal_form modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"></h4><button type="button" class="btn close">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h6 class="title partofspeech"><spring:message code="partofspeech" />:</h6><h5 class="view partofspeech"></h5>
                        <h6 class="title declension"><spring:message code="decl" />:</h6><h5 class="view declension"></h5>
                        <h6 class="title meaning"><spring:message code="meaning" />:</h6><h5 class="view meaning"></h5>
                        <h6 class="title example"><spring:message code="example" />:</h6><h5 class="view example"></h5>
                        
                        <h6 class="title prefix"><spring:message code="prefix" />:</h6><h5 class="view prefix"></h5>
                        <h6 class="title suffix"><spring:message code="suffix" />:</h6><h5 class="view suffix"></h5>
                        <h6 class="title relatedword"><spring:message code="relatedword" />:</h6><h5 class="view relatedword"></h5>
                        <h6 class="title synonym"><spring:message code="synonym" />:</h6><h5 class="view synonym"></h5>
                        <h6 class="title antonym"><spring:message code="antonym" />:</h6><h5 class="view antonym"></h5>
                        <h6 class="title compound"><spring:message code="compound" />:</h6><h5 class="view compound"></h5>
                        <h6 class="title category"><spring:message code="category" />:</h6><h5 class="view category"></h5>
                        <h6 class="title note"><spring:message code="note" />:</h6><h5 class="view note"></h5>			
                    </div>
                 </div>
             </div>
        </div>
    </div>
</body>
</html>
