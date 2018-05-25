<%
    ' 正则基类方法
    function base_tool_regCheck(patrn, str, matchType)
        Dim regEx
        Set regEx = New RegExp
        regEx.Pattern = patrn
        regEx.IgnoreCase = instr(matchType,"i")>0
        regEx.Global = instr(matchType,"g")>0
        base_tool_regCheck = regEx.Test(str)
    end function
%>
<%
    ' 自定义正则判断
    function tool_customCheck(patrn, str, matchType)
        tool_customCheck=base_tool_regCheck(patrn, str, matchType)
    end function

    ' 检查手机号
    function tool_checkIsMobile(str)
        regStr="^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\d{8}$"
        tool_checkIsMobile=base_tool_regCheck(regStr, str, "")
    end function  

    ' 检查是否为空
    function tool_checkIsNull(str)
        regStr="^$"
        if str <> "" then str=trim(str)
        tool_checkIsNull=base_tool_regCheck(regStr, str, "ig")
    end function

    ' 检查是否电子邮箱
    function tool_checkIsEmail(str)
        regStr="^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$"
        tool_checkIsEmail=base_tool_regCheck(regStr, str, "")
    end function

    ' 检查密码（5-10位，数组与字母组合）
    function tool_checkPassword(str)
        regStr="^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{5,10}$"
        tool_checkPassword=base_tool_regCheck(regStr, str, "")
    end function

    ' 检查密码（min-max位，数组与字母组合）默认：5-10
    function tool_checkPasswordLimit(str, min, max)
        if min="" then min=5
        if max="" then max=10
        if max<min then 
            mid=min
            min=max
            max=mid
        end if
        regStr="^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{"&min&","&max&"}$"
        tool_checkPasswordLimit=base_tool_regCheck(regStr, str, "")
    end function

    ' 检查是否是邮政编码
    function tool_checkIsPostCode(str)
        regStr="^[1-9]{1}(\d+){5}$"
        tool_checkIsPostCode=base_tool_regCheck(regStr, str, "")
    end function

    ' 检查是否是身份证号码（15位和18位）
    function tool_checkIsCdCard(str)
        reg_15="^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$"
        reg_18="^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$"
        isMatch_15=base_tool_regCheck(reg_15, str, "ig")
        isMatch_18=base_tool_regCheck(reg_18, str, "ig")
        if isMatch_15=true or isMatch_18=true then
            tool_checkIsCdCard=true
        else
            tool_checkIsCdCard=false
        end if
    end function
%>

<%
    '   =========================================================================
    '   tool_checkParam 方法说明
    '       columnValue     检测的值
    '       columnTipArr    和checkTypeArr对应  传入验证不通过的的提示信息
    '       checkTypeArr    和columnTipArr对应  传入验证方式
    '   -------------------------------------------------------------------------
    '   checkTypeArr 参数说明（null, mobile, email, password, postcode, cdcard）
    '       null        tool_checkIsNull        检查是否为空
    '       mobile      tool_checkIsMobile      检查手机号
    '       email       tool_checkIsEmail       检查是否电子邮箱
    '       password    tool_checkPassword      检查密码（5-10位，数组与字母组合）
    '       postcode    tool_checkIsPostCode    检查是否是邮政编码
    '       cdcard      tool_checkIsCdCard      检查是否是身份证号码（15位和18位）
    '   -------------------------------------------------------------------------
    '   例子  
    '       columnValue="123@123.com"
    '       columnTipArr=array("邮箱号码为空","邮箱格式不合法")
    '       checkTypeArr=array("null","email")
    '       errorCodeArr=array("1001","1002")
    '       call tool_checkParam(columnValue, columnTipArr, checkTypeArr,errorCodeArr)
    '   =========================================================================
    function tool_checkParam(columnValue, columnTipArr, checkTypeArr, errorCodeArr)
        checkLen=ubound(checkTypeArr)
        checkTypeName=""
        checkStatus=true
        columnTipContent=""
        errorCode=""
        if checkLen > 0 then
            for i = 0 to checkLen
                checkTypeName=checkTypeArr(i)
                if checkTypeName <> "" then
                    columnTipContent=columnTipArr(i)
                    errorCode=errorCodeArr(i)
                    ' 检查是否为空
                    if checkTypeName="null" then
                        if tool_checkIsNull(columnValue)=true then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if
                    ' 检查手机号
                    if checkTypeName="mobile" then
                        if tool_checkIsMobile(columnValue)=false then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if
                    ' 检查是否电子邮箱
                    if checkTypeName="email" then
                        if tool_checkIsEmail(columnValue)=false then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if
                    ' 检查密码（5-10位，数组与字母组合）
                    if checkTypeName="password" then
                        if tool_checkPassword(columnValue)=false then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if
                    ' 检查是否是邮政编码
                    if checkTypeName="postcode" then
                        if tool_checkIsPostCode(columnValue)=false then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if
                    ' 检查是否是身份证号码（15位和18位）
                    if checkTypeName="cdcard" then
                        if tool_checkIsCdCard(columnValue)=false then
                            call getCustomJSONErrData(errorCode, columnTipContent, charSet)
                            response.end
                            exit for
                        end if
                    end if

                end if
            next
        end if
    end function
