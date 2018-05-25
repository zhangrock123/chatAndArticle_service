<% 
    ' ../tool/tool_upload.asp 
%>

<%
    ' 上传图片，并输出上传结果信息
   function model_uploadImage(fileFormName)
        ' 返回数组  (errorStatus, uploadUrl or Exception)  
        '       errorStatus   1  上传成功，第二个元素就是url   2上传失败，第二个元素就是失败原因
        dim upload
        set upload = new AnUpLoad
        upload.Exe = "jpg|bmp|jpeg|gif|png"
        upload.MaxSize = 2 * 1024 * 1024 '2M
        upload.GetData()

        uploadPath="upload"
        resultData=""
        isUploadError=false

        if upload.ErrorID>0 then 
            isUploadError=true
            resultData=upload.Description
        else
            dim file,savpath
            savepath = uploadPath
            set file = upload.files(fileFormName)
            if file.isfile then
                result = file.saveToFile(savepath,0,true)
                if result then
                    Path="http://" & Request.ServerVariables("server_name") & Request.ServerVariables("script_name")
                    Pos=InStrRev(Path,"/")
                    ServerPath=Left(Path,Pos)
                    resultData=ServerPath & savepath & "/" & file.filename
                else
                    isUploadError=true
                    resultData=file.Exception
                end if
            end if
        end if

        ' uploadStatus=1
        ' if isUploadError=true then uploadStatus=2
        
        model_uploadImage=resultData
   end function
%>