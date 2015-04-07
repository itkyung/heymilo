var searchTable;

$(document).ready(function(){
	
	/**
	 * 각종 버튼의 click이벤트 처리.
	 */
	$("#btnSearch").click(function(){
		doSearch();
	});
	
	var url = _requestPath + "/admin/searchProducts";
	
	searchTable = $('#searchResult').DataTable({
		  language: {
			  paginate: {
				  next: "다음",previous : "이전"
			  }
		   },
		   scrollY: 400,
		   searching: false,
		   paging:true,
		   displayLength : 10,
	       lengthChange : true,
	       info : false,
	       dom : '<"top"i>rt<"bottom"lp><"clear">',
		   ajax : {
			   url : url,
			   type : "POST"
		   },
		   columns : [
		       { data : "id", sortable : false},
		       { data : "mainThumbnailPath", width : "20%"},
		       { data : "name"},
		       { data : "newProduct", width : "10%"},
		       { data : "canSubscription", width : "10%"},
		       { data : "miloPrice", width : "15%"},
		       { data : "status", width : "15%"},
		       { data : "updated",width:"10%"}
		   ],
		   processing: true,
		   serverSide : true,
		   columnDefs : [
				{
				    targets : 1,
				    render : function(data,type,row){
				    	return "<img src=\"" + data + "\"/>";
				    }
				},
		       {
		            targets : 2,
		            render : function(data,type,row){
		            	return "<a href='javascript:viewProduct(\"" + row.id + "\");'>" + data + "</a>";
		            }
		       }
		   ]
	  }).on('preXhr.dt',function(e,settings,data){
		  //Ajax Call을 하기 전에 호출된다.
		  
	  }).on("xhr.dt",function(e,settings,json){
		 $("#totalCount").html(json.recordsTotal);  
	  });
	
});


doSearch = function(){
	searchTable.ajax.reload(function(json){
		
	});
};

addProduct = function(){
	document.location.href = _requestPath + "/admin/productForm";
};

viewProduct= function(id){
	document.location.href = _requestPath + "/admin/productForm?id=" + id;
};
