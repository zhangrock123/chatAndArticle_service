<% 
    ' ../conn/conn.asp
%>
<%
    ' 根据用户id， 获取某个用户含有的可用日志类型列表数据
    function model_getRecordTypeRs(customerId)
        model_getRecordTypeRsSql="SELECT ret_id as typeId, ret_name as typeName, ret_status as typeStatus "&_
        "FROM recordtype "&_
        "WHERE ret_status=1 and ret_customerId="&customerId
        set model_getRecordTypeRs=cn.execute(model_getRecordTypeRsSql)
    end function

    ' 检查某个日志类型是否属于某个用户
    function model_isMyRecordType(typeId, customerId)
        model_isMyRecordTypeSql="SELECT * FROM recordtype WHERE ret_id="&typeId&" and ret_customerId="&customerId
        set model_isMyRecordTypeRs=cn.execute(model_isMyRecordTypeSql)
        if model_isMyRecordTypeRs.eof then
            model_isMyRecordType=false
        else
            model_isMyRecordType=true
        end if
    end function

    ' 创建某人的日志类型
    function model_createRecordType(customerId, name)
        model_createRecordTypeSql="INSERT INTO recordtype (ret_name, ret_customerId, ret_status) "&_
        "VALUES ('"&name&"', "&customerId&", 1)"
        cn.execute(model_createRecordTypeSql)
    end function

    ' 更新某个日志类型的名称
    function model_updateRecordType(typeId, name)
        model_updateRecordTypeSql="UPDATE recordtype SET ret_name='"&name&"' WHERE ret_id="&typeId
        cn.execute(model_updateRecordTypeSql)
    end function

    ' 删除某个日志类型
    function model_deleteRecordType(typeId)
        model_deleteRecordTypeSql="UPDATE recordtype SET ret_status=2 WHERE ret_id="&typeId
        cn.execute(model_deleteRecordTypeSql)
    end function

    ' 检查某人的可用的日志类型列表含有指定的某个名称
    function model_isSameRecordTypeExist(customerId, name)
        model_isSameRecordTypeExistSql="SELECT TOP 1 * FROM recordtype WHERE ret_customerId="&customerId&" and ret_name='"&name&"' and ret_status=1"
        set model_isSameRecordTypeExistRs=cn.execute(model_isSameRecordTypeExistSql)
        if model_isSameRecordTypeExistRs.eof then
            model_isSameRecordTypeExist=false
        else
            model_isSameRecordTypeExist=true
        end if
    end function
%>