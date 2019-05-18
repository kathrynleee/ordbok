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
    
    <script>
        $(document).ready(function() {
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

            $("select[name='partofspeech']").change(function() {
                $(".declension").hide();
                $(".declension input").val("");
                $("." + $(this).val()).show();
                $("button").show();
            });
            
            $("button[name='addm']").click(function() {
                var num = parseInt($("input[name='meaning_order']:last").val())+1;
                if(num < 10) {
                    $(".meaning").append('<h8><input type="text" name="meaning_order" disabled value="'+num+'"><input type="text" name="meaning" placeholder="<spring:message code='meaning' />"></h8>');
                    $("input[name='meaning']:last").focus();
                }
            });
            
            $("button[name='removem']").click(function() {
                if(parseInt($("input[name='meaning_order']:last").val())!=1)
                    $("input[name='meaning_order']:last, input[name='meaning']:last").remove();
            });
            
            $("button[name='addex']").click(function() {
                var num = parseInt($("input[name='example_order']:last").val())+1;
                if(num < 10) {
                    $(".example").append('<h8><input type="text" name="example_order" disabled value="'+num+'"><input type="text" name="example" placeholder="<spring:message code='example' />"></h8>');
                	$("input[name='example']:last").focus();
                }
            });
            
            $("button[name='removeex']").click(function() {
                if(parseInt($("input[name='example_order']:last").val())!=1)
                    $("input[name='example_order']:last, input[name='example']:last").remove();
            });
            
            $(".alert, .declension").hide();
            
            $("button[value='save']").click(function() {
            	$(".duplicate").hide();
            	if($("input[name='word']").val()=="") {
            		$("input[name='word']").prop("placeholder", "<spring:message code='alert.noempty' />");
            		$("input[name='word']").addClass("validate");
            	} else {
            		var meaning = "", example = "";
                	if($("input[name='meaning']").length==1) {
                		meaning = $("input[name='meaning']").val();
                	} else {
    	            	$("input[name='meaning']").each(function(index){
    	            		if(index+1 == $("input[name='meaning']").length) {
    	                		meaning += index+1 + " " + $(this).val();
    	            		} else {
    	                		meaning += index+1 + " " + $(this).val() + "<br>";
    	            		}
    	                });
                	}
                	if($("input[name='example']").length==1) {
                		example = $("input[name='example']").val();
                	} else {
    	            	$("input[name='example']").each(function(index){
    	            		if(index+1 == $("input[name='example']").length) {
    	                		example += index+1 + " " + $(this).val();
    	            		} else {
    	                		example += index+1 + " " + $(this).val() + "<br>";
    	            		}
    	                });
                	}  
                	$.ajax({
    					url : "restapi/createOrd",
    					dataType: "json",
    					data : {
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
    	                    meaning: meaning,
    	                    example: example,
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
    							$.get("restapi/getOrd", function(data){
    				                var json = JSON.parse(data);
    				                $.each(json, function() {
    				                	$(".word_title").append(this.ord);
    				                	if(this.meaning!="")
    				                		$(".word_meaning").append(this.meaning);
    				                	else
    				                		$(".card_meaning").hide();
    				                	if(this.example!="")
    				                		$(".word_example").append(this.example);
    				                	else
    				                		$(".card_example").hide();
    				                });
    				            }).done(function( data ) {
    				            	$(".success, .word_review").show();
        			                $(".create_new").hide();
    				            });
    						} else if(response == "Duplicate record"){
    							$(".duplicate").show();
    							$("input[name='word']").addClass("validate");
    							$("select[name='partofspeech']").addClass("validate");
    						}
    					}
    				});
            	}
            });
            
            $(".word_review").on("close.bs.alert", function () {
                location.reload();
            });
            
            $(".card").click(function(){
                $(this).toggleClass("open");
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

    <div class="create main content container-fluid" >
        <h2><spring:message code="createnewrecord" /></h2>
        <div class="alertdiv">
	        <div class="alert duplicate alert-dismissible fade show" role="alert"><spring:message code="alert.duplicate" />
	        	<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        </div>
            <div class="success alert alert-dismissible fade show" role="alert"><spring:message code="alert.savesuccess" />
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div>
                <div class="word_review alert alert-dismissible fade show" role="alert">
                    <h5><spring:message code="wordreview" /></h5>
                    <div class="card fold">
                        <div class="dagensord card-front">
                            <div class="ord word_title"></div>
                        </div>
                        <div class="dagensord card-back">
                            <p class="ord word_title"></p>  
                            <div class="card_meaning">
	                            <div class="d-flex justify-content-start no-wrap">
	                                <div><spring:message code="meaning" />:&emsp;</div>
	                                <div class="word_meaning"></div>
	                            </div>
                            </div>
                            <div class="card_example">
	                            <div class="d-flex justify-content-start no-wrap">
	                                <div><spring:message code="example" />:&emsp;</div>
	                                <div class="word_example"></div>
	                            </div>
	                        </div>
                        </div>
                    </div>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
            </div>
        </div>

        <div class="row create_new">
            <div class="col-sm-6 col-xl-4">
                <div class="newword">
                    <h5><spring:message code="wordphrase" />:</h5>
                    <input type="text" name="word" autofocus placeholder="<spring:message code='wordphrase' />">
                </div>
                <div class="new">
                    <h5><spring:message code="partofspeech" />:&emsp;</h5> 
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
	                <h6><spring:message code="decl" />:</h6>
	                <div class="sub">
	                	<h6><spring:message code="sing" /></h6>
		                <input type="text" name="singular_indefinite" placeholder="<spring:message code='noun.indef' />">
		                <input type="text" name="singular_definite" placeholder="<spring:message code='noun.def' />">
	                </div>
	                <div class="sub">
	                	<h6><spring:message code="plur" />&emsp;&nbsp;</h6>
		                <input type="text" name="plural_indefinite" placeholder="<spring:message code='noun.indef' />">
		                <input type="text" name="plural_definite" placeholder="<spring:message code='noun.def' />">
	                </div>
                </div>
                <div class="declension verb">
                	<h6><spring:message code="decl" />:</h6>
                	<input type="text" name="imperative" placeholder="<spring:message code='verb.imp' />">
                	<input type="text" name="infinitive" placeholder="<spring:message code='verb.inf' />">
                	<input type="text" name="present" placeholder="<spring:message code='verb.pres' />">
                	<input type="text" name="past" placeholder="<spring:message code='verb.pres' />">
                	<input type="text" name="supine" placeholder="<spring:message code='verb.supine' />">
                </div>
                <div class="declension adjective">
                	<h6><spring:message code="decl" />:</h6>
                	<input type="text" name="positive" placeholder="<spring:message code='adj.pos' />">
                	<input type="text" name="comparative" placeholder="<spring:message code='adj.comp' />">
                	<input type="text" name="superlative" placeholder="<spring:message code='adj.super' />">
                </div>
                <div class="newrecord addremove">
                    <div class="meaning">
                    	<div>
	                        <h6><spring:message code="meaning" />:&emsp;<button name="addm"><i class="fa fa-plus-circle"></i></button><button name="removem"><i class="fa fa-minus-circle"></i></button></h6>
                        </div>
                        <div>
                        	<input type="text" name="meaning_order" disabled value="1"><input type="text" name="meaning" placeholder="<spring:message code='meaning' />">
                    	</div>
                    </div>
                    <div class="example">
                        <div>
                        	<h6><spring:message code="example" />:&emsp;<button name="addex"><i class="fa fa-plus-circle"></i></button><button name="removeex"><i class="fa fa-minus-circle"></i></button></h6>
                        </div>
                        <div>
                            <input type="text" name="example_order" disabled value="1"><input type="text" name="example" placeholder="<spring:message code='example' />">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-4">
                <div class="newrecord morphemes">
                    <h6><spring:message code="prefix" />:</h6><input type="text" name="prefix" placeholder="<spring:message code='prefix' />">
                    <h6><spring:message code="suffix" />:</h6><input type="text" name="suffix" placeholder="<spring:message code='suffix' />">
                </div>
                <div class="newrecord">
                    <h6><spring:message code="relatedword" />:</h6>
                    <input type="text" name="relatedword" placeholder="<spring:message code='relatedword' />">
                    <h6><spring:message code="synonym" />:</h6>
                    <input type="text" name="synonym" placeholder="<spring:message code='synonym' />">
                    <h6><spring:message code="antonym" />:</h6>
                    <input type="text" name="antonym" placeholder="<spring:message code='antonym' />">
                    <h6><spring:message code="compound" />:</h6>
                    <input type="text" name="compound" placeholder="<spring:message code='compound' />">
                    <h6><spring:message code="category" />:</h6>
                    <input type="text" name="category" placeholder="<spring:message code='category' />">
                </div>
            </div>
            <div class="col-sm-12 col-xl-4">
                <div class="newrecord">
                    <h6><spring:message code="note" />:&emsp;</h6>
                    <textarea name="note" placeholder="<spring:message code='note' />"></textarea>
                </div>
                <div class="buttondiv">
                    <button type="submit" value="save"><spring:message code="btn.save" /></button>
                </div>
            </div>
        </div> 
    </div>
</body>
</html>
