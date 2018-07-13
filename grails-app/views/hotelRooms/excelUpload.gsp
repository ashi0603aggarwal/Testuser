<%--
  Created by IntelliJ IDEA.
  User: ROMI
  Date: 5/28/2018
  Time: 9:45 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>
<g:form action="processUpload" method="post" enctype="multipart/form-data">
    <input type="file" name="hotelRoomsFile" id="hotelRoomsFile" />
    <button type="submit" >Upload</button>
</g:form>
</body>
</html>