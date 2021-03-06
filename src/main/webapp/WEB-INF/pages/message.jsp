<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/20
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>message</title>
    <link rel="stylesheet" href="../css/bootstrap.css" type="text/css">
    <style>
        body{
            background-color: whitesmoke;
        }
        table{
            table-layout:fixed;
        }
        td{
            overflow:hidden;
            white-space:nowrap;
            text-overflow:ellipsis;
        }
        .inner-container {
            position: absolute; left: 0;
            overflow-x: hidden;
            overflow-y: scroll;
        }
        /* for Chrome 只针对谷歌浏览器*/
        .inner-container::-webkit-scrollbar {
            display: none;
        }
        .right{
            float: right;
            padding-right: 50px;
        }
        .btnright{
            float: right;
            margin-top: 20px;
            margin-left:40px;
        }
    </style>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script>
        $(function () {
            $("#touserfindAll2").click(function () {
                    $("#touserfindAll2").attr("href","../user/findAll2?num=1&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
            });
            $("#front").click(function () {
                $("#front").attr("href","../user/findAll2?num=${userlist.prePage}&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
            });
            $("#first").click(function () {
                $("#first").attr("href","../user/findAll2?num=1&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
            });
            $("#last").click(function () {
                $("#last").attr("href","../user/findAll2?num=${userlist.pages}&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
            });
            $("#next").click(function () {
                $("#next").attr("href","../user/findAll2?num=${userlist.nextPage}&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
            });
        });
        function gonum(num) {
            $(".aurlcenter").attr("href","../user/findAll2?num="+num+"&&ujob="+$("#ujob").val()+"&&uname="+$("#uname").val()+"&&uphone="+$("#uphone").val()+"")
        }
    </script>

</head>
<body class="inner-container">
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <td>职务</td>
            <td>姓名</td>
            <td>电话</td>
        </tr>
        <tr>
            <td><input class="form-control" placeholder="输入职务查询"  id="ujob" value="${ujob}"></td>
            <td><input class="form-control" placeholder="输入姓名查询"  id="uname" value="${uname}"></td>
            <td><input class="form-control" placeholder="输入电话查询"  id="uphone" value="${uphone}"></td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userlist.list}" var="user">
            <tr>
                <td title="${user.job}">${user.job}</td>
                <td title="${user.username}">${user.username}</td>
                <td title="${user.phone}">${user.phone}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <%--    分页条--%>
 第${userlist.pageNum}页，共${userlist.pages}页/${userlist.total}条
    <nav aria-label="Page navigation" class="right">
        <ul class="pagination">
            <c:choose>
                <c:when test="${userlist.isFirstPage}">
                    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">首</span></a></li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="" aria-label="Previous" id="front">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li>
                        <a href="" aria-label="Previous" id="first">
                            <span aria-hidden="true">首</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
            <c:forEach items="${userlist.navigatepageNums}" var="num">
                <c:choose>
                    <c:when test="${num==userlist.pageNum}">
                        <li class="active">
                            <span>${num}<span class="sr-only">(current)</span></span>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="" class="aurlcenter" onclick='gonum("${num}")'>${num}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${userlist.isLastPage}">
                    <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">尾</span></a></li>
                    <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="" aria-label="Next" id="last">
                            <span aria-hidden="true">尾</span>
                        </a>
                    </li>
                    <li>
                        <a href="" aria-label="Next" id="next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
        <a href="" id="touserfindAll2" class="btn btn-info btnright">搜索</a>
    </nav>
</div>
</body>
</html>

