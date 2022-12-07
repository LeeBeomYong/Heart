<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="list" value="${qnaContent}" />
<jsp:include page="../../include/user_header.jsp" />
<link rel="stylesheet" href="${path}/resources/css/user_qna.css" />

<%-- 글쓰기 --%>
<div id="qna-contents" class="qna-contents">
    <div class="qna-section">
        <div class="row">
            <div class="col-3 space"></div>
            <div class="col-6 title">문의글 수정하기</div>
            <div class="col-3 space"></div>
        </div>
    </div>

    <div>
        <form name="updateForm" action="${ path }/user_qna_update_ok" method="post" enctype="multipart/form-data" >
        	<input type="hidden" name="board_no" value="${ list.board_no }" />
        	<input type="hidden" name="board_id" value="${ list.board_id }" />
            <table class="table align-middle">
                <tr class="border-top">
                    <th class="table-light col-1">카테고리</th>
                    <td class="col-2"><%-- db 확인 필요 --%>
                        <select class="form-select" name="board_category" id="">
                            <option value="입양" <c:if test="${ list.board_category eq '입양' }">selected="selected"</c:if>>입양</option>
                            <option value="입소" <c:if test="${ list.board_category eq '입소' }">selected="selected"</c:if>>입소</option>
                            <option value="후원" <c:if test="${ list.board_category eq '후원' }">selected="selected"</c:if>>후원</option>
                            <option value="기타" <c:if test="${ list.board_category eq '기타' }">selected="selected"</c:if>>기타</option>
                        </select>
                    </td>
                    <th class="table-light col-1">작성자</th>
                    <td class="col-2"><input type="text" class="form-control" name="board_id" value="${ list.board_id }" disabled="disabled"></td>
                    <th class="table-light col-1">
                    <label><input class="form-check-input col-1" type="checkbox" name="board_secret" <c:if test="${ list.board_secret eq 'Y' }">checked="checked"</c:if>> 비밀글</label>
                    
                    </th>
                </tr>
                <tr>
                    <th class="table-light">제목</th>
                    <td colspan="4"><input type="text" class="form-control" name="board_title" value="${ list.board_title }" required="required"></td>
                </tr>
                <tr>
                    <th class="table-light">내용</th>
                    <td colspan="4"><textarea name="board_content" class="form-control" cols="30" rows="10">${ list.board_content }</textarea></td>
                </tr>
                <tr>
                    <th class="table-light">글 비밀번호</th>
					<td class="col-2"><input type="password" class="form-control" name="board_pwd" required="required">
					</td>
					<th class="table-light">이미지</th>
	                <td colspan="2">
	                    <div class="d-flex align-middle">
	                        <input type="file" class="form-control" name="board_img" accept="image/gif, image/jpeg, image/png" multiple>
	                    </div>
                	</td>
                </tr>
            </table>

            <div class="qna-section">
                <div class="row">
                    <div class="col-3 space"></div>
                    <div class="col-6 title btn-insert">
                        <button type="reset" class="btn btn-warning"><i class="bi bi-pencil"></i> 다시작성</button>
                        <button type="submit" class="btn btn-dark"><i class="bi bi-eraser"></i> 수정하기</button>
                    </div>
                    <div class="col-3 space"></div>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../../include/user_footer.jsp" />