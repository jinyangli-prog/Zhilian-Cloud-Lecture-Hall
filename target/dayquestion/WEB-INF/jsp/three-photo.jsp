<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2024/11/17
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:forEach items="${photos}" var="photo">
    <img src="${photo.uphoto}">
</c:forEach>
</body>
</html>
