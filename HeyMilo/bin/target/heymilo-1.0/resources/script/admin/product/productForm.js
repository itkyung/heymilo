var manufactureMap = {};


$(document).ready(function(){
	$('#productTab a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
	});
	
	$("#dueDate").datepicker({
		showOn : 'button',
		dateFormat : 'yy-MM-dd',
		buttonImage:  _requestPath + "/resources/images/calendar.png",
		buttonImageOnly: true,
		changeYear : true,
		changeMonth : true,
		minDate : '+0D',
		dayNamesMin : ['일','월','화','수','목','금','토'],
		monthNames : ['01','02','03','04','05','06','07','08','09','10','11','12'],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		onSelect : function(dateText){
			var dateObj = $(this);
			
		}		
	});
	
	$("#mainImageUpload").on('change',function(){
		uploadImage(true,0,$(this));
	});
	
	$("#subImageUpload0").on('change',function(){
		uploadImage(false,0,$(this));
	});
	
	$("#subImageUpload1").on('change',function(){
		uploadImage(false,1,$(this));
	});
	
	$("#subImageUpload2").on('change',function(){
		uploadImage(false,2,$(this));
	});
	
	$("#subImageUpload3").on('change',function(){
		uploadImage(false,3,$(this));
	});
	
	$("#htmlDesc").tinymce({
		script_url : _requestPath + '/resources/script/jquery/tinymce3/tiny_mce.js',
		theme : "advanced",
		language : 'ko',
		height : '900',
		width : '900',
		theme_advanced_path: false,  
		
		forced_root_block: false,  
		theme_advanced_toolbar_location : "top",
		plugins: "style,layer,table,save,advhr,advimage," +
				"advlink,media,searchreplace,contextmenu," +
				"paste,nonbreaking,xhtmlxtras,autosave"
		
	});
	
});


uploadImage = function(isMain,idx,$obj){
	var url = null;
	var imagePathId = null;
	var thumbnailPathId = null;
	var widthId = null;
	var heightId = null;
	var showBtnId = null;
	if(isMain){
		url = "/myGarden/uploadMainImage";
		imagePathId = "#mainImagePath";
		thumbnailPathId = "#mainThumbnailPath";
		widthId = "#mainWidth";
		heightId = "#mainHeight";
		showBtnId = "#mainShowBtn";
	}else{
		url = "/myGarden/uploadSubImage" + idx;
		imagePathId = "#subImagePath" + idx;
		thumbnailPathId = "#subThumbnailPath" + idx;
		widthId = "#subWidth" + idx;
		heightId = "#subHeight" + idx;
		showBtnId = "#subShowBtn" + idx;
	}
	
	var selectedVal = $obj.val();
	if(selectedVal == null || selectedVal.length == 0){
		$("#imageOriginal").html('');
		$("#imageThumbnail").html('');
		
		$(imagePathId).attr("value","");
		$(thumbnailPathId).attr("value","");
		$(widthId).attr("value",0);
		$(heightId).attr("value",0);
		
		$(showBtnId).hide();
		
		return;
	}
	$("#imageOriginal").html("<img src='" + _requestPath + "/resources/images/loading.gif'/>");
	$("#imageThumbnail").html("<img src='" + _requestPath + "/resources/images/loading.gif'/>");
	$("#productForm").ajaxSubmit({
		url : _requestPath + url,
		dataType : 'json',
		success : function(response,statusText){
			var success = response.success;
			if(success == true){
				var imagePath = response.imagePath;
				var thumbnailPath = response.thumbnailPath;
				var width = response.width;
				var height = response.height;
				
				$(imagePathId).attr("value",imagePath);
				$(thumbnailPathId).attr("value",thumbnailPath);
				$(widthId).attr("value",width);
				$(heightId).attr("value",height);
				
				$("#imageOriginal").html("<img src='" + _imageServerPath + imagePath + "'/>");
				$("#imageThumbnail").html("<img src='" + _imageServerPath + thumbnailPath + "' width=200/>");
				
				$(showBtnId).show();
			}else{
				$("#imageOriginal").html('');
				$("#imageThumbnail").html('');
				
				var msg = response.msg;
				alert(msg);
			}
		},
		error : function(){
			$("#imageOriginal").html('');
			$("#imageThumbnail").html('');
			
			$(imagePathId).attr("value","");
			$(thumbnailPathId).attr("value","");
			$(widthId).attr("value",0);
			$(heightId).attr("value",0);
			
			$(showBtnId).hide();
			alert("Error");
		}
	});	
};


