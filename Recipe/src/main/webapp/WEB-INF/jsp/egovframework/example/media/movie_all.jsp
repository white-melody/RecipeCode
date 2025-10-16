<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RecipeCode</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 파비콘 추가 -->
<link rel="icon" href="/images/01.png" type="image/png">
<!-- 	부트스트랩 css  -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- 	개발자 css -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/exstyle.css">
<link rel="stylesheet" href="/css/media.css">
</head>
<body>
	<!-- 머리말 -->
	<jsp:include page="/common/header.jsp" />
	
	<input type="hidden" id="uuid" value="${media.uuid}" />

	<form id="listForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1" />
	</form>

	<!-- 본문 -->
<!-- 정보 -->
	<div class="info-card">
  <h3 class="info-title">영화 속 레시피</h3>
  <p class="info-desc">
    영화 같은 순간을 만드는 특별한 레시피 컬렉션. 화면 속 요리가 현실이 되는, 맛의 시네마.
  </p>
</div>

<!-- 카드 섹션 -->
<div class="container px-4">
  
  <!-- 업로드 버튼: 카드 내부 상단 오른쪽 정렬 -->
  <div class="d-flex justify-content-end mb-3">
    <c:if test="${not empty sessionScope.memberVO}">
      <a href="<c:out value='/media/addition.do'/>" class="btn btn-outline-dark">업로드</a>
    </c:if>
  </div>
  
<!-- 카드 -->
	<div class="row row-cols-1 row-cols-md-3 g-4">
		<c:forEach var="data" items="${ask}">
			<div class="col">
				<a href="<c:out value='/media/open.do?uuid=${data.uuid}'/>"
					class="text-decoration-none text-dark">
					<div class="card h-100">
					<span class="like">
					❤️ <c:out value="${data.likeCount}" />
		  			</span>
						<img
								src="${data.recipeImageUrl != null ? data.recipeImageUrl : '/images/default.jpg'}"
								class="card-img" alt="이미지">
						<div class="card-body">
							<h5 class="card-title">
								<c:out value="${data.title}" />
							</h5>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</div>

	<!-- 여기: 페이지번호 -->
	<div class="d-flex justify-content-center mt-3">
		<nav aria-label="Page navigation example">
			<ul class="pagination" id="pagination"></ul>
		</nav>
	</div>

	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- 부트스트랩 js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<!-- 토글 애니메이션 js -->
	<script src="/js/nav.js"></script>
	<!-- 페이징 라이브러리 -->
	<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>

	<script type="text/javascript">
		/* 페이지번호 클릭시 전체조회 */
		function fn_egov_link_page(page) {
			/* 현재페이지번호 저장 */
			$("#pageIndex").val(page);
			$("#listForm").attr("action", '<c:out value="/media/movie.do" />')
					.submit();
		}
		/* 전체조회 */
		function fn_egov_selectList() {
			$("#pageIndex").val(1); // 최초 화면에서는 페이지번호를 1페이지로 지정
			$("#listForm").attr("action", '<c:out value="/media/movie.do" />')
					.submit();
		}
	</script>

	<script type="text/javascript">
		/* 페이징 처리 */
		$('#pagination').twbsPagination({
			totalPages : "${paginationInfo.totalPageCount}",
			startPage : parseInt("${paginationInfo.currentPageNo}"),
			visiblePages : 5,
			first : null,
			last : null,
			prev : '<', 
			next: '>',
			initiateStartPageClick : false,
			onPageClick : function(event, page) {
				/* 재조회 함수 실행 */
				fn_egov_link_page(page);
			}
		});
	</script>
	

	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>