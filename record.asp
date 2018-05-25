<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_record.asp"-->

<%
    ' 发表文章
    if action="createRecord" then
        customerToken=request.form("token")
        typeId=request.form("typeId")
        title=request.form("title")
        content=request.form("content")
        picRequestName="pic"

        paramArr=array(customerToken,typeId,title,content)
        errArr=array("token信息为空","类型ID为空","标题为空","内容为空")
        call checkParam(paramArr, errArr)

        if typeId = "0" or typeId=0 then
            call getCustomJSONErrData("1001","类型ID为空",charSet)
            response.end
        end if

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        picCount=request.form(picRequestName).count
        redim picArray(picCount)
        for i=1 to picCount
            picArray(i-1)=request.form(picRequestName)(i)
        next

        call createNewRecord(customerId, typeId, title, content, picArray)
    ' 删除文章
    elseif action="deleteRecord" then
        customerToken=request.form("token")
        recordId=request.form("recordId")

        paramArr=array(customerToken,recordId)
        errArr=array("token信息为空","文章ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

       call deleteRecord(recordId, customerId)
    ' 文章列表
    elseif action="recordList" then
        customerToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")
        typeId=request.queryString("typeId")
        keyword=request.queryString("keyword")
        startTimeStamp=request.queryString("start")
        endTimeStamp=request.queryString("end")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)
        
        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getRecordList(limit, page, customerId, typeId, 1, keyword, startTimeStamp, endTimeStamp)
    ' 文章详情
    elseif action="recordDetail" then
        customerToken=request.queryString("token")
        recordId=request.queryString("recordId")

        paramArr=array(customerToken,recordId)
        errArr=array("token信息为空","文章ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getRecordDetail(recordId, customerId)
    ' 文章类型列表
    elseif action="recordTypeList" then
        customerToken=request.queryString("token")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getRecordTypeList(customerId)
    ' 创建文章类型
    elseif action="createRecordType" then
        customerToken=request.form("token")
        name=request.form("name")

        paramArr=array(customerToken,name)
        errArr=array("token信息为空","文章类型名称为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call createRecordTypeName(customerId, name)
    ' 编辑文章类型
    elseif action="updateRecordType" then
        customerToken=request.form("token")
        typeId=request.form("typeId")        
        name=request.form("name")

        paramArr=array(customerToken,typeId,name)
        errArr=array("token信息为空","类型ID为空","文章类型名称为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call updateRecordTypeName(typeId, customerId, name)
    ' 删除文章类型
    elseif action="deleteRecordType" then
        customerToken=request.form("token")
        typeId=request.form("typeId") 

        paramArr=array(customerToken,typeId)
        errArr=array("token信息为空","类型ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call deleteRecordTypeName(typeId, customerId)
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->