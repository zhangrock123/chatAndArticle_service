<!--#include file="tool_htmlLabel.asp"-->
<!--#include file="tool_string.asp"-->
<%
	function getRSJsonData(sqlStr,conn,listCount,page,columnList,charSet,isFilter,filterLen)
		listCount=cint(listCount)
		Set jsonRS=Server.CreateObject("ADODB.Recordset")
		jsonRS.ActiveConnection =conn
		jsonRS.CursorType =1
		jsonRS.CursorLocation = 2
		jsonRS.LockType = 3
		jsonRS.PageSize=listCount
		jsonRS.open sqlStr
		jsonStr="{"
		if not jsonRS.eof then
			jsonAllPages = jsonRS.pageCount
			if isEmpty(page) or Cint(page)<1 then page= 1
			if Cint(page)> jsonAllPages then page= jsonAllPages
			jsonRS.AbsolutePage = page
			jsonStr=jsonStr&"""success"":true,"
			jsonStr=jsonStr&"""currentPage"":"""&page&""","
			jsonStr=jsonStr&"""totalPage"":"""&jsonAllPages&""","
			jsonStr=jsonStr&"""data"":["
			listCounter=listCount
			Do while Not jsonRS.eof and listCount>0
				jsonStr=jsonStr&"{"
				jsonStr=jsonStr&"""listNO"":"""&(listCounter-listCount+1)&""","
				for i=0 to ubound(columnList)
					if isFilter=true then
						if filterLen>0 then
						jsonStr=jsonStr&""""&columnList(i)&""":"""&chkLen(DecodeFilter(JSONFormat(jsonRS(columnList(i)))),filterLen)&""","
						else
						jsonStr=jsonStr&""""&columnList(i)&""":"""&DecodeFilter(JSONFormat(jsonRS(columnList(i))))&""","
						end if
					else
						jsonStr=jsonStr&""""&columnList(i)&""":"""&JSONFormat(jsonRS(columnList(i)))&""","
					end if
				next
				jsonStr=left(jsonStr,len(jsonStr)-1)
				jsonStr=jsonStr&"},"
			listCount=listCount-1
			jsonRS.movenext
			loop
			jsonStr=left(jsonStr,len(jsonStr)-1)
			jsonStr=jsonStr&"]"
		else
			jsonStr=jsonStr&"""success"":false,"
			jsonStr=jsonStr&"""errNo"":""1001"","
			jsonStr=jsonStr&"""errMsg"":""数据不存在"""
		end if
		
		jsonStr=jsonStr&"}"
		jsonRS.close
		set jsonRS=nothing
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function
	
	function getJSONListData(rs,columnList,charSet)
		jsonStr="{"
		if not rs.eof then
			jsonStr=jsonStr&"""success"":true,"
			jsonStr=jsonStr&"""data"":["
			listCounter=1
			Do while Not rs.eof
				jsonStr=jsonStr&"{"
				jsonStr=jsonStr&"""listNO"":"""&listCounter&""","
				for i =0 to ubound(columnList)
					jsonStr=jsonStr&""""&columnList(i)&""":"""&JSONFormat(rs(columnList(i)))&""","
				next
				jsonStr=left(jsonStr,len(jsonStr)-1)
				jsonStr=jsonStr&"},"
			listCounter=listCounter+1
			rs.movenext
			loop
			jsonStr=left(jsonStr,len(jsonStr)-1)
			jsonStr=jsonStr&"]"
		else
			jsonStr=jsonStr&"""success"":false,"
			jsonStr=jsonStr&"""errNo"":""1001"","
			jsonStr=jsonStr&"""errMsg"":""数据不存在"""
		end if
		jsonStr=jsonStr&"}"
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function
	
	function getJSONMainData(rs,columnList,charSet)
		jsonStr="{"
		if not rs.eof then
			jsonStr=jsonStr&"""success"":true,"
			jsonStr=jsonStr&"""data"":{"
			Do while Not rs.eof
				for i =0 to ubound(columnList)
					jsonStr=jsonStr&""""&columnList(i)&""":"""&JSONFormat(rs(columnList(i)))&""","
					' response.Write ubound(columnList)&"<br />"
				next
			rs.movenext
			loop
			jsonStr=left(jsonStr,len(jsonStr)-1)
			jsonStr=jsonStr&"}"
		else
			jsonStr=jsonStr&"""success"":false,"
			jsonStr=jsonStr&"""errNo"":""1001"","
			jsonStr=jsonStr&"""errMsg"":""数据不存在"""
		end if
		jsonStr=jsonStr&"}"
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function

	function getJSONMainDataSpecial(rs,rsColumnList,appendKeyName,appendRs,appendRsColumnList,charSet)
		jsonStr="{"
		if not rs.eof then
			jsonStr=jsonStr&"""success"":true,"
			jsonStr=jsonStr&"""data"":{"
			Do while Not rs.eof
				for i =0 to ubound(rsColumnList)-1
					jsonStr=jsonStr&""""&rsColumnList(i)&""":"""&JSONFormat(rs(rsColumnList(i)))&""","
				next
			rs.movenext
			loop
			if not appendRs.eof then
				jsonStr=jsonStr&""""&appendKeyName&""":["
				do while not appendRs.eof
					jsonStr=jsonStr&"{"
					for j=0 to ubound(appendRsColumnList)-1
						jsonStr=jsonStr&""""&appendRsColumnList(j)&""":"""&JSONFormat(appendRs(appendRsColumnList(j)))&""","
					next
					jsonStr=left(jsonStr,len(jsonStr)-1)
					jsonStr=jsonStr&"},"
				appendRs.movenext
				loop
				jsonStr=left(jsonStr,len(jsonStr)-1)
				jsonStr=jsonStr&"]"
			else
				jsonStr=left(jsonStr,len(jsonStr)-1)
			end if
			
			jsonStr=jsonStr&"}"
		else
			jsonStr=jsonStr&"""success"":false,"
			jsonStr=jsonStr&"""errNo"":""1001"","
			jsonStr=jsonStr&"""errMsg"":""数据不存在"""
		end if
		jsonStr=jsonStr&"}"
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function 

	function getCustomJSONData(isSuccess, columnList, valueList, charSet)
		isHasAppend=false
		jsonStr="{"
		if isSuccess =true  then
			jsonStr=jsonStr&"""success"":true,"
		else
			jsonStr=jsonStr&"""success"":false,"
		end if
		jsonStr=jsonStr&"""data"":{"
		for i =0 to ubound(columnList)
			if columnList(i) <> "" then
				jsonStr=jsonStr&""""&columnList(i)&""":"""&valueList(i)&""","
				isHasAppend=true
			end if
		next
		if isHasAppend = true then
			jsonStr=left(jsonStr,len(jsonStr)-1)
		end if
		jsonStr=jsonStr&"}"
		jsonStr=jsonStr&"}"
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function

	function getCustomJSONErrData(errNo, errMsg, charSet)
		jsonStr="{"
		jsonStr=jsonStr&"""success"":false,"
		jsonStr=jsonStr&"""errNo"":"""&errNo&""","
		jsonStr=jsonStr&"""errMsg"":"""&errMsg&""""
		jsonStr=jsonStr&"}"
		response.Write jsonStr
		response.ContentType="text/json"
		response.Charset=charSet
	end function
	
	function JSONFormat(str)
		str=str&""
		if str <> "" then
		' response.Write "<>有值<>"
			str = replace(str,"\","\\")
			str = replace(str,"/","\/")
			str = replace(str,"""","\""")
			str = replace(str,chr(10),"")
			str = replace(str,chr(13),"")
			str = replace(str,chr(9),"")
		else
		' response.Write "<>空值<>"
			str=""
		end if
		JSONFormat=str
	end function
%>