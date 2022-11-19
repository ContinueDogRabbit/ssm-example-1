<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>员工页面</title>

    <!--web路径
        不以/开头的相对路径，找资源以当前资源的路径为基准
        以/开头的相对路径，找资源以服务器的路径(http://localhost:3306)为标准,需要加上项目名/crud/.../...
        http://localhost:3306/crud
        但项目名不是写死的,故可以用${pageContext.request.contextPath}-->
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--新增员工模态框-->
<div id="empAddModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="xxx@seu.edu.cn">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="dId" id="dept_add_select">
                                <!--从数据库查-->
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--修改员工模态框-->
<div id="empUpdateModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_staitc"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="xxx@seu.edu.cn">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="dId" id="dept_update_select">
                                <!--从数据库查-->
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="container">
    <!--第一行，标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--第二行，按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除选中</button>
        </div>
    </div>
    <!--第三行，显示表格数据-->
    <div class="row"></div>
    <div class="col-md-12">
        <table class="table" id="emps_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all"/>
                </th>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>departmentName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
            当前 页, 总共 页, 共 条记录
        </div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord;
    //当前页，每次to_page()中调用都会被修改
    var currentPage;
    //页面加载完成后返回第一页的数据
    $(function () {
        //去首页
        to_page(1);
    })

    function build_emps_table(response) {
        $("#check_all").prop("checked", false);
        $("#emps_table tbody").empty();
        var emps = response.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>"));
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender === "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var btnTd = $("<td></td>").append($("<button class=\"btn btn-primary btn-sm edit_btn\"></button>").attr("edit-id", item.empId).append("<span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑")).append($("<button class=\"btn btn-danger btn-sm delete_btn\"></button>").attr("delete-id", item.empId).append("<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>删除"))
            var tr = $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd);
            tr.appendTo("#emps_table tbody");
        })
    }

    //解析显示分页信息
    function bulid_page_info(response) {
        $("#page_info_area").empty();
        currentPage = response.extend.pageInfo.pageNum;
        $("#page_info_area").append("当前" + response.extend.pageInfo.pageNum + "页, 总共" + response.extend.pageInfo.pages + "页, 共" +
            response.extend.pageInfo.total + "条记录");
        totalRecord = response.extend.pageInfo.total;
    }

    /*
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li>
                <a href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li>
            <a href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
            </li>
        </ul>
    </nav>*/
    //解析显示分页条,并且点击分页条会有超链接
    function build_page_nav(response) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append("<span aria-hidden=\"true\">首页</span>");
        var prePageLi = $("<li></li>").append("<span aria-hidden=\"true\">&laquo;</span>");
        if (response.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.on("click", function () {
                to_page(1);
            })
            prePageLi.on("click", function () {
                to_page(response.extend.pageInfo.pageNum - 1);
            })
        }
        var lastPageLi = $("<li></li>").append("<span aria-hidden=\"true\">末页</span>");
        var nextPageLi = $("<li></li>").append("<span aria-hidden=\"true\">&laquo;</span>");
        if (response.extend.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            //不禁用按钮才绑定事件
            nextPageLi.on("click", function () {
                to_page(response.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.on("click", function () {
                to_page(response.extend.pageInfo.pages);
            })
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(response.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append("<a>" + item + "</a>");
            if (response.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.on("click", function () {
                to_page(item);
            });
            ul.append(numLi);
        })
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area")
    }

    //跳转到第几页的ajax请求
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: {"pn": pn},
            data_type: "json",
            success: function (resp) {
                //1.解析并显示员工数据
                build_emps_table(resp);
                //2.解析并显示分页信息
                bulid_page_info(resp);
                build_page_nav(resp);
            }

        })
    }

    /*------------------------------------------------新增员工模块-----------------------------------------------------*/
    //清除表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has_success");//表单下面的所有
        $(ele).find(".help-block").text("");
    }

    //点击按钮弹出模态框
    $("#emp_add_modal_btn").on("click", function () {
        reset_form($("#emp_add_form"));
        getDepts("#dept_add_select");
        $("#empAddModal").modal({
            backdrop: "static"
        })
    })

    //查出所有部门信息并显示在下拉列表中
    function getDepts(ele) {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (resp) {
                $(ele).empty();
                $.each(resp.extend.depts, function () {
                    var deptOpt = $("<option></option>").attr("value", this.deptId).append(this.deptName);
                    $(ele).append(deptOpt);
                })
            }
        })
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清楚当前元素的样式
        $(ele).parent().removeClass("has-success").removeClass("has-error");
        if (status == "success") {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg)
        } else {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验表单数据
    function validate_add_form() {
        //1.拿到要校验的数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        var test1 = regName.test(empName);
        if (!test1) {
            //alert("用户名必须为2-5位中文或者6-13位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名必须为2-5位中文或者6-13位英文和数字的组合");
        } else {
            show_validate_msg("#empName_add_input", "success", "")
        }
        var email = $("#email_add_input").val();
        var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var test2 = regEmail.test(email);
        if (!test2) {
            //alert("邮箱地址不合法!");
            show_validate_msg("#email_add_input", "error", "邮箱地址不合法");
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        if (test1 && test2) {
            return true;
        } else {
            return false;
        }
    }

    //检验用户名是否可用
    $("#empName_add_input").on("change", function () {
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: {
                "empName": this.value
            },
            type: "POST",
            success: function (resp) {
                if (resp.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#empName_add_input").attr("ajax_va", "success");
                } else {
                    //校验失败，从Msg里拿出信息，失败的原因
                    show_validate_msg("#empName_add_input", "error", resp.extend.va_msg);
                    $("#empName_add_input").attr("ajax_va", "fail");
                }
            }
        })
    })
    //保存按钮点击事件，提交表单数据
    $("#emp_save_btn").on("click", function () {
        //1.提交表单数据给服务器,之前先进行校验
        if (!validate_add_form()) {
            return false;
        }
        //判断用户名重复性校验是否成功
        if ($("#empName_add_input").attr("ajax_va") == "fail") {
            show_validate_msg("#empName_add_input", "error", "用户名不可用");
            return false;
        }
        //2.发送ajax请求保存员工
        //console.log($("#emp_add_form").serialize());//empName=1&email=1&gender=M&dId=1
        $.ajax({
            url: "${APP_PATH}/emp",
            data: $("#emp_add_form").serialize(),
            type: "POST",
            success: function (resp) {
                //alert(resp.msg);
                if (resp.code == 100) {
                    //保存成功后，关闭模态框，来到最后一页
                    $("#empAddModal").modal("hide");
                    to_page(totalRecord);
                } else {
                    if (resp.extend.errorFields.email != undefined) {
                        show_validate_msg("#email_add_input", "error", resp.extend.errorFields.email);
                    }
                    if (resp.extend.errorFields.empName != undefined) {
                        show_validate_msg("#empName_add_input", "error", resp.extend.errorFields.empName);
                    }
                }
            }
        })
    })
    /*------------------------------------------------修改员工模块-----------------------------------------------------*/
    //不能$(".edit-btn").click或者$(document).on("click",function (){}）
    //以下创建方式可以使后来加入的元素也绑定事件
    $(document).on("click", ".edit_btn", function () {
        //2.查出部门信息
        getDepts("#dept_update_select")
        //1.查出员工信息
        getEmp($(this).attr("edit-id"));//不能用$(this)[0].attr("edit-id")
        //把编辑按钮上的员工id传给更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //3.弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    })

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            async: false,
            success: function (resp) {
                var empData = resp.extend.emp;
                $("#empName_update_staitc").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                //这里有个bug，下拉框不会正确赋值而是一直选第一个。
                //原因是我们是先查询员工信息再查询部门信息的，交换个位置就行了
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }

    //更新按钮绑定事件
    $("#emp_update_btn").on("click", function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        var test2 = regEmail.test(email);
        if (!test2) {
            show_validate_msg("#email_update_input", "error", "邮箱地址不合法");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求保存更新的数据
        /* 方式一 POST请求带_method参数
        $.ajax({
            url: "

        ${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "POST",
            data: $("#empUpdateModal form").serialize() + "&_method=PUT", //email=6e24d0%40seu.edu.cn&gender=M&dId=1
            success: function (resp) {
                alert(resp.msg);
            }
        })*/
        //方式二 jQuery封装直接发PUT请求
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(), //email=6e24d0%40seu.edu.cn&gender=M&dId=1
            success: function (resp) {
                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        })
    })
    /*------------------------------------------------删除员工模块-----------------------------------------------------*/
    $(document).on("click", ".delete_btn", function () {
        //alert($(this).parents("tr").find("td:eq(1)").text());
        //获取到了该行的第一个<td>内的属性也就是empName
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + empName + "】吗？")) {
            //确认,发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("delete-id"),
                type: "DELETE",
                success: function () {
                    to_page(currentPage);
                }
            })
        }
    })

    //全选按钮绑定事件
    $("#check_all").on("click", function () {
        //attr获取checked是undefined，因为没有定义这个属性
        //获取和修改dom对象原生的属性用prop()
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));
    })
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })
    $("#emp_delete_all_btn").on("click", function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function (index, ele) {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        //去除最后一个逗号 注意substring和substr的区别!!!
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (resp) {
                    alert(resp.msg);
                    to_page(currentPage);
                }
            })
        }
    })

</script>
</body>
</html>
