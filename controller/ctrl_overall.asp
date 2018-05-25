<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
    ' 说明
    ' 接口调用之前本页面定义在最上面，本页面包含全局组件和数据库connection，以及字符集
%>
<!--#include file="../conn/conn.asp"-->

<!--#include file="../tool/tool_crossDomain.asp"-->
<!--#include file="../tool/tool_token.asp"-->
<!--#include file="../tool/tool_getJsonString.asp"-->
<!--#include file="../tool/tool_md5.asp"-->
<!--#include file="../tool/tool_checkParam.asp"-->


<!--#include file="ctrl_auth.asp"-->

<%
    charSet="utf-8"
    action=request("action")
%>