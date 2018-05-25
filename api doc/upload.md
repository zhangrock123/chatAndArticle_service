### 图片数据接口
***

##### 1.库存图片上传

接口url：
``upload.asp?action=uploadImg``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
file|文件二进制流|是|文件二进制流信息（2M，jpg\|bmp\|jpeg\|gif\|png）|

结果返回：

```
    {
        "success":true,
        "data":{
            "url":"http://www.goorder.net/chatService/upload/201611011314314119.png"
        }
    }
```

***