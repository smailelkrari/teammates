<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="teammates.common.util.Const" %>
<%@ taglib tagdir="/WEB-INF/tags/shared" prefix="shared" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="hidden number-of-pending-comments">${data.numberOfPendingComments}</div>
<c:choose>
  <c:when test="${empty data.questionCommentsMap}">
    <div id="no-comment-panel">
      <br>
      <div class="panel panel-info">
        <ul class="list-group comments">
          <li class="list-group-item list-group-item-warning">
            You don't have any comment in this session.
          </li>
        </ul>
      </div>
    </div>
  </c:when>
  <c:otherwise>
    <c:set var="fsIndex" value="${data.feedbackSessionIndex}" />
    <c:forEach items="${data.questionCommentsMap}" var="questionCommentsEntry" varStatus="responseEntriesStatus">
      <div class="panel panel-info feedback-question-panel">
        <div class="panel-heading">
          <c:set var="question" value="${questionCommentsEntry.key}"/>
          <b>Question ${question.questionNumber}</b>:
          ${question.questionDetails.questionText}
          ${question.questionAdditionalInfoHtml}
        </div>
        <table class="table">
          <tbody>
            <c:forEach items="${questionCommentsEntry.value}" var="response" varStatus="responseStatus">
              <tr class="feedback-response-giver-recipient-row table-row-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}">
                <td><b>From:</b> ${fn:escapeXml(response.giverName)} <b>To:</b> ${fn:escapeXml(response.recipientName)}</td>
              </tr>
              <tr class="table-row-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}">
                <td><strong>Response: </strong>${response.answerHtml}</td>
              </tr>
              <tr class="active table-row-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}">
                <td>Comment(s):
                  <button type="button"
                      class="btn btn-default btn-xs icon-button pull-right show-frc-add-form"
                      id="button_add_comment-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}"
                      data-recipientindex="${fsIndex}" data-giverindex="${responseEntriesStatus.count}"
                      data-qnindex="${responseStatus.count}"
                      data-toggle="tooltip" data-placement="top"
                      title="<%= Const.Tooltips.COMMENT_ADD %>"
                      <c:if test="${not response.instructorAllowedToSubmit}">disabled</c:if>>
                    <span class="glyphicon glyphicon-comment glyphicon-primary"></span>
                  </button>
                </td>
              </tr>
              <tr class="table-row-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}">
                <td>
                  <ul class="list-group comments"
                      id="responseCommentTable-${fsIndex}-${responseEntriesStatus.count}-${responseStatus.count}"
                      <c:if test="${empty response.feedbackResponseComments}">style="display: none;"</c:if>>
                    <c:forEach var="frc" items="${response.feedbackResponseComments}" varStatus="frcStatus">
                      <shared:feedbackResponseCommentRow frc="${frc}"
                          firstIndex="${fsIndex}"
                          secondIndex="${responseEntriesStatus.count}"
                          thirdIndex="${responseStatus.count}"
                          frcIndex="${frcStatus.count}" />
                    </c:forEach>
                    <shared:feedbackResponseCommentAdd frc="${response.feedbackResponseCommentAdd}"
                        firstIndex="${fsIndex}"
                        secondIndex="${responseEntriesStatus.count}"
                        thirdIndex="${responseStatus.count}" />
                  </ul>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:forEach>
  </c:otherwise>
</c:choose>
