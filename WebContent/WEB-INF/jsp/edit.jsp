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

            var table = $(".edittable table").DataTable( {
            	"ajax": "restapi/getTable",
                "dom": 'Britp',
                "columns": [
                	{	"data": "createdDate" },
                    {   "data": "ord" },
                    {   "data": "partofspeech" },
                    {   "data": "meaning",
                        "orderable": false
                    },
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
                    {	"data": "note" }
                ],
                "order": [[ 0, "desc" ],[ 1, "asc" ],[ 2, "asc" ]],
    	        "aoColumnDefs": [
    		        { "visible": false, "aTargets": [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24] }
    		    ],
                "language": { 
                    "paginate": {
                        "previous": "<",
                        "next": ">"
                    },
                    "info": "",
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
                $(".edittable, .dataTables_info").show();
                if($(".dataTables_info").text()=="<spring:message code='norecords' /> ") 
                    $(".dt-buttons, .result").hide();
                else
                    $(".dt-buttons, .result").show();
            }

            $("input[type='search']").on("keyup", function() {
                table.search(this.value, true, false).draw();
                display();
            }); 
            
            var row_id;
            var originalWord ="", originalPartofspeech ="";
            $(".result").on("click", "tr", function() {
            	if($("input, select").hasClass("validate")==true)
            		$("input, select").removeClass("validate");
				
            	row_id = table.row(this).index();
         		originalWord = table.row(this).data().ord;
         		originalPartofspeech = table.row(this).data().partofspeech;
         		var partofspeech = table.row(this).data().partofspeech;
                $("input[name='word']").val(table.row(this).data().ord);
                $("select[name='partofspeech']").val(partofspeech);
                $("input[name='singular_indefinite']").val(table.row(this).data().singularIndefinite);
                $("input[name='singular_definite']").val(table.row(this).data().singularDefinite);
                $("input[name='plural_indefinite']").val(table.row(this).data().pluralIndefinite);
                $("input[name='plural_definite']").val(table.row(this).data().pluralDefinite);
                $("input[name='imperative']").val(table.row(this).data().imperative);
                $("input[name='infinitive']").val(table.row(this).data().infinitive);
                $("input[name='present']").val(table.row(this).data().present);
                $("input[name='past']").val(table.row(this).data().past);
                $("input[name='supine']").val(table.row(this).data().supine);
                $("input[name='positive']").val(table.row(this).data().positive);
                $("input[name='comparative']").val(table.row(this).data().comparative);
                $("input[name='superlative']").val(table.row(this).data().superlative);
                $("input[name='meaning']").val(table.row(this).data().meaning);
                $("input[name='example']").val(table.row(this).data().example);
                $("input[name='prefix']").val(table.row(this).data().prefix);
                $("input[name='suffix']").val(table.row(this).data().suffix);
                $("input[name='relatedword']").val(table.row(this).data().relatedword);
                $("input[name='synonym']").val(table.row(this).data().synonym);
                $("input[name='antonym']").val(table.row(this).data().antonym);
                $("input[name='compound']").val(table.row(this).data().compound);
                $("input[name='category']").val(table.row(this).data().category);
                $("textarea[name='note']").val(table.row(this).data().note);
                
                $(".declension").hide();
                switch(partofspeech) {
	                case "noun":
	                	$(".declension.noun").show();
	                	break;
	                case "verb":
	                	$(".declension.verb").show();
	                  	break;
	                case "adjective":
	                	$(".declension.adjective").show();
	                	break;
              }
                $(".modal_form").modal("toggle");
            });
            
            $(".modal-dialog .close").on("click", function() {
                $(".modal_form").modal("toggle");
            });
            
            $("select[name='partofspeech']").change(function() {
                $(".declension").hide();
                $(".declension input").val("");
                $("." + $(this).val()).show();
                $("button").show();
            });

            $("button[value='save']").click(function() {
            	if($("input[name='word']").val()=="") {
            		$("input[name='word']").prop("placeholder", "<spring:message code='alert.noempty' />");
            		$("input[name='word']").addClass("validate");
            	} else {
            		$.ajax({
    					url : "restapi/updateOrd",
    					dataType: "json",
    					data : {
    						originalWord: originalWord,
    						originalPartofspeech: originalPartofspeech,
    						ord: $("input[name='word']").val(),
    	                    partofspeech: $("select[name='partofspeech']").val(),
    	                    singularIndefinite: $("input[name='singular_indefinite']").val(),
    	                    singularDefinite: $("input[name='singular_definite']").val(),
    	                    pluralIndefinite: $("input[name='plural_indefinite']").val(),
    	                    pluralDefinite: $("input[name='plural_definite']").val(),
    	                    imperative: $("input[name='imperative']").val(),
    	                    infinitive: $("input[name='infinitive']").val(),
    	                    present: $("input[name='present']").val(),
    	                    past: $("input[name='past']").val(),
    	                    supine: $("input[name='supine']").val(),
    	                    positive: $("input[name='positive']").val(),
    	                    comparative: $("input[name='comparative']").val(),
    	                    superlative: $("input[name='superlative']").val(),
    	                    meaning: $("input[name='meaning']").val(),
    	                    example: $("input[name='example']").val(),
    	                    prefix: $("input[name='prefix']").val(),
    	                    suffix: $("input[name='suffix']").val(),
    	                    relatedword: $("input[name='relatedword']").val(),
    	                    synonym: $("input[name='synonym']").val(),
    	                    antonym: $("input[name='antonym']").val(),
    	                    category: $("input[name='category']").val(),
    	                    compound: $("input[name='compound']").val(),
    	                    note: $("textarea[name='note']").val()
    		    	    },
    					type : "POST",
    					success: function(response){
    						if(response == "Success"){
    							var year = new Date().getFullYear().toString().substring(2);
    							var month = ((new Date().getMonth()+1)>=10)? (new Date().getMonth()+1) : '0'+(new Date().getMonth()+1);
    							var day = (new Date().getDate()>=10)? new Date().getDate() : '0'+new Date().getDate();
    							var date = year + "/" + month + "/" + day;
    							$(".modal_form").modal("toggle");
    							table.row(row_id).remove().draw();
    							table.row.add({
    						        "createdDate": date,
    								"ord":$("input[name='word']").val(),
        	                    	"partofspeech":$("select[name='partofspeech']").val(),
        	                    	"singularIndefinite": $("input[name='singular_indefinite']").val(),
        	                  		"singularDefinite": $("input[name='singular_definite']").val(),
        	                    	"pluralIndefinite":$("input[name='plural_indefinite']").val(),
        	                   		"pluralDefinite": $("input[name='plural_definite']").val(),
        	                    	"imperative":$("input[name='imperative']").val(),
        	                   		"infinitive":$("input[name='infinitive']").val(),
        	                   		"present": $("input[name='present']").val(),
        	                   		"past": $("input[name='past']").val(),
        	                   		"supine": $("input[name='supine']").val(),
        	                   		"positive": $("input[name='positive']").val(),
        	                  		"comparative":  $("input[name='comparative']").val(),
        	                   		"superlative": $("input[name='superlative']").val(),
        	                    	"meaning":$("input[name='meaning']").val(),
        	                   		"example": $("input[name='example']").val(),
        	                    	"prefix":$("input[name='prefix']").val(),
        	                    	"suffix":$("input[name='suffix']").val(),
        	                   		"relatedword": $("input[name='relatedword']").val(),
        	                   		"synonym": $("input[name='synonym']").val(),
        	                    	"antonym":$("input[name='antonym']").val(),
        	                    	"category":$("input[name='category']").val(),
        	                    	"compound":$("input[name='compound']").val(),
        	                    	"note":$("textarea[name='note']").val()
    							}).draw().node();
    							
    						} else if(response == "Duplicate record") {
    							$("input[name='word']").addClass("validate");
    							$("select[name='partofspeech']").addClass("validate");
        					}
    					}
            		});
            	}
            });
            
            $("button[value='delete']").click(function() {
            	if(confirm("<spring:message code='alert.areyousuretodelete' />")) {
            		$.ajax({
    					url : "restapi/deleteOrd",
    					dataType: "json",
    					data : {
    						ord: originalWord,
    	                    partofspeech: originalPartofspeech
    		    	    },
    					type : "POST",
    					success: function(response){
    						if(response == "Success"){
    							$(".modal_form").modal("toggle");
    							table.row(row_id).remove().draw();
    						} 
    					}
    				});
            	}
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

    <div class="main edit content container-fluid" >
        <h2><spring:message code="editrecords" /></h2>
        <div class="searchbar">
            <input type="search" placeholder="<spring:message code='search' />">
        </div>
        <div class="edittable">
            <table class="result">
                <thead>
                    <tr>
                    	<th><spring:message code="updateddate" /></th>
                        <th><spring:message code="word" /></th>
                        <th><spring:message code="partofspeech" /></th>
                        <th>Meaning</th>
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
                        <th>Related word</th>
                        <th>Synonym</th>
                        <th>Antonym</th>
                        <th>Note</th>
                    </tr>
                </thead>
            </table>
        </div>
        
        <div class="modal_form modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <input type="text" name="word"><button type="button" class="btn close">&times;</button>
                   	</div>
                    <div class="modal-body">
                    	<div class="container container-fluid">
							<div class="row">
								<div class="col-lg-6">
					            	<div class="form-group">
									    <label for="partofspeech"><spring:message code="partofspeech" />:</label>
									    <select name="partofspeech">
					                        <option value="" selected disabled hidden><spring:message code="select" /></option>
					                        <option value="noun"><spring:message code="noun" /></option>
					                        <option value="verb"><spring:message code="verb" /></option>
					                        <option value="adjective"><spring:message code="adj" /></option>
					                        <option value="adv"><spring:message code="adv" /></option>
					                        <option value="preposition"><spring:message code="prepos" /></option>
					                        <option value="conjunction"><spring:message code="conj" /></option>
					                        <option value="interjection"><spring:message code="interj" /></option>
					                        <option value="expression"><spring:message code="expression" /></option>
					                        <option value="idiom"><spring:message code="idiom" /></option>
					                        <option value="slang"><spring:message code="slang" /></option>
					                 	</select>
									</div>
					            		
					                <div class="declension noun">
						                <label><spring:message code="decl" />:</label>
						                <div class="form-group">
						                	<label><spring:message code="sing" /></label>
							                <input type="text" name="singular_indefinite" placeholder="<spring:message code='noun.indef' />">
							                <input type="text" name="singular_definite" placeholder="<spring:message code='noun.def' />">
						                </div>
						                <div class="form-group">
						                	<label><spring:message code="plur" />&emsp;&nbsp;</label>
							                <input type="text" name="plural_indefinite" placeholder="<spring:message code='noun.indef' />">
							                <input type="text" name="plural_definite" placeholder="<spring:message code='noun.def' />">
						                </div>
					                </div>
					                <div class="declension verb">
					                	<label for="declension"><spring:message code="decl" />:</label>
					                	<input type="text" name="imperative" placeholder="<spring:message code='verb.imp' />">
					                	<input type="text" name="infinitive" placeholder="<spring:message code='verb.inf' />">
					                	<input type="text" name="present" placeholder="<spring:message code='verb.pres' />">
					                	<input type="text" name="past" placeholder="<spring:message code='verb.past' />">
					                	<input type="text" name="supine" placeholder="<spring:message code='verb.supine' />">
					                </div>
					                <div class="declension adjective">
					                	<label><spring:message code="decl" />:</label>
					                	<input type="text" name="positive" placeholder="<spring:message code='adj.pos' />">
					                	<input type="text" name="comparative" placeholder="<spring:message code='adj.comp' />">
					                	<input type="text" name="superlative" placeholder="<spring:message code='adj.super' />">
					                </div>
					                <div class="form-group">
					                    <label for="meaning"><spring:message code="meaning" />:</label><input type="text" name="meaning" placeholder="<spring:message code='meaning' />">
					                </div>
					                <div class="form-group">
					                	<label for="example"><spring:message code="example" />:</label><input type="text" name="example" placeholder="<spring:message code='example' />">
					                </div>
					                <div class="form-group">
					                	<label for="prefix"><spring:message code="prefix" />:</label><input type="text" name="prefix" placeholder="<spring:message code='prefix' />">
					                	<label for="suffix"><spring:message code="suffix" />:</label><input type="text" name="suffix" placeholder="<spring:message code='suffix' />">
					                </div>
					            </div>
					            <div class="col-lg-6">
					                <div class="form-group">
					                    <label for="relatedword"><spring:message code="relatedword" />:</label>
					                    <input type="text" name="relatedword" placeholder="<spring:message code='relatedword' />">
					                </div>
					                <div class="form-group">
					                    <label for="synonym"><spring:message code="synonym" />:</label>
					                    <input type="text" name="synonym" placeholder="<spring:message code='synonym' />">
					                </div>
					                <div class="form-group">
					                    <label for="antonym"><spring:message code="antonym" />:</label>
					                    <input type="text" name="antonym" placeholder="<spring:message code='antonym' />">
					                </div>
					                <div class="form-group">    
					                    <label for="compound"><spring:message code="compound" />:</label>
					                    <input type="text" name="compound" placeholder="<spring:message code='compound' />">
					                </div>
					                <div class="form-group">
					                    <label for="category"><spring:message code="category" />:</label>
					                    <input type="text" name="category" placeholder="<spring:message code='category' />">
					                </div>
					            </div>
					            <div class="col-lg-12">
					                <div class="form-group">
					                    <label for="note"><spring:message code="note" />:</label>
					                    <textarea name="note" placeholder="<spring:message code='note' />"></textarea>
					                </div>
					                <div class="buttondiv">
						                <button type="button" value="save"><spring:message code="btn.save" /></button>
						                <button type="button" value="delete"><spring:message code="btn.delete" /></button> 
					                </div>
					            </div>
					    	</div> 
                    	</div>
                 	</div>
             	</div>
        	</div>
		</div>
	</div>
</body>
</html>
