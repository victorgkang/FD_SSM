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
    <title>userlist</title>
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
            margin-top: -30px;
        }
    </style>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script>
        $(function () {
            $("#tmbtn").click(function () {
                $.ajax({
                    url : "../userrole/saveUserRole",
                    datatype : "json",
                    data:{
                        roleid:$("#roleid").val(),
                        userid:$("#userid").val()
                    },
                    type : "post",
                    success : function (data) {
                        if(data){
                            alert("授权成功");
                            return ture;
                        }
                    }
                })
            })
        })
    </script>
</head>
<body class="inner-container">
<div class="table-responsive">
    <table class="table-responsive">
        <tr>
            <td>角色授权：</td>
            <td><select name="roleid" id="roleid" class="form-control maxwidth">
                <c:forEach items="${rolelist}" var="role">
                    <option value=${role.roleid}>${role.rolename}</option>
                </c:forEach>
            </select></td>
            <td>+</td>
            <td><select name="userid" id="userid" class="form-control maxwidth">
                <c:forEach items="${userlist.list}" var="user">
                    <option value=${user.userid}>${user.username}</option>
                </c:forEach>
            </select></td>
            <td><button id="tmbtn" type="button" class="btn btn-success">授权</button></td>
        </tr>
    </table>
    <table class="table table-striped table-bordered table-hover">
        <thead>
        <tr>
            <td >用户id</td>
            <td>用户名</td>
            <td>手机号</td>
            <td>密码</td>
            <td>创建时间</td>
            <td>更新时间</td>
            <td>职位</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userlist.list}" var="user">
            <tr>
                <td title="${user.userid}">${user.userid}</td>
                <td title="${user.username}">${user.username}</td>
                <td title="${user.phone}">${user.phone}</td>
                <td title="${user.password}">${user.password}</td>
                <td title="${user.createtime}">${user.createtime}</td>
                <td title="${user.updatetime}">${user.updatetime}</td>
                <td title="${user.job}">${user.job}</td>
                <td>
                    <a href="../user/toupdateUser?userid=1" class="btn btn-primary">新增</a><br/>
                    <a href="../user/toupdateUser?userid=${user.userid}" class="btn btn-warning">修改</a><br/>
                    <a href="../user/deleteUser?userid=${user.userid}"class="btn btn-danger">删除</a><br/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <%--    分页条--%>
    <nav aria-label="Page navigation" class="right">
        <ul class="pagination">
            <c:choose>
                <c:when test="${userlist.isFirstPage}">
                    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="../user/findAll?num=${userlist.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
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
                        <li><a href="../user/findAll?num=${num}">${num}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${userlist.isLastPage}">
                    <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="../user/findAll?num=${userlist.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
</div>
</body>
</html>