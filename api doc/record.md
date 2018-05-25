### 文章信息数据接口
***

##### 1.发表文章

接口url：
``record.asp?action=createRecord``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
typeId|类型id|是|类型id|
title|文章标题|是|文章标题|
content|文章内容|是|文章内容|
pic|文章配图|否|文章配图，array string|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 2.删除文章

接口url：
``record.asp?action=deleteRecord``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
recordId|文章id|是|文章id|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 3.文章列表

接口url：
``record.asp?action=recordList``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
typeId|类型id|否|类型id|
keyword|关键字|否|关键字|
start|查询开始时间|否|查询开始时间|
end|查询结束时间|否|查询结束时间|
limit|每页显示多少条|否|每页显示多少条，默认：10|
page|当前第几页|否|当前第几页，默认：1|

结果返回：

```
    {
        "success":true,
        "currentPage":"1",
        "totalPage":"1",
        "data":[
            {
                "listNO":"1",
                "recordId":"30",
                "title":"这是一个测试的标题",
                "content":"这里是测试的内容。测试的内容。",
                "createTime":"2016-11-01 13:29:56",
                "status":"1",
                "typeName":"IT行业信息",
                "typeId":"3",
                "userName":"rocktest",
                "userPhoto":"13800138002",
                "userEmail":"12344@qq.com"
            }
        ]
    }
```

***

##### 4.文章详情

接口url：
``record.asp?action=recordDetail``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
recordId|文章id|是|文章id|

结果返回：

```
    {
        "success":true,
        "data":{
            "recordId":"30",
            "title":"这是一个测试的标题",
            "content":"这里是测试的内容。测试的内容。",
            "createTime":"2016-11-01 13:29:56",
            "status":"1",
            "typeName":"IT行业信息",
            "typeId":"3",
            "userName":"rocktest",
            "userPhoto":"13800138002",
            "pics":[
                {
                    "picUrl":"http://www.goorder.net/chatService/upload/201611011329499336.png"
                },
                {
                    "picUrl":"http://www.goorder.net/chatService/upload/201611011329537336.png"
                }
            ]
        }
    }
```

***


##### 5.文章类型列表

接口url：
``record.asp?action=recordTypeList``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|

结果返回：

```
    {
        "success":true,
        "data":[
            {
                "listNO":"1",
                "typeId":"1",
                "typeName":"测试类型",
                "typeStatus":"1"
            },
            {
                "listNO":"2",
                "typeId":"2",
                "typeName":"哈哈类型",
                "typeStatus":"1"
            },
            {
                "listNO":"3",
                "typeId":"3",
                "typeName":"IT行业信息",
                "typeStatus":"1"
            }
        ]
    }
```

***


##### 6.创建文章类型

接口url：
``record.asp?action=createRecordType``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
name|类型名称|是|类型名称|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 7.编辑文章类型

接口url：
``record.asp?action=updateRecordType``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
typeId|类型id|是|类型id|
name|类型名称|是|类型名称|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 8.删除文章类型

接口url：
``record.asp?action=deleteRecordType``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
typeId|类型id|是|类型id|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***