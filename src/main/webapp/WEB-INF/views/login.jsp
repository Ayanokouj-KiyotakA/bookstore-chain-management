<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="header.jsp" />

<h2>Dang nhap</h2>
<form method="post" action="${pageContext.request.contextPath}/login">
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="text" name="username" class="form-control" />
    </div>
    <div class="mb-3">
        <label class="form-label">Mat khau</label>
        <input type="password" name="password" class="form-control" />
    </div>
    <button type="submit" class="btn btn-primary">Dang nhap</button>
</form>

<jsp:include page="footer.jsp" />
