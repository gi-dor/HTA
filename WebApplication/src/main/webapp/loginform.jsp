<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initail-scale=1">
    <title>bootstrap</title>
    <!-- CDN으로 포함시키기 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%--<%@include file="include/navbar.jsp" %>--%>
<jsp:include page="include/navbar.jsp">
    <jsp:param name="menu" value="login"/>
</jsp:include>

<div class="container">
    <div class="row">
        <div class="col-12">
            <h1> 로그인 폼</h1>

            <%
                /*
                요청 URL
                    로그인 메뉴를 클릭 해서 요청할 때
                        localhost/loginform.jsp
                    로그인 실패로 재요청 할 때
                        localhost/loginform.jsp?error=xxxx
                 요청 파라미터
                    error=xxxx
                        + error 요청 파라미터는 로그인요청이 실패 했을 때 login.jsp가 응답으로 보내는 재요청 URL에 포함되어 있다,
                */

                // 1. 요청 파라미터 조회
                String error = request.getParameter("error");
            %>

            <%
                if ("fail".equals(error)) {
            %>
            <div class="alert alert-danger">
                <strong>로그인 실패</strong> , 아이디 혹은 비밀번호가 일치 하지 않습니다.
            </div>
            <%
            } else if ("deleted".equals(error)) {
            %>
            <div class="alert alert-danger">
                <strong>로그인 실패</strong> , 탈퇴 처리된 사용자 아이디 입니다.
            </div>
            <%
            } else if ("deny".equals(error)) {
            %>
            <div class="alert alert-danger">
                <strong>로그인 필수</strong> , 로그인이 필요한 요청 입니다.
            </div>
            <%
                }
            %>


            <form class="border bg-light p-3 " method="post" action="login.jsp" onsubmit="checkForm(event)">
                <div class="form-group mb-3">
                    <label class="form-label">Id</label>
                    <input type="text" class="form-control" name="id"/>
                </div>
                <div class="form-group mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password"/>
                </div>
                <div class="text-end">
                    <a href="registerform.jsp" class="btn btn-secondary">Register</a>
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
    </div>

</div>
<script type="text/javascript">

    // 매개변수 event는 ,키보드 , 마우스 , 여러 이벤트를 담당한다고 한다
    function checkForm(event) {
        // 1. 아이디 , 비밀번호 입력필드 엘리먼트를 조회한다
        // querySelector 는 CSS선택자를 사용해 엘리먼트를 찾는다
        let idInput = document.querySelector("input[name=id]");
        let passwordInput = document.querySelector("input[name=password]");

        // 2. 아이디 , 비밀번호 입력필드의 값 조회
        let id = idInput.value.trim();
        let pw = passwordInput.value.trim();


        // event.preventDefault() 사용시 submit 이벤트시 action에있는 페이지로 이동하지 않게 해준다.
        // 3. 아이디 , 비밀번호 값을 체크
        if (id === "") {
            alert("아이디를 입력하세요");
            event.preventDefault();
            return;
        }

        if (pw === "") {
            alert("비밀번호를 입력하세요");
            event.preventDefault();
            return;
        }
    }


</script>

</body>
</html>