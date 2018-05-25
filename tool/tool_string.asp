<%
	'###########################################################################################################################
	'## 
	'## 												【---方法说明---】
	'## 
	'##	chkNULL			验证输入的值是否为Null								返回 （输入值 or 空）
	'##	outPrint		输出输入的值										返回 （输入值）
	'##	outPrintln		输出输入值加换行									返回 （输入值+换行）
	'##	getMoney		输出金额标准格式（三位逗号，保留小数点后两位）		返回 （金额标准格式[保留两位]）
	'##	Comma			输出三位逗号（保留原始长度）						返回 （三位逗号格式的输入值）
	'## notNullShow     控制判断 str不为空及空								返回  输入的值 returnString1（不为空） returnString2 （为空）
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'###########################################################################################################################
%>
<%
	function chkNULL(str)
		outWord=""
		if isnull(str)=false then
			outWord=str
		end if
		chkNULL=outWord
	end function
	
	function notNullShow(str,returnString1,returnString2)
		if str<> "" then
			notNullShow=returnString1
		else
			notNullShow=returnString2
		end if
	end function
	
	function outPrint(str)
		response.Write str
	end function
	
	function outPrintln(str)
		response.Write str&"<br />"
	end function
	
	Function getMoney(s)
		On Error Resume Next
		If Not IsNumeric(s) Then s = 0
		getMoney = FormatNumber(CDbl(s), 2, -1, 0, -1)   
	End Function
	
	Function Comma(str) 
		If Not(IsNumeric(str)) or str = 0 Then 
			Result = 0 
		ElseIf Len(Fix(str)) < 4 Then 
			Result = str 
		Else 
			Pos = Instr(1,str,".") 
			If Pos > 0 Then 
				Dec = Mid(str,Pos) 
			End if 
			Res = StrReverse(Fix(str)) 
			LoopCount = 1 
			While LoopCount <= Len(Res) 
				TempResult = TempResult + Mid(Res,LoopCount,3) 
				LoopCount = LoopCount + 3 
				If LoopCount <= Len(Res) Then 
				TempResult = TempResult + "," 
				End If 
			Wend 
			Result = StrReverse(TempResult) + Dec 
		End If 
		Comma = Result 
	End Function
	
	function chkLen(str,num)
		strLen=len(str)
		if strLen > num then
			chkLen=left(str,num)&"..."
		else
			chkLen=str
		end if
	end function
%>
 