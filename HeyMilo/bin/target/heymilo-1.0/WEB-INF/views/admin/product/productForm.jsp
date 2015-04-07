<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<html>
<head>
	<title>헤이마일로</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/script/admin/product/productForm.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/script/jquery/tinymce3/jquery.tinymce.js"></script>
	
	<c:choose>
		<c:when test="${!empty productInfo}">
			
		</c:when>
		<c:otherwise>
			
		</c:otherwise>
	</c:choose>
	
	
</head>
<body>
	<div class="container">
		<h3 class="page-header">상품 관리</h3>
		<form id="productForm" class="form-horizontal" role="form" enctype="multipart/form-data" method="post">
			<input type=hidden id="productId" name="productId" value="${productInfo.id}"/>
			
			<ul id="productTab" class="nav nav-tabs">
				<li class="active"><a href="#tab-0">기본정보</a></li>
				<li><a href="#tab-1">상품설명</a></li>
			  	<li><a href="#tab-2">판매정보</a></li>
			</ul>
			<div class="tab-content">
				<div id="tab-0" class="tab-pane active hey-tab">
					<div class="form-group">
					    <label for="category" class="col-lg-2 control-label">카테고리(다중선택)</label>
					    <div class="col-lg-10">
					      	<select id="category" name="category" multiple class="form-control">
						      	<option>선택하세요.</option>
								<c:forEach var="row" items="${categories}">
									<option value="${row.id}">${row.name}</option>
								</c:forEach>
							</select>
					    </div>
					</div>
					<div class="form-group">
					    <label for="feature" class="col-lg-2 control-label">상품성분(다중선택)</label>
					    <div class="col-lg-10">
					      	<select id="feature" name="feature" multiple class="form-control">
					      		<option>선택하세요.</option>
								<c:forEach var="row" items="${features}">
									<option value="${row.id}">${row.name}</option>
								</c:forEach>
							</select>
					    </div>
					</div>
					<div class="form-group">
					    <label for="exhibition" class="col-lg-2 control-label">기획전(다중선택)</label>
					    <div class="col-lg-10">
					      	<select id="exhibition" name="exhibition" multiple class="form-control">
					      		<option>선택하세요.</option>
								<c:forEach var="row" items="${exhibitions}">
									<option value="${row.id}">${row.name}</option>
								</c:forEach>
							</select>
					    </div>
					</div>		
					<div class="form-group">
					    <label for="status" class="col-lg-2 control-label">판매상태</label>
					    <div class="col-lg-10">
					      	<select id="status" name="status" class="form-control">
					      		<option value="IN_SALE">판매중</option>
								<option value="STOP_SALE">판매중지</option>
							</select>
					    </div>
					</div>		
					<div class="form-group">
						<label for="name" class="col-lg-2 control-label">상품명</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="name" name="name" placeholder="상품명" value="${productInfo.name}">
					    </div>
					</div>
					<div class="form-group">
						<label for="productCode" class="col-lg-2 control-label">상품코드</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="productCode" name="productCode" placeholder="상품코드" value="${productInfo.productCode}">
					    </div>
					</div>		
					<div class="form-group">
						<label for="dueDate" class="col-lg-2 control-label">유효일자</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="dueDate" name="dueDate" value="${productInfo.dueDate}">
					    </div>
					</div>			
					<div class="form-group">
						<label for="mainImageUpload" class="col-lg-2 control-label">상품 이미지</label>
						<div class="col-lg-10">
							
							!-------  이미지 업로드 영역 시작 ------>
									<div id="imageUploadWrapper">
										<div id="imageUploadLeft">
											<div class="imageInputRow">
												<span>대표 이미지 </span>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="5" name="mainImageUpload" id="mainImageUpload"/> 
													<input type=hidden id="mainImagePath" name="mainImagePath" value="${productInfo.mainImagePath}"/>
													<input type=hidden id="mainThumbnailPath" name="mainThumbnailPath" value="${productInfo.thumbnailImagePath}"/>
													<input type=hidden id="mainWidth" name="mainWidth" value="${productInfo.mainImageWidth}"/>
													<input type=hidden id="mainHeight" name="mainHeight" value="${productInfo.mainImageHeight}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.mainImagePath}">
														<div id="mainShowBtn" class="imageShowBtn">
															<a href="javascript:showImage(true,0);"> 보기</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="mainShowBtn" class="hide imageShowBtn">
															<a href="javascript:showImage(true,0);"> 보기</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<span>추가 이미지 (최대 9개)</span>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload0" id="subImageUpload0"/> 
													<input type=hidden id="subImagePath0" name="subImages[0].imagePath" value="${productInfo.subImages[0].imagePath}"/>
													<input type=hidden id="subThumbnailPath0" name="subImages[0].thumbnailPath" value="${productInfo.subImages[0].thumbnailPath}"/>
													<input type=hidden id="subWidth0" name="subImages[0].width" value="${productInfo.subImages[0].width}"/>
													<input type=hidden id="subHeight0" name="subImages[0].height" value="${productInfo.subImages[0].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[0].imagePath}">
														<div id="subShowBtn0" class="imageShowBtn">
															<a href="javascript:showImage(false,0);"> 보기</a>
															<a href="javascript:delImage(0,'${productInfo.subImages[0].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn0" class="hide imageShowBtn">
															<a href="javascript:showImage(false,0);"> 보기</a>
															<a href="javascript:delImage(0)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload1" id="subImageUpload1"/> 
													<input type=hidden id="subImagePath1" name="subImages[1].imagePath" value="${productInfo.subImages[1].imagePath}"/>
													<input type=hidden id="subThumbnailPath1" name="subImages[1].thumbnailPath" value="${productInfo.subImages[1].thumbnailPath}"/>
													<input type=hidden id="subWidth1" name="subImages[1].width" value="${productInfo.subImages[1].width}"/>
													<input type=hidden id="subHeight1" name="subImages[1].height" value="${productInfo.subImages[1].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[1].imagePath}">
														<div id="subShowBtn1" class="imageShowBtn">
															<a href="javascript:showImage(false,1);"> 보기</a>
															<a href="javascript:delImage(1,'${productInfo.subImages[1].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn1" class="hide imageShowBtn">
															<a href="javascript:showImage(false,1);"> 보기</a>
															<a href="javascript:delImage(1)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
												
											</div>
											<div class="imageInputRow">
												
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload2" id="subImageUpload2"/> 
													<input type=hidden id="subImagePath2" name="subImages[2].imagePath" value="${productInfo.subImages[2].imagePath}"/>
													<input type=hidden id="subThumbnailPath2" name="subImages[2].thumbnailPath" value="${productInfo.subImages[2].thumbnailPath}"/>
													<input type=hidden id="subWidth2" name="subImages[2].width" value="${productInfo.subImages[2].width}"/>
													<input type=hidden id="subHeight2" name="subImages[2].height" value="${productInfo.subImages[2].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[2].imagePath}">
														<div id="subShowBtn2" class="imageShowBtn">
															<a href="javascript:showImage(false,2);"> 보기</a>
															<a href="javascript:delImage(2,'${productInfo.subImages[2].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn2" class="hide imageShowBtn">
															<a href="javascript:showImage(false,2);"> 보기</a>
															<a href="javascript:delImage(2)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
												
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload3" id="subImageUpload3" /> 
													<input type=hidden id="subImagePath3" name="subImages[3].imagePath" value="${productInfo.subImages[3].imagePath}"/>
													<input type=hidden id="subThumbnailPath3" name="subImages[3].thumbnailPath" value="${productInfo.subImages[3].thumbnailPath}"/>
													<input type=hidden id="subWidth3" name="subImages[3].width" value="${productInfo.subImages[3].width}"/>
													<input type=hidden id="subHeight3" name="subImages[3].height" value="${productInfo.subImages[3].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[3].imagePath}">
														<div id="subShowBtn3" class="imageShowBtn">
															<a href="javascript:showImage(false,3);"> 보기</a>
															<a href="javascript:delImage(3,'${productInfo.subImages[3].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn3" class="hide imageShowBtn">
															<a href="javascript:showImage(false,3);"> 보기</a>
															<a href="javascript:delImage(3)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload4" id="subImageUpload4" /> 
													<input type=hidden id="subImagePath4" name="subImages[4].imagePath" value="${productInfo.subImages[4].imagePath}"/>
													<input type=hidden id="subThumbnailPath4" name="subImages[4].thumbnailPath" value="${productInfo.subImages[4].thumbnailPath}"/>
													<input type=hidden id="subWidth4" name="subImages[4].width" value="${productInfo.subImages[4].width}"/>
													<input type=hidden id="subHeight4" name="subImages[4].height" value="${productInfo.subImages[4].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[4].imagePath}">
														<div id="subShowBtn4" class="imageShowBtn">
															<a href="javascript:showImage(false,4);"> 보기</a>
															<a href="javascript:delImage(4,'${productInfo.subImages[4].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn4" class="hide imageShowBtn">
															<a href="javascript:showImage(false,4);"> 보기</a>
															<a href="javascript:delImage(4)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload5" id="subImageUpload5" /> 
													<input type=hidden id="subImagePath5" name="subImages[5].imagePath" value="${productInfo.subImages[5].imagePath}"/>
													<input type=hidden id="subThumbnailPath5" name="subImages[5].thumbnailPath" value="${productInfo.subImages[5].thumbnailPath}"/>
													<input type=hidden id="subWidth5" name="subImages[5].width" value="${productInfo.subImages[5].width}"/>
													<input type=hidden id="subHeight5" name="subImages[5].height" value="${productInfo.subImages[5].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[5].imagePath}">
														<div id="subShowBtn5" class="imageShowBtn">
															<a href="javascript:showImage(false,5);"> 보기</a>
															<a href="javascript:delImage(5,'${productInfo.subImages[5].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn5" class="hide imageShowBtn">
															<a href="javascript:showImage(false,5);"> 보기</a>
															<a href="javascript:delImage(5)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload6" id="subImageUpload6" /> 
													<input type=hidden id="subImagePath6" name="subImages[6].imagePath" value="${productInfo.subImages[6].imagePath}"/>
													<input type=hidden id="subThumbnailPath6" name="subImages[6].thumbnailPath" value="${productInfo.subImages[6].thumbnailPath}"/>
													<input type=hidden id="subWidth6" name="subImages[6].width" value="${productInfo.subImages[6].width}"/>
													<input type=hidden id="subHeight6" name="subImages[6].height" value="${productInfo.subImages[6].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[6].imagePath}">
														<div id="subShowBtn6" class="imageShowBtn">
															<a href="javascript:showImage(false,6);"> 보기</a>
															<a href="javascript:delImage(6,'${productInfo.subImages[6].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn6" class="hide imageShowBtn">
															<a href="javascript:showImage(false,6);"> 보기</a>
															<a href="javascript:delImage(6)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload7" id="subImageUpload7" /> 
													<input type=hidden id="subImagePath7" name="subImages[7].imagePath" value="${productInfo.subImages[7].imagePath}"/>
													<input type=hidden id="subThumbnailPath7" name="subImages[7].thumbnailPath" value="${productInfo.subImages[7].thumbnailPath}"/>
													<input type=hidden id="subWidth7" name="subImages[7].width" value="${productInfo.subImages[7].width}"/>
													<input type=hidden id="subHeight7" name="subImages[7].height" value="${productInfo.subImages[7].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[7].imagePath}">
														<div id="subShowBtn7" class="imageShowBtn">
															<a href="javascript:showImage(false,7);"> 보기</a>
															<a href="javascript:delImage(7,'${productInfo.subImages[7].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn7" class="hide imageShowBtn">
															<a href="javascript:showImage(false,7);"> 보기</a>
															<a href="javascript:delImage(7)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="imageInputRow">
												<div class="img-file"> 
													<input type=file size="10" name="subImageUpload8" id="subImageUpload7" /> 
													<input type=hidden id="subImagePath8" name="subImages[8].imagePath" value="${productInfo.subImages[8].imagePath}"/>
													<input type=hidden id="subThumbnailPath8" name="subImages[8].thumbnailPath" value="${productInfo.subImages[8].thumbnailPath}"/>
													<input type=hidden id="subWidth8" name="subImages[8].width" value="${productInfo.subImages[8].width}"/>
													<input type=hidden id="subHeight8" name="subImages[8].height" value="${productInfo.subImages[8].height}"/>
												</div>
												<c:choose>
													<c:when test="${!empty productInfo.subImages[8].imagePath}">
														<div id="subShowBtn8" class="imageShowBtn">
															<a href="javascript:showImage(false,8);"> 보기</a>
															<a href="javascript:delImage(8,'${productInfo.subImages[8].id}')">삭제</a>
														</div>
													</c:when>
													<c:otherwise>
														<div id="subShowBtn8" class="hide imageShowBtn">
															<a href="javascript:showImage(false,8);"> 보기</a>
															<a href="javascript:delImage(8)">삭제</a>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											
											
											
										</div>
										<div id="imageUploadRight">
											<div id="imageOriginalWrapper">
												<div class="pull-right" style="height:70px;">
													<ul class="list-unstyled">
														<li>이미지 권장크기 : 450 * 450px</li>
														<li>jpg,gif,png,bmp파일만 사용가능</li>
														<li>움직이는 이미지인 경우 첫번째 이미지만 표시됨</li>
													</ul>
												</div>
												<div id="imageOriginal" style="text-align:center;">
													<c:choose>
														<c:when test="${empty productInfo.mainImagePath}">
															<img src="${pageContext.request.contextPath}/resources/images/1.5/sub/sub_img_bg.png"/>
														</c:when>
														<c:otherwise>
															<img src="${_imageServerPath}${productInfo.mainImagePath}" alt="제품 이미지" width="450" height="450" class="img-rounded"/>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</div>
									</div>
									<!--  이미지 업로드 영역 끝 -->
							
						</div>
					</div>
				</div>
				<div id="tab-1" class="tab-pane hey-tab">
					<div class="form-group">
						<label for="briefDesc" class="col-lg-2 control-label">상품간단정보</label>
					    <div class="col-lg-10">
					    	<textarea id="briefDesc" name="briefDesc" cols="130" rows="8">${productInfo.briefDesc}</textarea>
					    </div>
					</div>					
					<div class="form-group">
						<label for="htmlDesc" class="col-lg-2 control-label">상품상세정보</label>
					    <div class="col-lg-10">
					    	<textarea id="htmlDesc" name="htmlDesc">${productInfo.htmlDesc}</textarea>
					    </div>
					</div>		
				</div>
				<div id="tab-2" class="tab-pane hey-tab">
					<div class="form-group">
						<label for="productPrice" class="col-lg-2 control-label">상품가격</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="productPrice" name="productPrice" value="${productInfo.productPrice}"/>원
					    </div>
					</div>		
					<div class="form-group">
						<label for="miloPrice" class="col-lg-2 control-label">마일로가격</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="miloPrice" name="miloPrice" value="${productInfo.miloPrice}"/>원
					    </div>
					</div>	
					<div class="form-group">
						<label for="totalCount" class="col-lg-2 control-label">등록수량</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" id="totalCount" name="totalCount" value="${productInfo.totalCount}"/>개
					    </div>
					</div>
					<div class="form-group">
						<label for="miloPrice" class="col-lg-2 control-label">재고수량</label>
					    <div class="col-lg-10">
					    	<input type="text" class="form-control" value="${stockCount}" readonly="readonly"/>개
					    </div>
					</div>
				</div>
			</div>
			<div class="info-section-bottom">
				<div class="container align-center">
					<button id="btnSaveInfo" type="button" class="btn og-btn-primary" onclick="doSubmit();">상품 등록</button>
					<button type="button" class="btn btn-default">취 소</button>
				</div>
			</div>
			</form>
		
	</div>	
</body>
</html>
