<%
    function checkParam(valArr, errArr)
        arrLen=ubound(valArr)
        if arrLen >= 0 then
            for i=0 to arrLen
                if valArr(i) ="" then
                    call getCustomJSONErrData("1002",errArr(i),charSet)
                    response.end
                end if
            next
        end if
    end function
%>