<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/13
  Time: 18:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Chart</title>
    <link rel="stylesheet" href="../css/bootstrap.css" type="text/css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../js/echarts.js"></script>
    <style>
        body{
            background-color:whitesmoke;
        }
    </style>
</head>
<body>
<!-- 导航区 -->

<ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#home" role="tab" data-toggle="tab" id="sell">月销售情况</a></li>
    <li role="presentation"><a href="#profile" role="tab" data-toggle="tab" id="peoplenum">日流量情况</a></li>
    <li role="presentation"><a href="#messages" role="tab" data-toggle="tab" id="money">销售额情况</a></li>
    <li role="presentation"><a href="#settings" role="tab" data-toggle="tab" id="newfood">新菜欢迎度</a></li>
    <li role="presentation"><a href="#ypn" role="tab" data-toggle="tab" id="ypeoplenum">年客流量情况</a></li>
    <li role="presentation"><a href="#tocouponnum" role="tab" data-toggle="tab" id="couponnum">优惠券使用情况</a></li>
</ul>

<!-- 面板区 -->
<div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home" >
        <div id="sell-main" style="width: 800px;height:400px;"></div>
    </div>
    <div role="tabpanel" class="tab-pane" id="profile" >
        <div id="people-main" style="width: 800px;height:400px;"></div>
    </div>
    <div role="tabpanel" class="tab-pane" id="messages" >
        <div id="money-main" style="width: 900px;height:400px;"></div>
    </div>
    <div role="tabpanel" class="tab-pane" id="settings">
        <div id="food-main" style="width: 800px;height:400px;"></div>
    </div>
    <div role="tabpanel" class="tab-pane" id="ypn">
        <div id="ypn-main" style="width: 800px;height:400px;"></div>
    </div>
    <div role="tabpanel" class="tab-pane" id="tocouponnum">
        <div id="couponnum-main" style="width: 800px;height:400px;"></div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        initsellData();
        $("#sell").click(function () {
            initsellData();
        });
        $("#peoplenum").click(function () {
            initpeoplenumData();
        })
        $("#money").click(function () {
            initmoneyData();
        })
        $("#newfood").click(function () {
            initnewfood();
        });
        $("#ypeoplenum").click(function () {
            initypeoplenum();
        })
        $("#couponnum").click(function () {
            initcouponnum();
        })
    });

    function initsellData() {
    var myChart = echarts.init(document.getElementById('sell-main'));
    var option = {
        title: {
            text: '菜品月销数量统计',
            subtext: '数据库统计',
            left: 'center'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
            type: 'scroll',
            orient: 'vertical',
            right: 10,
            top: 20,
            bottom: 20,
            data: [],
            selected:{},
        },
        series: [
            {
                name: '菜名',
                type: 'pie',
                radius: '55%',
                center: ['40%', '50%'],
                data: [],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };
        $.ajax({
            url : "../menu/countsellnum",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                var selecteds={}
                for (var i = 0; i<data.length; i++) {
                    option.series[0].data.push({value:data[i].num,name:data[i].name});
                    option.legend.data.push(data[i].name);
                        selecteds[data[i].name]=i<6;
                }
                option.legend.selected=selecteds
            }})
        //上面执行完后再执行
    myChart.setOption(option);}
    function initpeoplenumData() {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('people-main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '日客流量统计',
                subtext: '数据库统计'
            },
            tooltip: {},
            legend: {
                data:['日期']
            },
            xAxis: {
                type: 'category',
                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00',
                        '06:00', '07:00', '08:00', '09:00', '10:00', '11:00',
                        '12:00', '13:00', '14:00', '15:00', '16:00', '17:00',
                        '18:00', '19:00', '20:00', '21:00', '22:00', '23:00']
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [],
                type: 'line'
            }]
        };
        $.ajax({
            url : "../order/countpeoplenum",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                for(var i=0;i<24;i++){
                    var have=false;
                    for(var y=0;y<data.length;y++){
                        if(data[y].time==i){
                            option.series[0].data.push(data[y].num);
                            have=true;
                        }
                    }if (have == false) {
                        option.series[0].data.push(0)
                    }
                }
            }})
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function initmoneyData() {
        var myChart = echarts.init(document.getElementById('money-main'));
        var option = {
            title: {
                text: '销售额情况',
                subtext: '数据库统计'
            },
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul','Aug','Sep','Oct','Nov','Dec'],
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '销售额',
                    type: 'bar',
                    barWidth: '60%',
                    data: [],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name : '平均值'}
                        ]
                    }
                }
            ]
        };
        $.ajax({
            url : "../order/countmoney",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                for(var i=1;i<12;i++){
                    var have=false;
                    for(var y=0;y<data.length;y++){
                        if(data[y].time==i){
                            option.series[0].data.push(data[y].num);
                            have=true;
                        }
                    }if (have == false) {
                        option.series[0].data.push(0)
                    }
                }
            }})
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function initnewfood() {
        var myChart = echarts.init(document.getElementById('food-main'));
        var option = {
            title: {
                text: '新菜欢迎度',
                subtext: '数据库统计'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'value'
                }
            ],
            yAxis: [
                {
                    type: 'category',
                    data: [],
                    axisTick: {
                        alignWithLabel: true
                    }

                }
            ],
            series: [
                {
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            //好，这里就是重头戏了，定义一个list，然后根据所以取得不同的值，这样就实现了，
                            color: function(params) {
                                // build a color map as your need.
                                var colorList = [
                                    '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                                    '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                                    '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0',
                                    '#24d7bb','#11e560','#c7c2f4','#f07848','#26d0C0'
                                ];
                                return colorList[params.dataIndex]
                            },

                            //以下为是否显示，显示位置和显示格式的设置了
                            label: {
                                show: true,
                                position: 'top',
                                formatter: '{b}\n{c}'
                            }
                        }
                    },
                    barWidth: '30%',
                    data:[]
                },

            ]
        };

        $.ajax({
            url : "../menu/countnewfood",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                    for(var i=0;i<data.length;i++){
                            option.series[0].data.push(data[i].num);
                            option.yAxis[0].data.push(data[i].name)
                    }
            }})
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    function initypeoplenum() {
        var myChart = echarts.init(document.getElementById('ypn-main'));
        var xData = function() {
            var data = [];
            for (var i = 1; i < 13; i++) {
                data.push(i + "月份");
            }
            return data;
        }();

        var option = {
            backgroundColor: '#f5f5f5',
            "title": {
                "text": "本年度客流量统计",
                "subtext": "数据库统计",
                x: "4%",

                textStyle: {
                    color: '#000',
                    fontSize: '22'
                },
                subtextStyle: {
                    color: '#777e83',
                    fontSize: '16',

                },
            },
            "grid": {
                "borderWidth": 0,
                "top": 110,
                "bottom": 95,
                textStyle: {
                    color: "#fff"
                }
            },
            "calculable": true,
            "xAxis": [{
                "type": "category",
                "axisLine": {
                    lineStyle: {
                        color: '#1e3b54'
                    }
                },
                "splitLine": {
                    "show": false
                },
                "axisTick": {
                    "show": false
                },
                "splitArea": {
                    "show": false
                },
                "axisLabel": {
                    "interval": 0,

                },
                "data": xData,
            }],
            "yAxis": [{
                "type": "value",
                "splitLine": {
                    "show": false
                },
                "axisLine": {
                    lineStyle: {
                        color: '#0f202e'
                    }
                },
                "axisTick": {
                    "show": false
                },
                "axisLabel": {
                    "interval": 0,

                },
                "splitArea": {
                    "show": false
                },

            }],
            "dataZoom": [{
                "show": true,
                "height": 30,
                "xAxisIndex": [
                    0
                ],
                bottom: 30,
                "start": 10,
                "end": 80,
                handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                handleSize: '110%',
                handleStyle:{
                    color:"rgba(49,105,149,0.8)",

                },
                textStyle:{
                    color:"#1e3b54"},
                borderColor:"#90979c"


            }, {
                "type": "inside",
                "show": true,
                "height": 15,
                "start": 1,
                "end": 35
            }],
            "series": [{
                "name": "总数",
                "type": "line",
                symbolSize:10,
                symbol:'circle',
                "itemStyle": {
                    "normal": {
                        "color": "rgb(49,105,149)",
                        "barBorderRadius": 0,
                        "label": {
                            "show": true,
                            "position": "top",
                            formatter: function(p) {
                                return p.value > 0 ? (p.value) : '';
                            }
                        }
                    }
                },
                "data": [],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                        {type : 'min', name: '最小值'}
                    ]
                },
                markLine : {
                    data : [
                        {type : 'average', name : '平均值'}
                    ]
                }
            },
            ]
        }
        $.ajax({
            url : "../order/countypeoplenum",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                for(var i=1;i<13;i++){
                    var have=false;
                    for(var y=0;y<data.length;y++){
                        if(data[y].month==i){
                            option.series[0].data.push(data[y].num);
                            have=true;
                        }
                    }if (have == false) {
                        option.series[0].data.push(0)
                    }
                }
            }})
        myChart.setOption(option);
    }
    function initcouponnum() {
        var myChart = echarts.init(document.getElementById('couponnum-main'));
        var option = {
            backgroundColor: "#f5f5f5",
            "title": {
                "text": "优惠券派发情况统计",
                "subtext": "数据库统计",
                x: "4%",

                textStyle: {
                    color: '#000000',
                    fontSize: '22'
                },
                subtextStyle: {
                    color: '#90979c',
                    fontSize: '16',

                },
            },
            "tooltip": {
                "trigger": "axis",
                "axisPointer": {
                    "type": "shadow",
                    textStyle: {
                        color: "#fff"
                    }

                },
            },
            "grid": {
                "borderWidth": 0,
                "top": 110,
                "bottom": 95,
                textStyle: {
                    color: "#fff"
                }
            },
            "legend": {
                x: '4%',
                top: '14%',
                textStyle: {
                    color: '#90979c',
                },
                "data": ['已使用', '待使用', '失效','派发']
            },


            "calculable": true,
            "xAxis": [{
                "type": "category",
                "axisLine": {
                    lineStyle: {
                        color: '#0f202e'
                    }
                },
                "splitLine": {
                    "show": false
                },
                "axisTick": {
                    "show": false
                },
                "splitArea": {
                    "show": false
                },
                "axisLabel": {
                    "interval": 0,

                },
                "data": [],
            }],
            "yAxis": [{
                "type": "value",
                "splitLine": {
                    "show": false
                },
                "axisLine": {
                    lineStyle: {
                        color: '#0f202e'
                    }
                },
                "axisTick": {
                    "show": false
                },
                "axisLabel": {
                    "interval": 0,

                },
                "splitArea": {
                    "show": false
                },

            }],
            "dataZoom": [{
                "show": true,
                "height": 30,
                "xAxisIndex": [
                    0
                ],
                bottom: 30,
                "start": 10,
                "end": 80,
                handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                handleSize: '110%',
                handleStyle:{
                    color:"#b0adb3",

                },
                textStyle:{
                    color:"#316995"},
                borderColor:"#c7c2f4"


            }, {
                "type": "inside",
                "show": true,
                "height": 15,
                "start": 1,
                "end": 35
            }],
            "series": [
                {
                "name": "已使用",
                "type": "bar",
                "stack": "总量",
                "barMaxWidth": 35,
                "barGap": "10%",
                "itemStyle": {
                    "normal": {
                        "color": "rgba(255,144,128,1)",
                        "label": {
                            "show": true,
                            "textStyle": {
                                "color": "#fff"
                            },
                            "position": "inside",
                            formatter: function(p) {
                                return p.value > 0 ? (p.value) : '';
                            }
                        }
                    }
                },
                "data": [],
                markPoint : {
                    data : [
                        {type : 'max', name: '最大值'},
                    ]
                },
            },
                {
                    "name": "待使用",
                    "type": "bar",
                    "stack": "总量",
                    "itemStyle": {
                        "normal": {
                            "color": "rgba(0,191,183,1)",
                            "barBorderRadius": 0,
                            "label": {
                                "show": true,
                                "position": "inside",
                                formatter: function(p) {
                                    return p.value > 0 ? (p.value) : '';
                                }
                            }
                        }
                    },
                    "data": []
                },
                {
                    "name": "失效",
                    "type": "bar",
                    "stack": "总量",
                    "itemStyle": {
                        "normal": {
                            "color": "rgb(98,98,98)",
                            "barBorderRadius": 0,
                            "label": {
                                "show": true,
                                "position": "inside",
                                formatter: function(p) {
                                    return p.value > 0 ? (p.value) : '';
                                }
                            }
                        }
                    },
                    "data": [],

                },
                {
                    "name": "派发",
                    "type": "line",
                    symbolSize:10,
                    symbol:'circle',
                    "itemStyle": {
                        "normal": {
                            "color": "rgb(156,14,7)",
                            "barBorderRadius": 0,
                            "label": {
                                "show": true,
                                "position": "top",
                                formatter: function(p) {
                                    return p.value > 0 ? (p.value) : '';
                                }
                            }
                        }
                    },
                    "data": [],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                        ]
                    },
                },
            ]
        }
        $.ajax({
            url : "../coupon/CountCoupon",
            datatype : "json",
            type : "post",
            async:false,//同步
            success : function(data) {
                for (var i = 0; i < data.length;i++){
                    option.xAxis[0].data.push(data[i].name)
                    option.series[0].data.push(data[i].used);
                    option.series[1].data.push(data[i].beuse);
                    option.series[2].data.push(data[i].over);
                    option.series[3].data.push(data[i].total);
                }
            }
        })
        myChart.setOption(option);
    }
</script>
</html>
