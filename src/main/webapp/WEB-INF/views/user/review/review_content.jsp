<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newline", "\n"); %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="list" value="${ reviewContent }" />
<jsp:include page="../../include/user_header.jsp" />
<link rel="stylesheet" href="${path}/resources/css/user_review.css" />

<div id="review-contents" class="review-contents">
    <div class="review-section">
        <div class="row">
            <div class="col-3 space"></div>
            <div class="col-6 title">
                <h2>입양후기 - ${ list.animal_name } </h2>
            </div>
            <div class="col-3 space"></div>
        </div>
    </div>

    <div>
        <div class="border review-content">
            <div class="content-header">
                <div><h3>${ list.review_title }</h3></div>
                <div class="header-info">
                    <ul>
                        <li class="d-inline">
                            <img src="${path}/resources/image/heartpet_logo.png" alt="">
                        </li>
                        <li class="d-inline">
                            <a href="${path}/mypage"><span id="id">${ list.review_id }</span></a>
                            <a id="reply" href="#"><i class="bi bi-card-list"></i> 댓글 0</a>
                        </li>
                        <li class="d-block">${ list.review_regdate } 조회 ${ list.review_hit }</li>
                    </ul>
                </div>
                <hr>
            </div>
            <div class="content" data-bs-spy="scroll" data-bs-target="#content-scroll">
                <div id="content-scroll">
                    <div class="content-body">
                        <div class="review-image shadow-sm my-3 bg-body rounded">
                            <img src="${path}/resources/image/potter.jpg" class="rounded mx-auto d-block" alt="review_image">
                        </div>
                        <div class="review-text mb-3">
                            ${ fn:replace(list.review_content, newline, '<br/>') }
                        </div>
                    </div>
                </div>
            </div>

            <%-- 댓글쓰기 // 아직 DB 없음 --%>
            <form action="" method="post">
                <table class="table table-bordered reply-table">
                    <tr class="align-middle">
                        <th class="col-2">댓글쓰기</th>
                        <td class="col-10" id="content-reply">
                            <textarea class="form-control" name="" id="" cols="30" rows="5" placeholder="댓글을 남겨보세요."></textarea>
                            <button type="submit" class="btn btn-outline-primary btn-sm"><i class="bi bi-reply"></i> 댓글등록</button>
                        </td>
                    </tr>
                </table>
            </form>

            <div class="content-buttons">
                <%-- 내 글인 경우 --%>
                <button type="button" class="btn btn-success" onclick="location.href='${path}/user_review_update?review_no=${ list.review_no }'"><i class="bi bi-eraser"></i> 수정</button>
                <button type="button" class="btn btn-danger" onclick="location.href=''"><i class="bi bi-trash3"></i> 삭제</button>
                <%-- 여기까지 --%>
                <button type="submit" class="btn btn-dark" onclick="location.href='${path}/user_review_list'"><i class="bi bi-card-list"></i> 목록</button>
            </div>
        </div>
    </div>

    <div class="space-add"></div>

</div>

<jsp:include page="../../include/user_footer.jsp" />