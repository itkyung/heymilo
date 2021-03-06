<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>헤이마일로</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/script/admin/listExhibitions.js"></script>
</head>
<body>
	<div class="container">
		<h3 class="page-header">상품 기획전 관리</h3>
		
		<form id="resultTable">
			<div class="search-result-title">
				<div class="pull-left">
					검색결과 : 총 <code id="totalCount"> 0</code> 개.
				</div>
				<div class="pull-right">
					<button  type="button" class="btn og-btn-warning" onclick="addExhibition();">기획전 추가</button>
				</div>
			</div>
			<table id="searchResult" class="display table-bordered" cellspacing="0" width="100%">
				<thead>
		            <tr>
		                <th></th>
		                <th>기획전명</th>
		                <th>설명</th>
		                <th>종류</th>
		                <th>생성일</th>
		            </tr>
		        </thead>
		        
			</table>
			
		</form>
	</div>
	
	<c:url value="/admin/saveExhibition" var="saveUrl"/>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="h4#editModal" aria-hidden="true">
		<div class="modal-dialog">
		    <div class="modal-content">
		    	<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		        	<h4 class="modal-title">기획전 상세</h4>
		      	</div>
		      	<form id="registForm" class="form-horizontal" role="form" action="${saveUrl}" method="POST">
		      		<input type="hidden" id="exhibitionId" name="id"/>
		     		<div class="modal-body">
					
					  <div class="form-group">
					    <label for="exhibitionName" class="col-lg-2 control-label">기획전명</label>
					    <div class="col-lg-10">
					      <input type="text" class="form-control" id="exhibitionName" name="name" placeholder="이름">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="exhibitionDesc" class="col-lg-2 control-label">설명</label>
					    <div class="col-lg-10">
					      <input type="text" class="form-control" id="exhibitionDesc" name="desc" placeholder="설명">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="desc" class="col-lg-2 control-label">기획전 종류</label>
					    <div class="col-lg-10">
					    	<select id="exhibitionType" name="type" class="form-control input-sm">
					    		<option value="NEW_PRODUCT">신상품기획전</option>
					    		<option value="SUBSCRIPTION">정기구독상품전</option>
					    		<option value="ETC">기타기획전</option>
					    	</select>  
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="desc" class="col-lg-2 control-label">사용여부</label>
					    <div class="col-lg-10">
					      <input type="checkbox" class="form-control" id="exhibitionActive" name="active">
					    </div>
					  </div>
					</div>
					<div class="modal-footer">
				      	<button type="button" id="btnRegist" class="btn btn-primary" onclick="saveAction();">저장하기</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</form>
				 </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->		
</body>
</html>
