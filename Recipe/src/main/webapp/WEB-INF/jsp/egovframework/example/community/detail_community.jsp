<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시글 상세</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="icon" href="/images/01.png" type="image/png">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/exstyle.css">
  <link rel="stylesheet" href="/css/Community.css">
  <link rel="stylesheet" href="/css/detail_Community.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/common/header.jsp" />
<div class="comubody">
<h3 class="title">자유게시판 </h3>
<div class="container mt-5">

  <!-- 수정용 form -->
  <form id="updateForm" method="post" action="<c:url value='/community/update.do'/>" enctype="multipart/form-data">
    <input type="hidden" name="uuid" value="${community.uuid}">

    <c:if test="${not empty message}">
      <div class="alert alert-success">${message}</div>
    </c:if>

    <div class="card">
      <div class="card-header position-relative">
        <h3 class="mb-0" id="view-title">${community.communityTitle}</h3>
        <input type="text" class="form-control d-none" id="edit-title" name="communityTitle" value="${community.communityTitle}">
        <small class="text-muted">
          ${fn:substring(community.communityCreatedAt, 2, 16)} · ${community.userNickname}
        </small>

        <div class="button-box" id="author-buttons">
          <button type="button" class="btn btn-outline-danger btn-sm" id="delete-btn" onclick="submitDelete()">삭제</button>
          <button type="button" class="btn btn-sm edit-btn" id="edit-btn">수정</button>
        </div>
      </div>

      <div class="card-body">
        <div id="view-image">
          <c:if test="${not empty community.communityImage}">
            <img src="/community/image.do?uuid=${community.uuid}" class="img-fluid mb-3" alt="찾는 이미지" />
          </c:if>
        </div>

        <div id="edit-image" class="d-none mb-3">
          <label class="form-label">이미지 변경</label>
          <input type="file" class="form-control" name="uploadFile">
        </div>

        <p class="card-text pre-line" id="view-content">${community.communityContent}</p>
        <textarea class="form-control d-none pre-line" id="edit-content" name="communityContent">${community.communityContent}</textarea>

        <div class="mt-3 d-none" id="edit-buttons">
          <button type="submit" class="btn btn-success btn-sm" id="save-btn">저장</button>
          <button type="button" class="btn btn-secondary btn-sm" id="cancel-btn">취소</button>
        </div>
      </div>
    </div>
  </form>

  <!-- 삭제용 form -->
  <form id="deleteForm" method="post" action="<c:url value='/community/delete.do'/>">
    <input type="hidden" name="uuid" value="${community.uuid}" />
  </form>

  <!-- 댓글 영역 -->
  <div id="comment-area" class="mb-3 mt-4">
    <h5>댓글</h5>
    <div id="commentListArea"></div>
  </div>

  <c:if test="${not empty sessionScope.memberVO}">
    <div class="mt-3">
      <button id="likeBtn"
              type="button"
              class="btn btn-outline-danger btn-sm px-3 ${isLiked ? 'text-danger' : ''}"
              data-uuid="${community.uuid}">
        <span id="likeIcon">${isLiked ? '&#9829;' : '&#9825;'}</span>
        <span id="likeLabel">${isLiked ? '취소' : '좋아요'}</span>
         <span id="likeCount" class="ms-2">${community.likeCount}</span>
      </button>
     
    </div>
  </c:if>

  <br>
  <a href="<c:url value='/community/community.do'/>" class="btn btn-secondary">목록으로</a>
</div>
</div>

<jsp:include page="/common/footer.jsp" />

<!-- 수정/취소 버튼 동작 -->
<script>
  const editBtn = document.getElementById('edit-btn');
  const saveBtn = document.getElementById('save-btn');
  const cancelBtn = document.getElementById('cancel-btn');
  const deleteBtn = document.getElementById('delete-btn');

  const viewTitle = document.getElementById('view-title');
  const editTitle = document.getElementById('edit-title');

  const viewContent = document.getElementById('view-content');
  const editContent = document.getElementById('edit-content');

  const viewImage = document.getElementById('view-image');
  const editImage = document.getElementById('edit-image');

  const editButtons = document.getElementById('edit-buttons');
  const commentArea = document.getElementById('comment-area');

  editBtn.addEventListener('click', function () {
    viewTitle.classList.add('d-none');
    editTitle.classList.remove('d-none');
    viewContent.classList.add('d-none');
    editContent.classList.remove('d-none');
    viewImage.classList.add('d-none');
    editImage.classList.remove('d-none');
    editBtn.classList.add('d-none');
    editButtons.classList.remove('d-none');
    commentArea.classList.add('d-none');
    if (deleteBtn) deleteBtn.classList.add('d-none');
  });

  cancelBtn.addEventListener('click', function () {
    viewTitle.classList.remove('d-none');
    editTitle.classList.add('d-none');
    viewContent.classList.remove('d-none');
    editContent.classList.add('d-none');
    viewImage.classList.remove('d-none');
    editImage.classList.add('d-none');
    editBtn.classList.remove('d-none');
    editButtons.classList.add('d-none');
    commentArea.classList.remove('d-none');
    if (deleteBtn) deleteBtn.classList.remove('d-none');
  });

  function submitDelete() {
    if (confirm('정말 삭제하시겠습니까?')) {
      document.getElementById('deleteForm').submit();
    }
  }
</script>

<!-- 댓글 Ajax 로딩 -->
<script>
  $(function () {
    const uuid = '${community.uuid}';
    const targetType = 'community';

    $("#commentListArea").load("/comment/list.do", {
      uuid: uuid,
      targetType: targetType,
      pageIndex: 1
    });
  });
</script>

<!-- 좋아요 Ajax 처리 -->
<script>
  $(function () {
    $('#likeBtn').on('click', function () {
      const btn = $(this);
      const uuid = btn.data('uuid');

      $.ajax({
        url: '/like/toggle.do',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
          uuid: uuid,
          targetType: 'community',
          userId: '${sessionScope.memberVO.userId}'
        }),
        dataType: 'text'
      })
      .done(function (status) {
  const liked = (status === 'liked');
  $('#likeIcon').html(liked ? '&#9829;' : '&#9825;');
  $('#likeLabel').text(liked ? '취소' : '좋아요');
  // ✅ 클래스 추가 제거 필요 없음 (항상 빨간색 유지하므로 제거)
  $.get('/like/count.do', { uuid: uuid }, function (count) {
    $('#likeCount').text(count);
  });
})
      .fail(function (xhr) {
        if (xhr.status === 401) {
          alert('로그인 후 이용해 주세요.');
        } else {
          alert('좋아요 처리 중 오류가 발생했습니다.');
        }
      });
    });
  });
</script>

<!-- 작성자만 수정/삭제 버튼 노출 -->
<script>
  const loginUserId = '${sessionScope.memberVO.userId}';
  const writerUserId = '${community.userId}';
  if (loginUserId !== writerUserId) {
    document.getElementById('author-buttons').style.display = 'none';
  }
</script>

<script src="/js/nav.js"></script>

</body>
</html>
