<!--#include file="../model/model_record.asp"-->
<!--#include file="../model/model_recordPic.asp"-->
<!--#include file="../model/model_recordType.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    ' 发表新的日志
    function createNewRecord(customerId, typeId, title, content, picsArr)
        newRecordId=model_createRecordAndGetId(customerId, typeId, title, content)
        if ubound(picsArr) >= 0 then
            call model_createRecordPics(newRecordId, picsArr)
        end if
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 删除某个日志
    function deleteRecord(recordId, customerId)
        call tool_checkIsMyRecord(recordId, customerId)
        call model_setRecordStatus(recordId, 2)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 获取日志列表
    function getRecordList(limit, page, customerId, typeId, status, keyword, startTimeStamp, endTimeStamp)
        getRecordListSql=model_getRecordListSqlByConditions(customerId, typeId, status, keyword, startTimeStamp, endTimeStamp)
        columnList=array("recordId","title","content","createTime","status","typeName","typeId","userName","userPhoto","userEmail")
        call getRSJsonData(getRecordListSql,cn,limit,page,columnList,charSet,false,10)
    end function

    ' 获取日志详情
    function getRecordDetail(recordId, customerId)
        call tool_checkIsMyRecord(recordId, customerId)
        set getRecordDetailRs=model_getRecordDetailRsById(recordId)
        set getRecordPicsRs=model_getRecordPicsRsById(recordId)
        getRecordDetailRs_columnList=array("recordId","title","content","createTime","status","typeName","typeId","userName","userPhoto","userEmail")
        getRecordPicsRs_columnList=array("picUrl","picId")
        getRecordPicsRs_keyName="pics"
        call getJSONMainDataSpecial(getRecordDetailRs,getRecordDetailRs_columnList,getRecordPicsRs_keyName,getRecordPicsRs,getRecordPicsRs_columnList,charSet)
    end function

    ' 获取日志类型列表
    function getRecordTypeList(customerId)
        set getRecordTypeRs=model_getRecordTypeRs(customerId)
        columnList=array("typeId","typeName","typeStatus")
        call getJSONListData(getRecordTypeRs, columnList, charSet)
    end function

    ' 创建日志类型
    function createRecordTypeName(customerId, name)
        call tool_checkIsExistSameRecordTypeName(customerId, name)
        call model_createRecordType(customerId, name)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 编辑日志类型名称
    function updateRecordTypeName(typeId, customerId, name)
        call tool_checkIsMyRecordType(typeId, customerId)
        call model_updateRecordType(typeId, name)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 删除某个日志类型名称
    function deleteRecordTypeName(typeId, customerId)
        call tool_checkIsMyRecordType(typeId, customerId)
        call model_deleteRecordType(typeId)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function
%>
<%
    ' 检查是否是某个用户自己的日志文章
    function tool_checkIsMyRecord(recordId, customerId)
        isMyRecord=model_isMyRecord(recordId, customerId)
        if isMyRecord=false then
            call getCustomJSONErrData("9020","没有权限查看日志",charSet)
            response.end
        end if
    end function

    ' 检查是否是某个用户自己的日志文章的类型
    function tool_checkIsMyRecordType(typeId, customerId)
        isMyRecordType = model_isMyRecordType(typeId, customerId)
        if isMyRecordType=false then
            call getCustomJSONErrData("9021","没有权限操作日志类型",charSet)
            response.end
        end if
    end function

    ' 检查某个用户下面是否存在相同的日志文章类型名称
    function tool_checkIsExistSameRecordTypeName(customerId, name)
        isSameRecordTypeExist = model_isSameRecordTypeExist(customerId, name)
        if isSameRecordTypeExist=true then
            call getCustomJSONErrData("1020","该日志类型已经存在",charSet)
            response.end
        end if
    end function
%>

