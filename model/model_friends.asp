<% 
    ' ../conn/conn.asp
%>
<%
    ' requesttip 表字段
    '   rt_status=1 未处理  rt_status＝2 接受  rt_status＝3 拒绝  rt_status＝99 删除
%>
<%
    ' 获取关于某用户的好友信息
    function model_getFriendSqlById(id)
        model_getFriendSqlById="SELECT  f.f_friendId as friendId,c.c_name as friendName, c.c_photo as friendPhoto, c.c_remark as friendRemark, "&_
            "c.c_email as friendEmail, c.c_phone as friendPhone, c.c_status as friendStatus "&_
        "FROM customer c, "&_
            "(SELECT * FROM friends ff WHERE EXISTS( SELECT 1 FROM friends ffq WHERE ffq.f_customerId = ff.f_friendId and ff.f_customerId = ffq.f_friendId)) f "&_
        "WHERE f.f_friendId=c.c_id and f.f_status =1 and f.f_customerId="&id
    end function

    ' 对方是否已经是好友
    function model_getIsFriend(myId, friendId)
        model_getIsFriendSql="SELECT count(*) as friendCount FROM friends WHERE (f_friendId = "&myId&" and f_customerId="&friendId&") or (f_friendId = "&friendId&" and f_customerId="&myId&")"
        set model_getIsFriendRs=cn.execute(model_getIsFriendSql)
        if model_getIsFriendRs.eof then
            model_getIsFriend=false
        else
            if model_getIsFriendRs("friendCount") =2 then
                model_getIsFriend=true
            else
                model_getIsFriend=false
            end if
        end if
    end function

    ' 创建好友
    function model_setFriend(myId, friendId)
        model_setFriendSql="INSERT INTO friends (f_customerId, f_friendId, f_status) VALUES("&myId&","&friendId&", 1)"
        cn.execute(model_setFriendSql)
    end function

    ' 是否发送过好友请求
    function model_getIsSentRequest(myId, friendId)
        model_getIsSentRequestSql="SELECT TOP 1 * FROM requesttip WHERE rt_fromId="&myId&" and rt_toId="&friendId&" and (rt_status=1 or rt_status=2 or rt_status=3)"
        set model_getIsSentRequestRs=cn.execute(model_getIsSentRequestSql)
        if model_getIsSentRequestRs.eof then
            model_getIsSentRequest=false
        else
            model_getIsSentRequest=true
        end if
    end function

    ' 获取我的好友请求数据
    function model_getMySentRequestSqlById(userId)
        model_getMySentRequestSqlById="SELECT r.rt_id as requestId, c.c_id as userId, c.c_name as userName, c.c_photo as userPhoto, "&_
        "c.c_email as userEmail, c.c_phone as userPhone, r.rt_createStamp as requestTime, r.rt_status as status, r.rt_tip as content "&_
        "FROM requesttip r, customer c "&_
        "WHERE r.rt_toId = c.c_id and r.rt_fromId="&userId
    end function

    ' 获取我收到的好友请求
    function model_getMyReceiveRequestSqlId(userId)
        model_getMyReceiveRequestSqlId="SELECT r.rt_id as requestId, c.c_id as userId, c.c_name as userName, c.c_photo as userPhoto, "&_
        "c.c_email as userEmail, c.c_phone as userPhone, r.rt_createStamp as requestTime, r.rt_status as status, r.rt_tip as content "&_
        "FROM requesttip r, customer c "&_
        "WHERE r.rt_fromId = c.c_id and r.rt_toId="&userId
    end function

    ' 发送好友请求
    function model_sendFriendRequest(sendId, toId, tip, status)
        model_sendFriendRequestSql="INSERT INTO requesttip (rt_fromId, rt_toId, rt_tip, rt_status) "&_
        "VALUES("&sendId&","&toId&",'"&tip&"',"&status&")"
        cn.execute(model_sendFriendRequestSql)
    end function

    ' 同意添加好友
    function model_acceptFriendRequest(requestId)
        model_acceptFriendRequestSql="UPDATE requesttip SET rt_status=2 WHERE rt_id="&requestId
        cn.execute(model_acceptFriendRequestSql)
    end function

    ' 拒绝添加好友
    function model_rejectFriendRequest(requestId)
        model_rejectFriendRequestSql="UPDATE requesttip SET rt_status=3 WHERE rt_id="&requestId
        cn.execute(model_rejectFriendRequestSql)
    end function

    ' 获取是否可以操作好友请求的权限
    function model_getCanOperateFriendRequest(requestId, myId)
        model_getCanOperateFriendRequestSql="SELECT * FROM requesttip WHERE rt_id="&requestId&" and rt_toId="&myId
        set model_getCanOperateFriendRequestRs=cn.execute(model_getCanOperateFriendRequestSql)
        if model_getCanOperateFriendRequestRs.eof then
            model_getCanOperateFriendRequest=false
        else
            model_getCanOperateFriendRequest=true
        end if
    end function

    ' 移除双方好友关系
    function model_deleteFriend(myId, friendId)
        model_deleteFriendSql="DELETE * FROM friends WHERE (f_customerId="&myId&" and f_friendId="&friendId&") or (f_customerId="&friendId&" and f_friendId="&myId&")"
        cn.execute(model_deleteFriendSql)
    end function

    '获取好友请求的发送方的id
    function model_getRequestSourceMember(requestId)
        model_getRequestSourceMemberSql="SELECT top 1 rt_fromId as fromId FROM requesttip WHERE rt_id="&requestId
        set model_getRequestSourceMemberRs=cn.execute(model_getRequestSourceMemberSql)
        if model_getRequestSourceMemberRs.eof then
            model_getRequestSourceMember=""
        else
            model_getRequestSourceMember=model_getRequestSourceMemberRs("fromId")
        end if
    end function
    
    ' 获取好友详细信息
    function model_getFriendDetail(id)
        model_getFriendDetailSql="SELECT TOP 1 "&_
        "c_id as userId, c_name as userName, c_photo as userPhoto, c_remark as userRemark, c_email as userEmail, c_phone as userPhone "&_
        " FROM customer WHERE c_id ="&id
        set model_getFriendDetail =cn.execute(model_getFriendDetailSql)
    end function
%>