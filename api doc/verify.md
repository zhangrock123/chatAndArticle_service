### 图片验证码接口

>   注意：以下接口服务于用户登录时候的imgToken，code，具体请参阅 ``customer.md``
>
>   1. ``action=imageToken``  // 获取imgToken
>
>   2. ``action=image&token=xxxxx``  // 根据验证码图片手动输入图片code内容

***

##### 1.获取验证码token

接口url：
``verify.asp?action=imageToken``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
||||

结果返回：

```
{
    "success":true,
    "data":{
        "token":"8A71995F-7293-4FCF-AA82-C5DB78B939D9"
    }
}
```

***

##### 2.根据token信息，获取验证码图片

接口url：
``verify.asp?action=image&token=xxxxx``

请求方式：
``get``

请求参数：

字段|名称|是否必须|说明|
---|---|---|---|
||||

结果返回：

```
    图片文件，用于显示验证码图片
```