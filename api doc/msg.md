### 聊天信息数据接口


>   注意：以下涉及时间查询(start, end)逻辑查询为：
>
>
>   1. ``[无start，无end]`` 小于等于当前时间之前的数据（用于初始化聊天列表） 
>
>   2. ``[有start，无end]`` start时间之前的数据（即更早的时间，用于向上滑动获取历史聊天数据）
>
>   3. ``[无start，有end]`` end时间之后的数据（即更晚或更新的时间，用于获取最新的或者自动读取最新的聊天数据）
>
>   4. ``[有start，有end]`` 大于start时间，小于等于end时间之间的数据（用于消息管理器，查询某个时间段之内的聊天记录）

***

##### 1.信息列表

接口url：
``msg.asp?action=messageList``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|好友id|是|好友id|
limit|每页显示多少条|否|每页显示多少条，默认：10|
start|查询开始时间|否|查询开始时间|
end|查询结束时间|否|查询结束时间|

结果返回：

```
    {
        "success":true,
        "data":[
            {
                "listNO":"1",
                "message":"呀，是真的啊",
                "createTime":"2016-10-28 13:34:29",
                "fromName":"rocktest",
                "fromId":"1",
                "fromPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "toName":"xxxxxx",
                "toId":"7",
                "toPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png"
            },
            {
                "listNO":"2",
                "message":"不是不是不是",
                "createTime":"2016-10-26 20:21:31",
                "fromName":"rocktest",
                "fromId":"1",
                "fromPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "toName":"xxxxxx",
                "toId":"7",
                "toPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png"
            }
        ]
    }
```

***

##### 2.发送聊天消息

接口url：
``msg.asp?action=sendMessage``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|好友id|是|好友id|
content|聊天数据|是|聊天数据|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 3.设置阅读状态

接口url：
``msg.asp?action=setReadStatus``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|好友id|是|好友id|
start|查询开始时间|否|查询开始时间|
end|查询结束时间|否|查询结束时间|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 4.获取未读消息数量

接口url：
``msg.asp?action=unreadCount``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|好友id|是|好友id|

结果返回：

```
    {
        "success":true,
        "data":{
            "count": 20
        }
    }
```

***

##### 5.获取和好友聊天的最后一条数据列表

接口url：
``msg.asp?action=getLastChat``

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
                "UserId":"1",
                "fromId":"1",
                "fromName":"rocktest",
                "fromPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "toId":"7",
                "toName":"xxxxxx",
                "toPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png",
                "content":"111",
                "createTime":"2016-11-01 13:26:28"
            }
        ]
    }
```

***