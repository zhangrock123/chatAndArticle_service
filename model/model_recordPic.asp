<% 
    ' ../conn/conn.asp
%>
<%
    ' 获取某个日志的图片信息
    function model_getRecordPicsRsById(recordId)
        model_getRecordPicsRsByIdSql="SELECT rep_pic as picUrl, rep_id as picId "&_
        "FROM recordpic WHERE rep_recordId="&recordId
        set model_getRecordPicsRsById =cn.execute(model_getRecordPicsRsByIdSql)
    end function

    ' 为某个日志添加相应的图片信息
    function model_createRecordPics(recordId, picsArr)
        set model_createRecordPicsRs=server.createobject("adodb.recordset")
        model_createRecordPicsSql = "SELECT * FROM recordpic"
        model_createRecordPicsRs.open model_createRecordPicsSql,cn,1,3
        for i=0 to ubound(picsArr)-1
            model_createRecordPicsRs.addnew  
            model_createRecordPicsRs("rep_recordId")=recordId
            model_createRecordPicsRs("rep_pic")=picsArr(i)
            model_createRecordPicsRs.update  
        next
    end function

    ' 根据日志id，删除某个日志下面的图片信息
    function model_deleteRecordPicsGroupsById(recordId)
        model_deleteRecordPicsGroupsByIdSql="DELETE * FROM recordpic WHERE rep_recordId="&recordId
        cn.execute(model_deleteRecordPicsGroupsByIdSql)
    end function

    ' 根据图片id，删除一系列图片信息
    function model_deleteRecordPicItemsByIds(idArr)
        model_deleteRecordPicItemsByIds_idStr=""
        for i=0 to ubound(idArr)-1
            model_deleteRecordPicItemsByIds_idStr=model_deleteRecordPicItemsByIds_idStr&idArr&","
        next
        model_deleteRecordPicItemsByIds_idStr=left(model_deleteRecordPicItemsByIds_idStr,len(model_deleteRecordPicItemsByIds_idStr)-1)

        model_deleteRecordPicItemsByIdsSql="DELETE * FROM recordpic WHERE rep_id in ("&model_deleteRecordPicItemsByIds_idStr&")"
        cn.execute(model_deleteRecordPicItemsByIdsSql)
    end function
%>