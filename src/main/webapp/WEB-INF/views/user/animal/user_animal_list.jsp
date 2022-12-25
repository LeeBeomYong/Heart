<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="resources/css/user_animal_main.css">
<jsp:include page="../../include/user_header.jsp" />
<c:set var="qList" value="${ qnaList }" />
<c:set var="total" value="${ total }" />
<c:set var="paging" value="${ paging }" />
<c:set var="animalList" value="${animalList }" />
<c:set var="animalDTO" value="${ animalDTO }" />
<c:set var="keyword" value="${keyword }" />
<c:set var="sort" value="${sort }" />
<c:if test="${animalDTO.animal_tag eq 'dog'}" >
    <c:set var="animal" value="강아지" />
</c:if>
<c:if test="${animalDTO.animal_tag eq 'cat'}" >
    <c:set var="animal" value="고양이" />
</c:if>
<c:set var="pagingTag"
	value="animal_size=${animalDTO.animal_size }&animal_species=${ animalDTO.animal_species}&animal_age=${animalDTO.animal_age }&animal_gender=${animalDTO.animal_gender }&animal_weight=${animalDTO.animal_weight }&animal_status=${animalDTO.animal_status }&animal_place=${animalDTO.animal_place }&keyword=${keyword }&sort=${sort }" />
<c:set var="pagingSort"
	value="animal_size=${animalDTO.animal_size }&animal_species=${ animalDTO.animal_species}&animal_age=${animalDTO.animal_age }&animal_gender=${animalDTO.animal_gender }&animal_weight=${animalDTO.animal_weight }&animal_status=${animalDTO.animal_status }&animal_place=${animalDTO.animal_place }&keyword=${keyword }" />
