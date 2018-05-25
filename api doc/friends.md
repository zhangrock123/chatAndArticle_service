### 好友信息数据接口

>  注意：好友间的关系status有以下几类：
>
>// 1 未处理  2 接受  3 拒绝  99 删除

***

##### 1.好友列表

接口url：
``friends.asp?action=friendsList``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
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
                "friendId":"7",
                "friendName":"xxxxxx",
                "friendPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png",
                "friendRemark":"我只是一个测试的帐号，没有太多想说的话，哈哈哈。。。",
                "friendEmail":"test@qq.com",
                "friendPhone":"13800138002",
                "friendStatus":"1"
            },
            {
                "listNO":"2",
                "friendId":"8",
                "friendName":"hellorock",
                "friendPhoto":"http://www.goorder.net/chatService/upload/201610271154544341.jpg",
                "friendRemark":"测试",
                "friendEmail":"rock11@qq.com",
                "friendPhone":"13800138011",
                "friendStatus":"1"
            }
        ]
    }
```

***

##### 2.发送好友请求

接口url：
``friends.asp?action=sendRequest``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|对方id|是|对方id|
content|发送的文案|否|发送的文案|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 3.接受好友请求

接口url：
``friends.asp?action=acceptRequest``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
requestId|请求id|是|请求id|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 4.拒绝好友请求

接口url：
``friends.asp?action=rejectRequest``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
requestId|请求id|是|请求id|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 5.删除好友

接口url：
``friends.asp?action=deletefriend``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
id|好友id|是|好友id|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 6.发送的好友申请历史

接口url：
``friends.asp?action=requestSentHistory``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
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
                "requestId":"1",
                "userId":"1",
                "userName":"rocktest",
                "userPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "userEmail":"12344@qq.com",
                "userPhone":"13800138002",
                "requestTime":"2016-10-26 12:07:46",
                "status":"2",
                "content":"你好，我想加你为好友～"
            },
            {
                "listNO":"2",
                "requestId":"8",
                "userId":"8",
                "userName":"hellorock",
                "userPhoto":"http://goorder.net/chatService/upload/201610271154544341.jpg",
                "userEmail":"rock11@qq.com",
                "userPhone":"13800138011",
                "requestTime":"2016-10-27 13:45:19",
                "status":"2",
                "content":"约吗"
            },
            {
                "listNO":"3",
                "requestId":"9",
                "userId":"9",
                "userName":"jessica",
                "userPhoto":"http://goorder.net/chatService/upload/201610262100065167.jpeg",
                "userEmail":"jessica@qq.com",
                "userPhone":"13800138001",
                "requestTime":"2016-10-27 16:53:13",
                "status":"1",
                "content":"约吗？？"
            }
        ]
    }
```

***


##### 7.收到的好友申请历史

接口url：
``friends.asp?action=requestReceivedHistory``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
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
                "requestId":"1",
                "userId":"1",
                "userName":"rocktest",
                "userPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "userEmail":"12344@qq.com",
                "userPhone":"13800138002",
                "requestTime":"2016-10-26 12:07:46",
                "status":"2",
                "content":"你好，我想加你为好友～"
            },
            {
                "listNO":"2",
                "requestId":"6",
                "userId":"7",
                "userName":"xxxxxx",
                "userPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png",
                "userEmail":"test@qq.com",
                "userPhone":"13800138002",
                "requestTime":"2016-10-26 15:35:09",
                "status":"2",
                "content":"我是测试的帐号"
            },
            {
                "listNO":"3",
                "requestId":"15",
                "userId":"12",
                "userName":"rocky",
                "userPhoto":"http://www.goorder.net/chatService/upload/201611011314314119.png",
                "userEmail":"",
                "userPhone":"",
                "requestTime":"2016-11-01 13:18:46",
                "status":"1",
                "content":"你好，我想加你为好友～"
            }
        ]
    }
```

***


##### 8.获取好友详情信息

接口url：
``friends.asp?action=friendDetail``

请求方式：
``post``

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
            "userId":"7",
            "userName":"xxxxxx",
            "userPhoto":"http://www.goorder.net/chatService/upload/201610261534026748.png",
            "userRemark":"我只是一个测试的帐号，没有太多想说的话，哈哈哈。。。",
            "userEmail":"test@qq.com",
            "userPhone":"13800138002"
        }
    }
```

***