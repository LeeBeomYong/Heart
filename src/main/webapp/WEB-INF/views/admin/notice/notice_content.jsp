<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="../../include/admin_header.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HeartPet</title>
    <link rel="stylesheet" href="${path}/resources/css/list_view.css">
    <link rel="stylesheet" href="resources/css/notice.css">
</head>
<body>
<c:set var="dto" value="${Cont }"/>
<div class="container">

    <br>
    <br><br>

    <table class="table noticeinfo mt-4">
        <tr>
            <th class="table-light col-1">제목</th>
            <td class="col-1" colspan="5" style="font-weight:bold;">${dto.getNotice_title() }</td>
        </tr>

        <tr>
            <th class="table-light">내용</th>
            <td class="col-1"colspan="5">
                <textarea cols="60" readonly>${dto.getNotice_content() }</textarea>
            </td>
        </tr>
       
        <tr>
            <th class="table-light">이미지</th>

            <c:if test="${!empty dto.getNotice_img1() }">
            <td class="col-1" colspan="5"><img src="resources/upload/${dto.getNotice_img1() }" style="max-height: 200px;" alt="notice_img"></td>
            </c:if>
            <c:if test="${!empty dto.getNotice_img2() }">
            <td class="col-1" colspan="5"><img src="resources/upload/${dto.getNotice_img2() }" style="max-height: 200px;" alt="notcie_img"></td>
        	</c:if>

        </tr>

    </table>

    <br>
    <%-- 목록 버튼만 : 수정,삭제,등록은 list.jsp에서  --%>
    <button type="button" id="btn_content" class="btn btn-dark mx-1" onclick="location.href='${path}/notice_list'"><i class="bi bi-card-list"></i> 목록</button>

</div>
<script>
	$(document).ready(function() {
		$('.noticeinfo').on( 'keyup', 'textarea', function (e){
			$(this).css('height', 'auto' );
			$(this).height( this.scrollHeight );
		});
		$('.noticeinfo').find( 'textarea' ).keyup();
	});
</script>
</body>
</html>