%>

<%
    ' function log(str)
    '     if str="" then str="<br>"
    '     response.write str
    ' end function

    ' log("检查手机号")
    ' mob1="13900139000"
    ' mob1Res=tool_checkIsMobile(mob1)
    ' log(mob1&":"&mob1Res)
    ' log("")

    ' log("检查手机号")
    ' mob2="13900139"
    ' mob2Res=tool_checkIsMobile(mob2)
    ' log(mob2&":"&mob2Res)
    ' log("")

    ' log("检查是否为空")
    ' null1=""
    ' null1Res=tool_checkNull(null1)
    ' log(null1&":"&null1Res)
    ' log("")

    ' log("检查是否为空")
    ' null2="111"
    ' null2Res=tool_checkNull(null2)
    ' log(null2&":"&null2Res)
    ' log("")

    ' log("检查是否为空(空格)")
    ' null3="   "
    ' null3Res=tool_checkNull(null3)
    ' log(null3&":"&null3Res)
    ' log("")

    ' log("检查是否电子邮箱")
    ' mail1="123@qq.com"
    ' mail1Res=tool_checkIsEmail(mail1)
    ' log(mail1&":"&mail1Res)
    ' log("")

    ' log("检查是否电子邮箱")
    ' mail2="123$qq.com"
    ' mail2Res=tool_checkIsEmail(mail2)
    ' log(mail2&":"&mail2Res)
    ' log("")

    ' log("检查密码（5-10位，数组与字母组合）")
    ' pwd1="123456a"
    ' pwd1Res=tool_checkPassword(pwd1)
    ' log(pwd1&":"&pwd1Res)
    ' log("")

    ' log("检查密码（5-10位，数组与字母组合）")
    ' pwd2="1234567"
    ' pwd2Res=tool_checkPassword(pwd2)
    ' log(pwd2&":"&pwd2Res)
    ' log("")

    ' log("检查密码（8-10位，数组与字母组合）")
    ' pwd3="123456a"
    ' pwd3Res=tool_checkPasswordLimit(pwd3, 8, 10)
    ' log(pwd3&":"&pwd3Res)
    ' log("")

    ' log("检查密码（8-10位，数组与字母组合）")
    ' pwd4="1234567a"
    ' pwd4Res=tool_checkPasswordLimit(pwd4, 8, 10)
    ' log(pwd4&":"&pwd4Res)
    ' log("")

    ' log("检查是否是邮政编码")
    ' post1="202179"
    ' post1Res=tool_checkIsPostCode(post1)
    ' log(post1&":"&post1Res)
    ' log("")

    ' log("检查是否是邮政编码")
    ' post2="2021791"
    ' post2Res=tool_checkIsPostCode(post2)
    ' log(post2&":"&post2Res)
    ' log("")

    ' log("检查是否是身份证号码（15位和18位）")
    ' cd1="310230199912213323"
    ' cd1Res=tool_checkIsCdCard(cd1)
    ' log(cd1&":"&cd1Res)
    ' log("")

    ' log("检查是否是身份证号码（15位和18位）")
    ' cd2="12345678901"
    ' cd2Res=tool_checkIsCdCard(cd2)
    ' log(cd2&":"&cd2Res)
    ' log("")
%>