<%--검색--%>
<div class="div1">

	<div class="text-center main-title">
		<label>입양을 기다리는 ${ animal } 
		<span class="more_info" onclick="search()">자세히 찾아보기</span>
		</label>
		<p>당신과 평생 함께 할 ${ animal }를 만나보세요.</p>
	</div>
	
	<input type="hidden" id="sortlink"
		value="<%=request.getContextPath() %>/user_${animalDTO.animal_tag }_list?page=${ paging.page }&${pagingSort}" />
	
	<div id="form" class="form_search mb-3">
		<form action="<%=request.getContextPath() %>/user_${animalDTO.animal_tag }_list" class="validation-form wells" method="post">
            <div class="search-semi-title">
                <span><i class="bi bi-search-heart-fill"></i> ${ animal } 찾기</span>
            </div>            
            <table class="table table-borderless animal-table">
                <tr>
                    <th width="7%">위치</th>
                    <td colspan="5">
                        <div class="animal-place-select">
			                    <select name="animal_place" class="form-select">
			                        <option value=""></option>
			                        <option value="서울" <c:if test="${fn:contains(animalDTO.animal_place,'서울')}">selected</c:if>>서울특별시</option>
			                        <option value="울산" <c:if test="${fn:contains(animalDTO.animal_place,'울산')}">selected</c:if>>울산광역시</option>
			                        <option value="인천" <c:if test="${fn:contains(animalDTO.animal_place,'인천')}">selected</c:if>>인천광역시</option>
			                        <option value="부산" <c:if test="${fn:contains(animalDTO.animal_place,'부산')}">selected</c:if>>부산광역시</option>
			                        <option value="대전" <c:if test="${fn:contains(animalDTO.animal_place,'대전')}">selected</c:if>>대전광역시</option>
			                        <option value="광주" <c:if test="${fn:contains(animalDTO.animal_place,'광주')}">selected</c:if>>광주광역시</option>
			                        <option value="대구" <c:if test="${fn:contains(animalDTO.animal_place,'대구')}">selected</c:if>>대구광역시</option>
			                        <option value="세종" <c:if test="${fn:contains(animalDTO.animal_place,'세종')}">selected</c:if>>세종특별자치시</option>
			                        <option value="제주" <c:if test="${fn:contains(animalDTO.animal_place,'제주')}">selected</c:if>>제주틀별자치도</option>
			                    </select>                  
	                           <input type="text" name="keyword" placeholder="상세주소 입력" class="form-control" value="${ keyword }">
                        </div>
                    </td>
                    <th width="10%">접종 유무</th>
                    <td width="10%">
                        <select name="animal_vaccination" class="form-select">
                            <option value=""></option>
                            <option value="Y" <c:if test="${animalDTO.animal_vaccination eq 'Y'}">selected</c:if>>Yes</option>
                            <option value="N" <c:if test="${animalDTO.animal_vaccination eq 'N'}">selected</c:if>>No</option>
                        </select> 
                    </td>
                    <th width="10%">입양 상태</th>
                    <td>
                        <select name="animal_status" class="form-select">
                            <option value=""></option>
                            <option value="입소 신청" <c:if test="${animalDTO.animal_status eq '입소 신청'}">selected</c:if>>입소 신청</option>
                            <option value="입양 가능" <c:if test="${animalDTO.animal_status eq '입양 가능'}">selected</c:if>>입양 가능</option>
                            <option value="입양 대기" <c:if test="${animalDTO.animal_status eq '입양 대기'}">selected</c:if>>입양 대기</option>
                            <option value="입양 완료" <c:if test="${animalDTO.animal_status eq '입양 완료'}">selected</c:if>>입양 완료</option>
                        </select>                    
                    </td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td width="10%">
                        <select name="animal_gender" class="form-select">
                            <option value=""></option>
                            <option value="male" <c:if test="${animalDTO.animal_gender eq 'male'}">selected</c:if>>수컷</option>
                            <option value="female" <c:if test="${animalDTO.animal_gender eq 'female'}">selected</c:if>>암컷</option>
                        </select>                  
                    </td>
                    <th width="7%">나이</th>
                    <td width="10%">
                        <select name="animal_age" class="form-select">
                            <option value="0"></option>
                            <option value="1" <c:if test="${animalDTO.animal_age eq '1'}">selected</c:if>>0~3</option>
                            <option value="2" <c:if test="${animalDTO.animal_age eq '2'}">selected</c:if>>3~5</option>
                            <option value="3" <c:if test="${animalDTO.animal_age eq '3'}">selected</c:if>>5~10</option>
                            <option value="4" <c:if test="${animalDTO.animal_age eq '4'}">selected</c:if>>10~</option>
                        </select>                 
                    </td>                   
                    <th width="7%">종류</th>
                    <td width="16%">
	                    <select name="animal_species" class="form-select">	
	                		<jsp:include page="../../include/animal_species.jsp" /><!-- animal_species select -->
	                	</select>
                    </td> 
                    <th>사이즈</th>
                    <td colspan="3">
                        <div class="d-flex">
	                        <select name="animal_size" class="form-select animal-size" id="size" onclick="optionChangeSize()">
	                            <option value=""></option>
	                            <option value="소형" <c:if test="${animalDTO.animal_size eq '소형'}">selected</c:if>>소형</option>
	                            <option value="중형" <c:if test="${animalDTO.animal_size eq '중형'}">selected</c:if>>중형</option>
	                            <option value="대형" <c:if test="${animalDTO.animal_size eq '대형'}">selected</c:if>>대형</option>
	                        </select>             
	                        <select name="animal_weight_temp" class="form-select animal-weight" id="weight" onclick="optionChangeWeight()">
                                <option value=""></option>
                                <option value="1">1kg ~ 4kg</option>
                                <option value="2">4kg ~ 10kg</option>
                                <option value="3">>10kg 이상</option>
                            </select>     
                        </div>          
                    </td>                                                          
                </tr>            
            </table>
			<div class="search-buttons">
				<button type="submit" class="btn btn-dark"><i class="bi bi-search"></i> 검색</button>            
				<button class="btn btn-light" type="button" onclick="location.href='${ path }/user_${animalDTO.animal_tag }_list'"><i class="bi bi-arrow-counterclockwise"></i> 리셋</button>
			</div>
		</form>
	</div>
	
	<%--정렬--%>
	<div class="order">
		<select class="form-select form-select-sm" name="sort" id="sort">
			<option selected="selected" value="size" 
				<c:if test="${sort eq 'size'}">selected</c:if>>최신등록순</option>
			<option value="weight"
				<c:if test="${sort eq 'weight'}">selected</c:if>>무게</option>
			<option value="age" <c:if test="${sort eq 'age'}">selected</c:if>>나이</option>
		</select>
		<!-- <form class="validation-form mx-2" action="" method="post">
			<select class="form-select " name="sort">
				<option value="des">내림차순</option>
				<option value="asc">오름차순</option>
			</select>
		</form> -->
	</div>
	
	<%--메인 페이지--%>
	<div class="main_mainContents__GXYBn">
		<%--강아지 정보 폼--%>
	
		<div class="main_mainGridContainer__xl9yt">
			<c:if test="${not empty animalList}">
				<c:forEach var="dto" items="${animalList}">
					<div class="mainContent_mainContentBox__shdST">
						<!-- d-flex flex-row text-center  p-2 alert-primary alert alert-primary animal_wrap -->
						<div class="mainContent_mainImgWrapper__DJlMe">
							<%-- <input type="hidden"
								value="<%=request.getContextPath() %>/user_animal_content?no=${dto.getAnimal_no()}"> --%>
							<%-- <a
								href="<%=request.getContextPath() %>/user_animal_content?no=${dto.getAnimal_no()}"><img
								class="img-fluid rounded mx-auto img-frame"
								src="<%=request.getContextPath()%>/resources/upload/${dto.getAnimal_img1()}"></a> --%>
							<div class="mainContent_mainImgWrapper__DJlMe rounded back_image"
								style="background-image : url(<%=request.getContextPath()%>${dto.getAnimal_img1()});" data-value = "<%=request.getContextPath() %>/user_animal_content?no=${dto.getAnimal_no()}"></div>
							<div class="mainContent_mainContent__w_Buk">
								<!-- href=request.getContextPath()h() %>/user_animal_content?no=${dto.getAnimal_no()}" -->
								<div class="mainContent_mainTitle__8iW62">${dto.getAnimal_name() }</div>
								<div class="mainContent_mainAuthor__kKyGl">${dto.animal_status }</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<c:if test="${empty animalList}">
			<h3>해당 내용이 없습니다.</h3>
		</c:if>
	
	</div>
	<%--페이징--%>
	
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
	
			<!-- 처음으로 -->
			<c:if test="${ paging.page eq 1 }">
				<li class="page-item disabled">
			</c:if>
			<c:if test="${ paging.page gt 1 }">
				<li class="page-item">
			</c:if>
			<a class="page-link" href="${link_address}?page=1&${pagingTag}"
				aria-label="First"> <span aria-hidden="true">&laquo;</span>
			</a>
			</li>
	
			<!-- 이전으로 -->
			<c:if test="${ paging.page eq 1 }">
				<li class="page-item disabled">
			</c:if>
			<c:if test="${ paging.page gt paging.block }">
				<li class="page-item">
			</c:if>
			<a class="page-link"
				href="${link_address}?page=${ paging.page - 1 }&${pagingTag}"
				aria-label="Previous"> <span aria-hidden="true">&lsaquo;</span>
			</a>
			</li>
	
			<!-- 페이지 중간 -->
			<c:forEach begin="${ paging.startBlock }" end="${ paging.endBlock }"
				var="i">
				<c:if test="${ i == paging.page }">
					<li class="page-item active"><a class="page-link"
						href="${link_address}?page=${ i }&${pagingTag}">${ i }</a></li>
				</c:if>
				<c:if test="${ i != paging.page }">
					<li class="page-item"><a class="page-link"
						href="${link_address}?page=${ i }&${pagingTag}">${ i }</a></li>
				</c:if>
			</c:forEach>
	
			<!-- 다음으로 -->
			<c:if test="${ paging.endBlock lt paging.allPage }">
				<li class="page-item">
			</c:if>
			<c:if test="${ paging.endBlock eq paging.allPage }">
				<li class="page-item disabled">
			</c:if>
			<a class="page-link"
				href="${link_address}?page=${ paging.page + 1 }&${pagingTag}"
				aria-label="Next"> <span aria-hidden="true">&rsaquo;</span>
			</a>
			</li>
	
			<!-- 마지막으로 -->
			<c:if test="${ paging.endBlock lt paging.allPage }">
				<li class="page-item">
			</c:if>
			<c:if test="${ paging.endBlock eq paging.allPage }">
				<li class="page-item disabled">
			</c:if>
			<a class="page-link"
				href="${link_address}?page=${ paging.allPage }&${pagingTag}"
				aria-label="Last"> <span aria-hidden="true">&raquo;</span>
			</a>
			</li>
		</ul>
	</nav>
	<script type="text/javascript">
		$(function() {
			
			$("#form").css({
				 'display' : 'block'
			 });			
			
		});
		
		//정렬 select
		$("#sort").change(
				function() {
					location.href = $("#sortlink").val() + '&sort='
							+ $('select[name=sort]').val();
				});
		$(document).on("click", ".back_image", function() {
			location.href = $(this).data("value");
		});
		/* $(document).ready(function () {
			  $(document).on("click", ".back_image", function () {
			    location.href = $('#href').val();
			  });
			});
		 */
		 function search() {
			 
			 $("#form").toggle();
			 
			 /* $("#form").css({
				 'display' : 'block'
			 }); */
		 }
		 
		 /* 사이즈에 따른 무게 범위 */		
			function optionChangeSize() {
				if($('#size').val() == ''){
					$("#weight").val("").prop("selected", true);
				}
				if($('#size').val() == '소형'){
					$("#weight").val("1").prop("selected", true);
				}
				if($('#size').val() == '중형'){
					$("#weight").val("2").prop("selected", true);
				}
				if($('#size').val() == '대형'){
					$("#weight").val("3").prop("selected", true);
				}
			}
		 
			function optionChangeWeight() {
				if($('#weight').val() == ''){
					$("#size").val("").prop("selected", true);
				}
				if($('#weight').val() == '1'){
					$("#size").val("소형").prop("selected", true);
				}
				if($('#weight').val() == '2'){
					$("#size").val("중형").prop("selected", true);
				}
				if($('#weight').val() == '3'){
					$("#size").val("대형").prop("selected", true);
				}
			}
	</script>
	
	<jsp:include page="../../include/user_footer.jsp" />

</div>