showImage = function(isMain,idx){
	var imagePath = null;
	var thumbnailPath = null;
	
	if(isMain){
		imagePath = $("#mainImagePath").val();
		thumbnailPath = $("#mainThumbnailPath").val();
	}else{
		imagePath = $("#subImagePath" + idx).val();
		thumbnailPath = $("#subThumbnailPath" + idx).val();
	}

	$("#imageOriginal").html("<img src='" + _imageServerPath + imagePath + "'/>");
	$("#imageThumbnail").html("<img src='" + _imageServerPath + thumbnailPath + "' width=200/>");
	
};

doSubmit = function(){
	var firstCategoryId = $("#firstCategoryId").val();
	
	if(firstCategoryId.length == 0){
		alert("첫번째 카테고리를 선택하세요.");
		return;
	}
	
	var secondCategoryId = $("#secondCategoryId").val();
	if(secondCategoryId.length == 0){
		alert("두번째 카테고리를 선택하세요.");
		return;
	}
	
	var thirdCategoryId = $("#thirdCategoryId").val();
	if(thirdCategoryId.length == 0){
		alert("세번째 카테고리를 선택하세요.");
		return;
	}
	
	var name = $("#name").val();
	if(name.length == 0){
		alert("상품명을 입력하세요.");
		return;
	}
	
	var productCode = $("#productCode").val();
	if(productCode.length == 0){
		alert("상품코드를 입력하세요.");
		return;
	}
	
	if($("input:radio[name=domesticFlag]:input[value=1]").is(":checked")){
		var localSecond = $("#localSecond").val();
		if(localSecond.length == 0){
			alert("원산지 상세지역을 선택하세요.");
			return;
		}	
	}else{
		var countrySecond = $("#countrySecond").val();
		if(countrySecond.length == 0){
			alert("원산지 상세지역을 선택하세요.");
			return;
		}
	}

	var mainImagePath = $("#mainImagePath").val();
	if(mainImagePath.length == 0){
		alert("대표 이미지를 업로드하세요.");
		return;
	}
	
	var htmlDescription = $("#htmlDescription").val();
	if(htmlDescription.length == 0){
		alert("상품상세정보를 입력하세요.");
		return;
	}
	
	var sellStartDate = $("#sellStartDate").val();
	if(sellStartDate.length == 0){
		alert("판매기간을 입력하세요.")
		return;
	}
	
	var sellEndDate = $("#sellEndDate").val();
	if(sellEndDate.length == 0){
		alert("판매기간을 입력하세요.")
		return;
	}
	
	$("input:text").each(function(){
		var tId = $(this).attr("id");
		var val = $(this).val();
		if(tId.endsWith("_sellPrice")){
			if(val.length == 0){
				alert("상품의 판매가를 전부다 입력하세요.");
				return;
			}
		}else if(tId.endsWith("_stockCount")){
			if(val.length == 0){
				alert("상품의 재고수량을 전부다 입력하세요.");
				return;
			}
		}else if(tId.endsWith("_value")){
			if(val.length == 0){
				alert("상품의 옵션값을 전부다 입력하세요.");
				return;
			}
		}
	});
	
	
//	var sellPrice = $("#sellPrice").val();
//	if(sellPrice.length == 0){
//		alert("판매가를 입력하세요.");
//		return;
//	}
//	
//	var stockCount = $("#stockCount").val();
//	if(stockCount.length == 0){
//		alert("재고수량을 입력하세요.");
//		return;
//	}
	
	$("#productForm").attr({action : _requestPath + "/myGarden/sharing/saveProduct"}).submit();
	
};

