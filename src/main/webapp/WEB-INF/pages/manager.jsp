<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/16
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>饭店后台-努力工作 (ง •̀o•́)ง </title>
    <link rel="stylesheet" href="../css/bootstrap.css" type="text/css">
    <%--    哀悼模式--%>
<%--<style>

        html{

            filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);

            filter: grayscale(100%);

            -webkit-filter: grayscale(100%);

            -moz-filter: grayscale(100%);

            -o-filter: grayscale(100%);

        }

    </style>--%>

    <STYLE type="text/css">
        .outer-container {
            position: relative;
            overflow: hidden;
        }
        .margintop{
            margin-top:50px;
            background-color: #3c3c3c;
        }
        .name{
            height: 50px;
            color: whitesmoke;
            text-align: center;
            line-height: 50px;
        }
        .left{
            height: 85%;

        }
        .right{
            background-color: whitesmoke;
        }
        .leftmore{
            float: left;
            margin-left: -14px;
        }
    </STYLE>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script>
        pushHistory();//改变url，使浏览器无法返回
        document.addEventListener('visibilitychange', function() {
            var isHidden = document.hidden;
            console.log(document.visibilityState)
            if (isHidden) {
                document.title = '饭店后台-休息一下⁄(⁄ ⁄ ⁄ω⁄ ⁄ ⁄)⁄';
            } else {
                document.title = '饭店后台-努力工作 (ง •̀o•́)ง ';
            }
        });
        var lastTime = new Date().getTime();
        var currentTime = new Date().getTime();
        var timeOut =30 * 60 * 1000; //设置超时时间： 30分
        var outted=false;
        $(function(){
            $(document).click(function(){
                $.ajax({
                    url:'../user/checksession',
                    datatype : "json",
                    type : "post",
                    success:function (res) {
                        if(res==false){
                            alert("登录超时，请重新登录！");
                            window.location.href ='../index.jsp';
                        }
                    }
                })
            });
            /* 鼠标移动事件 */
            $(document).mousemove(function(){
                lastTime = new Date().getTime(); //更新操作时间
            });
            $(".sidebar li").on("click",function(){
                var address =$(this).attr("data-src");
                $("#iframecontext").attr("src",address);
            });
            $("#tittle").popover();
            $('#myModal').on('shown.bs.modal', function () {
                $('#myInput').focus()
            });
            $("#exitlink").click(function () {
                window.location.href ='../index.jsp';
            })
        });
        function testTime(){
            currentTime = new Date().getTime(); //更新当前时间
            if(currentTime - lastTime > timeOut&&outted==false){ //判断是否超时
                outted=true;
                $.ajax({
                    url:'../user/deletesession',
                    datatype : "json",
                    type : "post",
                    success:function (res) {

                    }
                })
            }
        }
        /* 定时器  间隔1秒检测是否长时间未操作页面  */
        window.setInterval(testTime, 1000);

        function pushHistory() {
            var state = {
                title: "title",
                url: "%&ounweocnw*8698cnw%"
            };
            window.history.pushState(state, "title", "%&ounweocnw*8698cnw%");
        }
    </script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">联系方式</h4>
            </div>
            <div class="modal-body outer-container">
                <iframe marginWidth=0 marginHeight=0 src="../user/findAll2"  scrolling="auto" frameBorder=0 width="100%" height="50%"></iframe>
            </div>
        </div>
    </div>
</div>
<%--顶部导航栏--%>
<nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a id="tittle" class="navbar-brand" href="#" data-toggle="modal" data-target="#myModal"
               role="button" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-animation="true"
               data-content="点击显示联系方式">饭店点菜系统管理后台</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <c:forEach items="${userrolelist}" var="ur"><a class="name">您好：${ur.username}${ur.roles[0].rolename}</a></c:forEach>
            <ul class="nav navbar-nav navbar-right">
                <li><img src="../images/switch.png"  id="exitlink"  style="margin-top:10px;width: 30px;height: 30px"/></li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="暂未开通">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid margintop" >
    <div class="row">
        <!-- 左侧导航 -->
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar left">
                <c:forEach items="${userrolelist}" var="ur">
                    <h5></h5><br/>
                    <c:choose>
                        <c:when test="${ur.roles[0].rolename=='管理员'}">
                            <li data-src="../order/findAll" ><a href="#">订单列表</a></li>
                            <li data-src="../book/findAll" ><a href="#">预约列表</a></li>
                            <li data-src="../odview/findAll?role=服务员"><a href="#">上菜列表</a></li>
                            <li data-src="../table/findAll"><a href="#">餐桌列表</a></li>
                            <li data-src="../menu/findAll"><a href="#">菜单列表</a></li>
                            <li data-src="../coupon/findAll"><a href="#">优惠券列表</a></li>
                            <li data-src="../user/findAll"><a href="#">用户列表</a></li>
                            <li data-src="../picture/findAll"><a href="#">轮播图列表</a></li>
                            <li data-src="../chart/findAll"><a href="#">图表列表</a></li>
                        </c:when>
                        <c:when test="${ur.roles[0].rolename=='服务员'}">
                            <li data-src="../order/findAll" ><a href="#">订单列表</a></li>
                            <li data-src="../book/findAll" ><a href="#">预约列表</a></li>
                            <li data-src="../odview/findAll?role=服务员"><a href="#">上菜列表</a></li>
                            <li data-src="../table/findAll"><a href="#">餐桌列表</a></li>
                        </c:when>
                        <c:otherwise>
                            <li data-src="../odview/findAll?role=后厨"><a href="#">上菜列表</a></li>
                            <li data-src="../menu/findAll"><a href="#">菜单列表</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
<%--        右侧内容--%>
        <div class="col-sm-9 col-md-10 outer-container right"><iframe class="leftmore" id="iframecontext" marginWidth=0 marginHeight=0 src=""  scrolling="auto" frameBorder=0 width="103%" height="92%"></iframe></div>
    </div>
</div>
</body>
</html>
