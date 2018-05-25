<%
function ExecReg(re, content)
    Dim myRegExp, ResultString
    Set myRegExp = New RegExp
     myRegExp.Global = True
     myRegExp.Pattern = re
     ResultString = myRegExp.Replace(content, "")
     ExecReg = ResultString
end function

function DecodeFilter(html)
         html = LCase(html)
         html = ExecReg("</?script[^>]*>", html)
         html = ExecReg("(javascript|jscript|vbscript|vbs):", html)
         html = ExecReg("on(mouse|exit|error|click|key)", html)
         html = ExecReg("&#", html)
         html = ExecReg("</?table[^>]*>", html)
         html = ExecReg("</?tr[^>]*>", html)
         html = ExecReg("</?th[^>]*>", html)
         html = ExecReg("</?td[^>]*>", html)
         html = ExecReg("</?a[^>]*>", html)
         html = ExecReg("</?p[^>]*>", html)
         html = ExecReg("</?img[^>]*>", html)
         html = ExecReg("</?div[^>]*>", html)
         html = ExecReg("</?ul[^>]*>", html)
		 html = ExecReg("</?ol[^>]*>", html)
         html = ExecReg("</?li[^>]*>", html)
         html = ExecReg("</?tbody[^>]*>", html)
         html = ExecReg("</?h1[^>]*>", html)
         html = ExecReg("</?h2[^>]*>", html)
         html = ExecReg("</?h3[^>]*>", html)
         html = ExecReg("</?h4[^>]*>", html)
         html = ExecReg("</?h5[^>]*>", html)
         html = ExecReg("</?h6[^>]*>", html)
         html = ExecReg("</?b[^>]*>", html)
		 html = ExecReg("</?span[^>]*>", html)
         html = ExecReg("</?strong[^>]*>", html)
         html = ExecReg("(<[^>]+) class=[^ |^>]*([^>]*>)", html)
         html = ExecReg("(<[^>]+) style=""[^""]*""([^>]*>)",   html)
         html = ExecReg("<\?xml[^>]*>", html)
         html = ExecReg("</?[a-z]+:[^>]*>", html)
         html = ExecReg("</?font[^>]*>", html)
         html = ExecReg("</?marquee[^>]*>", html)
         html = ExecReg("</?object[^>]*>",   html)
         html = ExecReg("</?param[^>]*>", html)
         html = ExecReg("</?embed[^>]*>", html)
         DecodeFilter= html
end function
%>
