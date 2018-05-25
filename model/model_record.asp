<% 
    ' ../conn/conn.asp
%>
<%
    ' 新增我的日志并且得到新增的纪录的id
    function model_createRecordAndGetId(customerId, typeId, title, content)
        set model_createRecordAndGetIdRs = server.createobject("adodb.recordset")
        model_createRecordAndGetIdSql = "SELECT * FROM record"
        model_createRecordAndGetIdRs.open model_createRecordAndGetIdSql,cn,1,3
        model_createRecordAndGetIdRs.addnew  
        model_createRecordAndGetIdRs("re_customerId") = customerId 
        model_createRecordAndGetIdRs("re_typeId") = typeId
        model_createRecordAndGetIdRs("re_content") = content
        model_createRecordAndGetIdRs("re_title") = title
        model_createRecordAndGetIdRs("re_status") = 1
        model_createRecordAndGetIdRs.update  
        model_createRecordAndGetId = model_createRecordAndGetIdRs("re_id")
    end function
    
    ' 获取我的日志列表（条件：关键字，类型，时间段等）
    function model_getRecordListSqlByConditions(customerId, typeId, status, keyword, startTimeStamp, endTimeStamp)
        if status="" then status=1
        model_getRecordListSqlByConditions_appendStr=""
        if startTimeStamp<>"" and endTimeStamp=""  then
            model_getRecordListSqlByConditions_appendStr=" and r.ch_createStamp >= #"&startTimeStamp&"# "
        elseif startTimeStamp="" and endTimeStamp<>""  then
            model_getRecordListSqlByConditions_appendStr=" and r.ch_createStamp <= #"&endTimeStamp&"# "
        elseif startTimeStamp<>"" and endTimeStamp<>""  then
            model_getRecordListSqlByConditions_appendStr=" and r.ch_createStamp >= #"&startTimeStamp&"# and r.ch_createStamp <= #"&endTimeStamp&"# " 
        end if

        if keyword<> "" then
            model_getRecordListSqlByConditions_appendStr=" and r.re_title like '%"&keyword&"%' or r.re_content like '%"&keyword&"%' "
        end if   

        if typeId <> "" then
            model_getRecordListSqlByConditions_appendStr="and r.re_typeId="&typeId&" "
        end if     

        model_getRecordListSqlByConditions="SELECT r.re_id as recordId, r.re_title as title, r.re_content as content, r.re_createStamp as createTime, r.re_status as status, "&_
        "rt.ret_name as typeName, rt.ret_id as typeId, c.c_name as userName, c.c_phone as userPhoto, c.c_email as userEmail  "&_
        "FROM record r, recordtype rt, customer c "&_
        "WHERE r.re_typeId=rt.ret_id and c.c_id=r.re_customerId and r.re_customerId="&customerId&" and r.re_status="&status&" "&model_getRecordListSqlByConditions_appendStr&_
        "ORDER BY re_id DESC"
    end function

    ' 设置日志的状态（正常或者删除状态）
    function model_setRecordStatus(recordId, status)
        model_setRecordStatusSql="UPDATE record SET re_status="&status&" WHERE re_id="&recordId
        cn.execute(model_setRecordStatusSql)
    end function

    ' 根据日志的id，获取日志的详情
    function model_getRecordDetailRsById(recordId)
        model_getRecordDetailRsByIdSql="SELECT r.re_id as recordId, r.re_title as title, r.re_content as content, r.re_createStamp as createTime, r.re_status as status, "&_
        "rt.ret_name as typeName, rt.ret_id as typeId, c.c_name as userName, c.c_phone as userPhoto, c.c_email as userEmail  "&_
        "FROM record r, recordtype rt, customer c "&_
        "WHERE r.re_typeId=rt.ret_id and c.c_id=r.re_customerId and r.re_id ="&recordId
        set model_getRecordDetailRsById=cn.execute(model_getRecordDetailRsByIdSql)
    end function

    ' 获取某个日志是否属于某人
    function model_isMyRecord(recordId, customerId)
        model_isMyRecordSql="SELECT TOP 1 * FROM record WHERE re_id="&recordId&" and re_customerId="&customerId
        set model_isMyRecordRs=cn.execute(model_isMyRecordSql)
        if model_isMyRecordRs.eof then
            model_isMyRecord=false
        else
            model_isMyRecord=true
        end if
    end function
%>