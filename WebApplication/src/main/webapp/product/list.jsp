<%@page import="utils.DateUtils" %>
<%@page import="vo.Product" %>
<%@page import="java.util.List" %>
<%@page import="dao.ProductDao" %>
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
</head>
<body>
<jsp:include page="../include/navbar.jsp">
    <jsp:param value="product" name="menu"/>
</jsp:include>
<div class="container">
    <div class="row">
        <div class="col-12">
            <h1>상품 목록</h1>


            <%
                ProductDao productDao = new ProductDao();
                // 전체 상품목록 조회
                List<Product> productList = productDao.getAllProducts();


            %>
            <table class="table">
                <colgroup>
                    <col width="10%">
                    <col width="*">
                    <col width="15%">
                    <col width="15%">
                    <col width="15%">
                    <col width="15%">
                </colgroup>
                <thead>


                <tr>
                    <th>번호</th>
                    <th>상품명</th>
                    <th>제조사</th>
                    <th>가격</th>
                    <th>상태</th>
                    <th>등록일</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Product p : productList) {
                %>
                <tr>
                    <th><%=p.getNo() %>
                    </th>
                    <th><a href="detail.jsp?no=<%=p.getNo()%>"><%=p.getName() %>
                    </a></th>
                    <th><%=p.getCompany().getName() %>
                    </th>
                    <th><%=p.getPrice() %>
                    </th>
                    <th><%=p.getStatus().getName() %>
                    </th>
                    <th><%=DateUtils.toText(p.getCreatedDate()) %>
                    </th>
                </tr>
                <%
                    }
                %>

                </tbody>
            </table>

            <div class="text-end">
                <a href="form.jsp" class="btn btn-dark">새 상품 등록</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>