### 用户信息数据接口

>   注意：以下涉及的imgToken，code请参阅 ``verify.md``
>
>   1. ``action=imageToken``  // 获取imgToken
>
>   2. ``action=image&token=xxxxx``  // 根据验证码图片手动输入图片code内容


***

##### 1.用户登录 

接口url：
``customer.asp?action=userLogin``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
userName|用户帐号|是|用户帐号信息|
password|用户密码|是|用户密码信息|
imgToken|图片验证码token|是|图片验证码token信息|
code|图片验证码code|是|图片验证码code信息|

结果返回：

```
    {
        "success":true,
        "data":{
            "userName":"rocktest",
            "userPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
            "userRemark":"没啥好说的",
            "userEmail":"12344@qq.com",
            "userPhone":"13800138002",
            "userToken":"82456D3A-1835-4966-A1BD-1C77A4BCD9BA",
            "createTime":"2016-10-25 14:04:31",
            "tokenExpire":"2016-12-01"
        }
    }
```

***

##### 2.用户注册

接口url：
``customer.asp?action=userRegist``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
userName|用户帐号|是|用户帐号信息|
password|用户密码|是|用户密码信息|
imgToken|图片验证码token|是|图片验证码token信息|
code|图片验证码code|是|图片验证码code信息|
photo|头像链接|否|头像链接|
remark|自我介绍|否|自我介绍|
email|邮箱|否|邮箱|
phone|手机号|否|手机号|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***

##### 3.设置头像

接口url：
``customer.asp?action=changePhoto``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
photoUrl|头像链接|是|头像链接|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***


##### 4.设置密码

接口url：
``customer.asp?action=changePassword``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
oldPassword|老密码信息|是|老密码信息|
newPassword|新密码信息|是|新密码信息|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***

##### 5.查找用户

接口url：
``customer.asp?action=searchUser``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
keyword|关键字|是|关键字|
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
                "userId":"1",
                "userName":"rocktest",
                "userPhoto":"http://www.goorder.net/chatService/upload/201610281722357434.jpeg",
                "userEmail":"12344@qq.com",
                "userPhone":"13800138002"
            },
            {
                "listNO":"2",
                "userId":"8",
                "userName":"hellorock",
                "userPhoto":"http://goorder.net/chatService/upload/201610271154544341.jpg",
                "userEmail":"rock11@qq.com",
                "userPhone":"13800138011"
            }
        ]
    }
```

***


##### 6.获取我的信息

接口url：
``customer.asp?action=myInfo``

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
        "data":{
            "userName":"rocky",
            "userPhoto":"http://www.goorder.net/chatService/upload/201611011314314119.png",
            "userRemark":"",
            "userEmail":"",
            "userPhone":"",
            "userToken":"6563062F-F83E-49DA-9B88-6183FFCC8935",
            "createTime":"2016-11-01 13:13:28",
            "tokenExpire":"2016-12-01"
        }
    }
```

***



##### 7.设置我的信息

接口url：
``customer.asp?action=changeMyInfo``

请求方式：
``post``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
token|用户token|是|用户token|
photo|头像链接|否|头像链接，（photo，remark，email，phone至少一个有值）|
remark|自我介绍|否|自我介绍，（photo，remark，email，phone至少一个有值）|
email|邮箱|否|邮箱，（photo，remark，email，phone至少一个有值）|
phone|手机号|否|手机号，（photo，remark，email，phone至少一个有值）|

结果返回：

```
    {
        "success":true,
        "data":{}
    }
```

***