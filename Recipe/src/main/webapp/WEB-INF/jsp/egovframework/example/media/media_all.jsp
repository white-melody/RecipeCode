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
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<!-- AOS CSS -->
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

<!-- 	개발자 css -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/exstyle.css">
<link rel="stylesheet" href="/css/all.css">
</head>
<body>
	<!-- 머리말 -->
	<jsp:include page="/common/header.jsp" />

<input type="hidden" id="uuid" value="${mediaVO.uuid}" />

	<form id="listForm" method="get">
		<input type="hidden" name="pageIndex" id="pageIndex" value="1" />
	</form>

	<!-- 본문 -->
	<!-- 배너 -->
   <div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide" style="
          background-image: url('<c:url value="/images/media/christmas.jpg"/>');
        background-size: cover; background-position: center;">
        <div class="overlay"></div>
        <div class="title" data-swiper-parallax="-300">영화</div>
        <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
        <div class="text" data-swiper-parallax="-100">
          <p>
           영화 속 감성을 담은 레시피를 준비했어요.
          </p>
        </div>
      </div>
      <div class="swiper-slide" style="
          background-image: url('<c:url value="/images/media/springroll.jpg"/>');
        background-size: cover; background-position: center;">
        <div class="overlay"></div>
        <div class="title" data-swiper-parallax="-300">드라마</div>
        <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
        <div class="text" data-swiper-parallax="-100">
          <p>
            드라마를 주제로 한 요리 모음입니다. 맛있는 드라마 요리를 만나보세요.
          </p>
        </div>
      </div>
      <div class="swiper-slide" style="
          background-image: url('<c:url value="/images/media/pretzels.jpg"/>');
        background-size: cover; background-position: center;">
        <div class="overlay"></div>
        <div class="title" data-swiper-parallax="-300">게임</div>
        <div class="subtitle" data-swiper-parallax="-200">Subtitle</div>
        <div class="text" data-swiper-parallax="-100">
          <p>
           게임 속 음식들을 현실에서 즐겨보세요.
          </p>
        </div>
      </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
  </div>

<!-- 이미지 -->
	<div class="magazine my-4">
		<div class="magazine-list row g-0">
			<c:forEach var="data" items="${all}" varStatus="status">
			<c:set var="direction" value="${status.index % 2 == 0 ? 'fade-right' : 'fade-left'}" />
				<div class="col-md-6 col-lg-4" data-aos="${direction}" data-aos-delay="${status.index * 100}">
					<a href="<c:out value='/media/open.do?uuid=${data.uuid}'/>"
						class="text-decoration-none text-dark">
						<div class="magazine-card">
							<img
								src="${data.recipeImageUrl != null ? data.recipeImageUrl : '/images/default.jpg'}"
								class="magazine-img" alt="이미지">
							<div class="magazine-content">
								<h3 class="magazine-title">
									<c:out value="${data.title}" />
								</h3>
								<div class="likeCount">
									❤️
									<c:out value="${data.likeCount}" />
								</div>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 페이지네이션 -->
	<div class="d-flex justify-content-center mt-3">
		<nav aria-label="Page navigation example">
			<ul class="pagination" id="pagination">
			</ul>
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
			$("#listForm").attr("action", '<c:out value="/media/media.do" />')
					.submit();
		}
		/* 전체조회 */
		function fn_egov_selectList() {
			$("#pageIndex").val(1); // 최초 화면에서는 페이지번호를 1페이지로 지정
			$("#listForm").attr("action", '<c:out value="/media/media.do" />')
					.submit();
		}
	</script>

	<script type="text/javascript">
		/* 페이징 처리 */
		$('#pagination').twbsPagination({
			totalPages: ${paginationInfo.totalPageCount != null ? paginationInfo.totalPageCount : 1},
			startPage: ${paginationInfo.currentPageNo != null ? paginationInfo.currentPageNo : 1},
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
	
	<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      speed: 600,
      parallax: true,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  </script>

<!-- AOS JS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<script>
  AOS.init({
    duration: 500,
    easing: 'ease-out',
    once: true
  });
</script>
  


	<!-- 꼬리말 -->
	<jsp:include page="/common/footer.jsp" />
</body>
</html>