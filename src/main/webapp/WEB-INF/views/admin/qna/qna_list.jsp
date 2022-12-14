<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="qList" value="${ qnaList }"/>
<c:set var="total" value="${ total }"/>
<c:set var="paging" value="${ paging }"/>
<c:set var="field" value="${ field }"/>
<c:set var="keyword" value="${ keyword }"/>
<c:set var="link_address" value="${pageContext.request.contextPath}/admin_qna_list" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />	

<!-- modal delete Function 추가 시 data-id 검색 -> 주소값만 수정하세요....
+ admin_list_view.js include 하기 -->



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HeartPet_Admin_QNA</title>
    <jsp:include page="../../include/admin_header.jsp" />
	<link rel="stylesheet" href="${path}/resources/css/list_view.css" />
	<script src="${path}/resources/js/admin_list_view.js"></script>

</head>
<body>
    <br>
    <div class="container">

        <%-- 검색 폼 --%>
        <form class="search_form" method="get" action="${path}/admin_qna_list">
            <div class="form_box d-flex">
           		<span class="search-name">분류</span>
                <select name="field" class="form-select d-inline align-middle w-25">
                    <option value="allSearch"<c:if test="${ field eq 'allSearch' }">selected="selected"</c:if>>전체</option>
                    <option value="category"<c:if test="${ field eq 'category' }">selected="selected"</c:if>>분류</option>
                    <option value="title"<c:if test="${ field eq 'title' }">selected="selected"</c:if>>제목</option>
                    <option value="content"<c:if test="${ field eq 'content' }">selected="selected"</c:if>>내용</option>
                    <option value="id"<c:if test="${ field eq 'id' }">selected="selected"</c:if>>작성자</option>
                </select>
                <span class="search-name">검색어</span> 
                <input name="keyword" class="form-control d-inline align-middle w-50" value="${ keyword }">
                <button class="btn btn-dark d-inline align-middle ms-1" type="submit"><i class="bi bi-search"></i> 검색</button>
           </div>
        </form>
        <br>
        
       <%-- 정렬 & 게시물 수 --%>
    <form class="order_form" method="get" action="${path}/admin_qna_list">    
       <div class="qna-section">
            <div class="total-data"><span>총 <fmt:formatNumber value="${ total }" /> 개의 게시물</span></div>
            <div class="qna_order">
                <select class="form-select form-select-sm" name="order" onchange="this.form.submit()">
                    <option selected="selected" value="no_desc"<c:if test="${ order eq 'no_desc' }">selected="selected"</c:if>>번호높은순</option>
                    <option value="date_desc"<c:if test="${ order eq 'date_desc' }">selected="selected"</c:if>>최신등록순</option>
                    <option value="hit_desc"<c:if test="${ order eq 'hit_desc' }">selected="selected"</c:if>>인기순</option>
                    <option value="title_desc"<c:if test="${ order eq 'title_desc' }">selected="selected"</c:if>>가나다순</option>
                </select>
            </div>
        </div>
        </form>
        
        <%-- 검색 결과 테이블 --%>
        <div class="lists">
            <table class="table table-hover searched_list">
                <tr>                
                    <th class="table-light col-1">No</th>
                    <th class="table-light col-1">분류</th>
                    <th class="table-light col-4">제목</th>
                    <th class="table-light col-1">작성자</th>
                    <th class="table-light col-1">조회수</th>
                    <th class="table-light col-2">작성일시</th>
                    <th class="table-light col-2">답변 / 삭제</th>
                </tr>
				<c:forEach items="${ qList }" var="list">
                <tr>
                    <td>${ list.board_no }</td>
                    <td>${ list.board_category }</td>
                    <td class="list-title"><a href="${ path }/admin_qna_content?board_no=${ list.board_no }&board_group=${ list.board_group }">
                    <c:choose>
                    	<c:when test="${ list.level > 1 }">
                    		<c:forEach begin="1" end="${ list.level-1 }" step="1">
                    		<span style="padding-left:20px"></span>	                    		
                    		</c:forEach>
                    		<span class="badge rounded-pill text-bg-light"><i class="bi bi-arrow-return-right"></i> Re</span>
                    	</c:when>
	                </c:choose>
                    <c:if test="${ list.board_title.length() gt 30 }">${ list.board_title.substring(0,30) }...</c:if>
					<c:if test="${ list.board_title.length() lt 30 }">${ list.board_title }</c:if>
                    <c:if test="${ list.board_secret eq 'Y' }"><i class="bi bi-lock-fill"></i></c:if>
                    <c:if test="${ not empty list.board_update }"><small>(edited)</small></c:if>
                    <c:if test="${ list.board_regdate.substring(0,10) eq today }"><span class="badge rounded-pill text-bg-warning">N</span></c:if>	                    
                    </a></td>
                    <td><c:if test="${ list.board_id eq 'admin' }"><span id="admin_id">관리자</span></c:if>
                    <c:if test="${ list.board_id ne 'admin' }"><span>${ list.board_id }</span></c:if></td>
                    <td>${ list.board_hit }</td>
                    <td>${ list.board_regdate.substring(0,10) }</td>
                    <td>
                        <button class="btn btn-outline-primary btn-sm" onclick="location.href='${path}/admin_qna_reply_insert?board_parentNo=${ list.board_no }&board_group=${ list.board_group }'">답변</button>
                        <button class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" data-id="${ path }/admin_qna_delete?board_no=${ list.board_no }">삭제</button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </div>
        
        <%-- 삭제 모달 // admin_list_view.js 삽입되어 있음
        	modal-dialog-centered 삽입됨
         --%>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div id="myInput" class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">데이터 삭제</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        해당 데이터를 삭제하시겠습니까?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger" id="deleteFunction">삭제</button>
                    </div>
                </div>
            </div>
        </div>
        
        <%-- 페이징처리 --%>
		<jsp:include page="../../include/pagination.jsp" />
		
    </div>
    <div class="space"> </div>
</body>
</html>