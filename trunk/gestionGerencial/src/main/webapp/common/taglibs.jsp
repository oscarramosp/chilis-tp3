<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE HTML>
<html lang="en-US">

<head>
<!-- referencia a librerías de java script y .css  -->
	<meta charset="UTF-8">
	
	<link href="resources/css/reset.css" type="text/css" rel="stylesheet" media="screen"/>	
	<link href="resources/css/grid.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="resources/css/layout.css" type="text/css" rel="stylesheet" media="screen"/>
	<link href="resources/css/format.css" type="text/css" rel="stylesheet" media="screen"/>	
	<script type="text/javascript" src="resources/js/horaactual.js"></script>	
	<link rel="stylesheet" type="text/css" href="resources/css/calendario/jscal2.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/calendario/border-radius.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/calendario/steel/steel.css" />
    <script type="text/javascript" src="resources/js/calendario/jscal2.js"></script>
    <script type="text/javascript" src="resources/js/calendario/lang/es.js"></script>
    <link href="resources/css/tablas.css" type="text/css" rel="stylesheet" media="screen"/>
	
	<title></title>
	
	<script type="text/javascript" src="resources/js/jquery-1.4.2.min.js"> </script>
	<script src="resources/js/jquery.chained.js" type="text/javascript" charset="utf-8"></script>
 
 <!-- script para activar opciones ocultas al elegir el combo de objetivo funcional  -->
<script>
 $(document).ready(function(){
    $("#funcional").click(function(ev1){
        $("#formAreas").css("display", "block");
        $("#formObjetivoVinculado").css("display", "block");
        $("#formObjetivoVinculadoGeneral").css("display", "none");
    });
    $("#general").click(function(ev2){
         $("#formAreas").css("display", "none");
         $("#formObjetivoVinculado").css("display", "none");
         $("#formObjetivoVinculadoGeneral").css("display", "block");
     });
 });
 
 </script>
</head>

