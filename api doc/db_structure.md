#### chatmsg(聊天数据表)

列名      |	类型号     |	类型备注    |
---|---|---|
ch_id       |	3       |	长整型    |
ch_fromId       |	3       |	长整型    |
ch_toId     |	3       |	长整型    |
ch_content      |	203     |	备注    |
ch_createStamp      |	135     |	日期/时间    |
ch_fromReadStatus       |	3       |	长整型    |
ch_toReadStatus     |	3       |	长整型    |

#### customer(用户表)

列名      |	类型号     |	类型备注    |
---|---|---|
c_id        |	3       |	长整型    |
c_name      |	202     |	文本    |
c_pwd       |	202     |	文本    |
c_photo     |	202     |	文本    |
c_remark        |	203     |	备注    |
c_createStamp       |	135     |	日期/时间    |
c_email     |	202     |	文本    |
c_phone     |	202     |	文本    |
c_token     |	202     |	文本    |
c_tokenExpire       |	135     |	日期/时间    |
c_status        |	3       |	长整型    |

#### friends(好友表)

列名      |	类型号     |	类型备注    |
---|---|---|
f_id        |	3       |	长整型    |
f_customerId        |	3       |	长整型    |
f_friendId      |	3       |	长整型    |
f_status        |	3       |	长整型    |
f_createStamp       |	135     |	日期/时间    |

#### record(文章表)

列名      |	类型号     |	类型备注    |
---|---|---|
re_id       |	3       |	长整型    |
re_customerId       |	3       |	长整型    |
re_typeId       |	3       |	长整型    |
re_content      |	203     |	备注    |
re_title        |	202     |	文本    |
re_createStamp      |	135     |	日期/时间    |
re_status       |	3       |	长整型    |

#### recordpic(文章配图表)

列名      |	类型号     |	类型备注    |
---|---|---|
rep_id      |	3       |	长整型    |
rep_recordId        |	3       |	长整型    |
rep_pic     |	202     |	文本    |
re_createStamp      |	135     |	日期/时间    |

#### recordtype(文章分类表)

列名      |	类型号     |	类型备注    |
---|---|---|
ret_id      |	3       |	长整型    |
ret_name        |	202     |	文本    |
ret_customerId      |	3       |	长整型    |
ret_createStamp     |	135     |	日期/时间    |
ret_status      |	3       |	长整型    |

#### requesttip(好友请求提示表)

列名      |	类型号     |	类型备注    |
---|---|---|
rt_id       |	3       |	长整型    |
rt_fromId       |	3       |	长整型    |
rt_toId     |	3       |	长整型    |
rt_tip      |	202     |	文本    |
rt_status       |	3       |	长整型    |
rt_createStamp      |	135     |	日期/时间    |

#### verifyimage(验证码图片表)

列名      |	类型号     |	类型备注    |
---|---|---|
vi_id       |	3       |	长整型    |
vi_code     |	202     |	文本    |
vi_token        |	202     |	文本    |
vi_tokenExpire      |	135     |	日期/时间    |
vi_status       |	3       |	长整型    |
vi_createTimeStamp      |	135     |	日期/时间    |