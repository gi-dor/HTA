<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initail-scale=1">
    <title></title>
    <!-- CDN으로 포함시키기 -->
    <!-- 부트스트랩 CSS와 JavaScript 라이브러리  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- jQuery 라이브러리  -->
    <script src="jquery-3.7.1.min.js"></script>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
    <jsp:param value="home" name="menu"/>
</jsp:include>


<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="alert alert-danger mt-5">
                <h1 class=mt-3> 5xx 서버오류</h1>
                <p>요청을 처리하는 도중 서버에게 오류가 발생했습니다</p>
                <p>잠시 기다린 후 다시 시도해 주시기 바랍니다</p>
            </div>
        </div>
    </div>
</div>


</body>
</html>