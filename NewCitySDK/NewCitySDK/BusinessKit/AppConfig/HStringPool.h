//
//  HStringPoll.h
//  SmartCommunity
//
//  Created by xiang on 15/1/7.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#ifndef SmartCommunity_HStringPoll_h
#define SmartCommunity_HStringPoll_h

//通用
#define     STR_COMMON_NO_RECORD                @"暂无记录"
#define     STR_COMMON_OPERATE_FAIL             @"操作失败,请稍后再试"
#define     STR_COMMON_NO_MORE                  @"没有更多了"
#define     STR_COMMON_NO_DATA                  @"暂无数据"
#define     STR_COMMON_LOAD_FAIL                @"加载失败"
#define     STR_COMMON_LOADING                  @"加载中..."
#define     STR_COMMON_XF                       @"该时间段内没有消费记录"
#define     STR_COMMON_CZCX                      @"该时间段内暂无充值记录"
#define     STR_404_NOT_FOUND                   @"404 Not Found"

#define     STR_COMMON_NOT_OPEN                 @"此功能暂未开放，敬请期待！"

//账号相关
#define     STR_ACCOUNT_LOGIN_OTHER             @"该账号在其他地方登录"
#define     STR_ACCOUNT_AGREEMENT_ALERT         @"请勾选《新城势用户服务协议》"



#define     STR_ACCOUNT_REGISTER_PHONE_NONE_ALERT     @"手机号码不能为空"
#define     STR_ACCOUNT_REGISTER_USERNAME_NULL_LOGOIN   @"请输入正确的手机号"
//#define     STR_ACCOUNT_REGISTER_USERNAME_NULL_LOGOIN  @"请输入用户名"
#define     STR_ACCOUNT_REGISTER_PHONE_LENGTH_NOTENOUGH @"请输入正确的手机号"
#define     STR_ACCOUNT_REGISTER_PHONE_ALERT     @"请输入正确的银行预留手机号"
#define     STR_ACCOUNT_REGISTER_PHONE_NOT_EXIST_ALERT     @"手机号码不存在"
#define     STR_ACCOUNT_PHONE_NUMBER             @"两次输入手机号不匹配"
#define     STR_ACCOUNT_PASSWORD_INPUT           @"请输入密码"
#define     STR_ACCOUNT_PASSWORD_SHORT           @"密码太短"
#define     STR_ACCOUNT_PASSWORD_LONG            @"密码超过16位"
#define     STR_ACCOUNT_PASSWORD_RULE            @"密码至少包含字母、数字和符号两种"
#define     STR_ACCOUNT_PASSWORD_TURE            @"密码长度为6-16位"
#define     STR_ACCOUNT_TRADEPASSWORD_TURE       @"交易密码为6位数字"
#define     STR_ACCOUNT_FORGETPSWD_PASWLENGTH_NULL    @"密码不能为空"
#define     STR_PLEASE_INPUT_TRADEPWD            @"点击输入交易密码"
#define     STR_PLEASE_NULL_INPUT                @"请输入交易密码"
#define     STR_ACCOUNT_TRADEPASSWORD_ERROR      @"请输入正确的交易密码"
#define     STR_ACCOUNT_NEW_PASSWORD_INPUT       @"请输入新交易密码"
#define     STR_INPUT_CONFIRM_TRADE_PASSWORD     @"请输入确认交易密码"
#define     STR_TEADE_PASSWORD_ERROR             @"密码错误"
#define     STR_TEADE_PHONENUM_ISREGEST          @"该号码已经注册"

#define     STR_ACCOUNT_PASSWORD_RESET_SUCCESS   @"重置密码成功"
#define     STR_ACCOUNT_PASSWORD_RESET_FAIL      @"重置密码失败"

#define     STR_BIND_SHT_NEED_PASSWORD           @"该业务需要您设置交易密码"
#define     STR_BIND_SHT_ALERT                   @"该业务需要您绑定新城势卡"
#define     STR_BIND_SHT_BANKCARD_BINDING        @"该业务需要您绑定银行卡"

//商圈
#define     STR_DISTRICT_ORDERVC                 @"请选择产品"
#define     STR_BANK_INFORMATION                 @"请选择同意快捷支付"

#define     STR_ACCOUNT_AUTHCODE_SUCCESS         @"验证码已发送,请注意查收"
#define     STR_ACCOUNT_AUTHCODE_FAIL            @"验证码发送失败"
#define     STR_ACCOUNT_AUTHCODE_GET_FAIL        @"获取短信验证码失败,请稍后重试"
#define     STR_ACCOUNT_AUTHCODE_INPUT           @"请输入验证码"
#define     STR_ACCOUNT_AUTHCODE_ERROR           @"验证码错误"
#define     STR_ACCOUNT_AUTHCODE_OLDERROR        @"原手机验证码错误"
#define     STR_ACCOUNT_AUTHCODE_NEWERROR        @"新手机验证码错误"
#define     STR_ACCOUNT_AUTHCODE_VERIFY_ERROR    @"短信校验失败,请稍后重试"
#define     STR_ACCOUNT_AUTHCODE_NEEDED          @"请点击获取验证码"

//公交一卡通
#define     STR_CHOOSE_STARTANDENDDATE              @"请选择起止日期"
#define     STR_BUS_CARD_ERROR                      @"您的卡号有误，请重新输入"
#define     STR_CARD_NUMBER_OUT_LENTH               @"卡号已超出限制"
#define     STR_CARD_EMPTY                          @"卡号不能为空"
#define     STR_CARD_EMPTY2                         @"请输入卡号"
#define     STR_BUS_PASSWORD                        @"请输入正确的密码"
#define     STR_BUS_STARTDATE                       @"请选择起始日期"
#define     STR_BUS_FINISHDATE                      @"请选择终止日期"
#define     STR_BUS_CHECK_INTERVAL                  @"请选择查询区间"
#define     STR_BUS_DATE_ERROR                      @"日期选择有误"
#define     STR_START_LOCATION                      @"请输入起点"
#define     STR_DES_LOCATION                        @"请输入终点"
#define     STR_BUSOUTOFDATE                        @"暂支持三个月内的日期查询"
#define     STR_STARTDONOTBIGGERTHANENDDATE         @"起始日期不能大于终止日期"
#define     STR_CHARGE_CHOOSE_MEDIUM_TYPE           @"请选择渠道类型"

//公交路线相关
#define     STR_START_LOCATION_NONE                 @"起点不能为空"
#define     STR_DES_LOCATION_NONE                   @"终点点不能为空"
#define     STR_BUS_LINE_EMPTY                      @"公交路线不能为空"

#define     STR_BUSSTOP_QUERY_FAIL                  @"公交站点查询失败"
#define     STR_BUSLINE_QUERY_FAIL                  @"公交路线查询失败"

// 缴费
#define     STR_PAYMENT_ORG_LIST_EMPTY              @"暂无缴费单位，请添加缴费"
#define     STR_PAYMENT_TYPE_EMPTY                  @"缴费类型不能为空"
#define     STR_PAYMENT_PROVINCE_EMPTY              @"省份不能为空"
#define     STR_PAYMENT_CITY_EMPTY                  @"城市不能为空"
#define     STR_PAYMENT_ORG_EMPTY                   @"请选择缴费单位"
#define     STR_PAYMENT_USERNO_EMPTY                @"请输入缴费编号"
#define     STR_PAYMENT_USERNO_ERROR                @"请输入正确的用户编号"
#define     STR_PAYAMOUNT_NOT_SMALLER_BILLAMOUNT    @"缴费金额不能低于欠费金额"

//话费充值
#define     STR_ZONE_NUMBER_OUT_LENTH               @"输入区号已超出限制"
#define     STR_TELNUM_OUT_LENGTH                   @"电话号码已超出限制"
#define     STR_PHONENUM_OUT_LENGTH                 @"手机号码已超出限制"
#define     STR_ACCOUNT_PAYPHONEPRICE               @"请选择充值金额"

#define     STR_CHARGE_INPUT_PHONENUM                @"请输入手机号码"

#define    STR_CHARGE_INPUT_PHONENUM2             @"请输入手机号"
#define     STR_CHARGE_INPUT_AMOUNT                  @"请选择充值金额"
#define     STR_CHARGE_INPUT_AREA_NUM                @"请输入区号"
#define     STR_CHARGE_AREANUM_ERROR                 @"输入的区号有误"
#define     STR_CHARGE_INPUT_TELNUM                  @"请输入电话号码"
#define     STR_ACCOUNT_TELNUM_ERROR                 @"请输入正确的电话号码"


#define     STR_QUERY_PHONE_LOCATION                @"正在查询归属地..."
#define     STR_QUERY_PHONE_PRICE                   @"正在查询优惠价格"
#define     STR_NO_QUERY_BELONG                     @"未查询到归属地"
#define     STR_NO_QUERY_POHONE_PRICE               @"暂未查询到优惠价格"

// 新城势卡账户管理相关
#define     UpdateTitle                             @"修改成功"
#define     ForgotTitle                             @"重置成功"
#define     InitialTitle                            @"设置成功"
#define     UpdateLabelText                         @"修改交易密码成功"
#define     ForgotLabelText                         @"重置交易密码成功"
#define     InitialLabelText                        @"设置交易密码成功"

#define     TrandePwdError                          @"交易密码"

#define     INPUTPHONENUMBER                        @"请输入新手机号码"
#define     NEWPHONENUMNOTSAME                      @"新手机号码不能为同一个号码"
#define     STR_TRADEOUTOFDATE                      @"查询区间不能大于90天"

#define     STR_INPUT_BANKNUM                       @"请输入银行卡号"
#define     STR_INPUT_BANKNUM_XY                    @"请输入银行卡卡号或信用卡卡号"
#define     STR_BANKNUM_ERROR                       @"您输入的银行卡号有误"
#define     STR_NOT_SUPPORT_CREDIT_CARD             @"不支持信用卡充值,请使用借记卡!"
#define     STR_NEED_SELECT_PAY_PROTOCOL            @"请勾选《新城势支付服务用户协议》"

//实名化校验
#define    ADDBANKCARD_USERINFO_ERROR     @"为保证账户资金安全，只能绑定认证用户本人的银行卡"
#define    ORDERPAYSENDMESSAGEWITHNONE    @"none"

#define    ADDFUELCARD_USERINFO_ERROR    @"为保证账户资金安全，只能绑定与加油卡信息一致的银行卡"
#define    CHECKFUELCARD_USERINFO_ERROR  @"只能使用本人的加油卡"


// 我的订单相关
//订单状态
#define     QOrderCreated                           @"已创建"
#define     QOrderNo_Payment                        @"待付款"
#define     QOrderPaying                            @"付款中"
#define     QOrderPayed                             @"已付款"
#define     QOrderNo_Ship                           @"待发货"
#define     QOrderShipped                           @"已发货"
#define     QOrderReceived                          @"已收货"
#define     QOrderFinished                          @"已完成"
#define     QOrderCanceled                          @"已取消"
#define     QOrderReturned                          @"已退款"
#define     QCouponOrderNoCost                      @"未消费"
#define     QCouponOrderCost                        @"已消费"
#define     QCouponOrderDeleted                     @"已删除"


#define     QOrderNoState                           @"暂无状态"

//退款状态
#define     QOrderReceiving                         @"受理中"
#define     QOrderReturnSuc                         @"退款成功"
#define     QOrderReturnRefuse                      @"退款拒绝"
#define     QOrderReturning                         @"退款中"
#define     QOrderReturnFail                        @"退款失败"

//退款确认结果
#define     QOrderReturnConReceiveing               @"受理中"
#define     QOrderReturnConAgree                    @"同意"
#define     QOrderReturnConRefuse                   @"拒绝"

//支付方式
#define     FastPayment                             @"快捷支付"
// <cash on delivery>COD
#define     CashOnDelivery                          @"货到付款"
//送货类型
#define     SelfTakeAway                            @"自提"
#define     Dispatching                             @"配送"


#define     OrderTimeoutText                        @"该订单已失效,请重新下单"
#define     OederHaveReturn                         @"该订单不允许退款..."

#define     ReturnAmountNotNull                     @"退款金额不能为空"
#define     ReturnReasonNotNull                     @"请选择退款原因"
#define     ReturnMemoNotNull                       @"请填写退款说明"
#define     ReturnAmountNotGreaterThanGrand         @"退款金额不能大于商品总额"
#define     ReturnAmountError                       @"输入金额有误请重新输入"
#define     OutOfReturnDate                         @"已超出退款时间"

// 查询缴费记录
#define QueryPayRecordYES                   @"成功"//0
#define QueryPayRecordNO                    @"失败"//1
#define QueryPayRecordRevoke                @"被撤销"//2
#define QueryPayRecordRush                  @"被冲正"//3
#define QueryPayRecordUnusual               @"支付异常"//4
#define QueryPayRecordSallUnusual           @"销售异常"//5


//修改用户信息
#define    STR_PERSON_AVART_UPLOADING                   @"头像上传中..."
#define    STR_PERSON_AVART_UPLOAD_FAIL                 @"头像上传失败"
#define    STR_PERSON_MODIFY_NICKNAME                   @"请输入昵称"
#define    STR_PERSON_MODIFY_NICKNAME_LIMIT             @"昵称最长为24个字"
#define    STR_PERSON_MODIFY_NICKNAME_FAIL              @"修改昵称失败,稍后请重试"

//地址管理
#define    STR_CONSIGNEE_NOT_NULL                       @"收货人姓名不能为空"
#define    STR_CONSIGNEE_RULE                           @"收货人姓名：2-15个字符限制"
#define    STR_DETAIL_NOT_NULL                          @"请输入详细地址"
#define    STR_DETAIL_ADDRESS_RULE                      @"收货人地址：5-60个字符限制"
//#define    STR_CONSIGNEE_LONG

#define    STR_PERSON_CHOOSE_DISTRICT                   @"请选择地区"
#define    STR_PERSON_MODIFY_ADDRESS                    @"请输入地址"
#define    STR_PERSON_MODIFY_ADDRESS_FAIL               @"修改地址失败,稍后请重试"
#define    STR_PERSON_MODIFY_ADDRESS_LIMIT              @"地址长度不能超过50个字"
#define    STR_PERSON_ZIPCODE_EMPTY                     @"邮编不能为空"
#define    STR_PERSON_ZIPCODE_ERROR                     @"请输入正确的邮编"

#define    STR_PERSON_MANAGER_ADDRESS                   @"管理收货地址"
#define    STR_PERSON_NEW_ADDRESS                       @"新建收货地址"
#define    STR_PERSON_DEFAULTS_ADDRESS                  @"默认收货地址"
#define    STR_PERSON_ADDRESS                           @"修改收货地址"
#define    STR_PERSON_CHOOSE_ADDRESS                    @"选择收货地址"

#define    STR_PERSON_MODIFY_SEX_FAIL                   @"修改性别,稍后请重试"

#define    STR_PERSON_MODIFY_SIGIN_LIMIT                @"签名内容不能超过30个字"
#define    STR_PERSON_MODIFY_SIGIN_FAIL                 @"修改签名失败,稍后请重试"

//好友相关
#define     STR_FRIEND_SEARCH_CONTENT_LIMIT             @"搜索内容不能为空"
#define     STR_FRIEND_CANNOT_ADD_SELF                  @"不能加自己为好友"

//新城势卡
#define     STR_CARD_INPUT_ALERT                        @"请输入正确卡号"
#define     STR_CARD_INPUT_NULL                         @"请输入新城势卡号" 
#define     STR_CARD_UNBIND_ALERT                       @"解除绑定成功"
#define     STR_CARD_NUMBER_INPUT_NULL                  @"请输入持卡人证件号"
#define     STR_CARD_INPUT_NAME                         @"请输入持卡人姓名"
#define     STR_CARD_NUMBER                             @"请输入正确的证件号"
#define     STR_CARD_INPUT_NAME_ERROR                   @"请输入正确的姓名"
#define     STR_CARD_INPUT_IDENTIFY_NUM                 @"请输入正确的身份证号"
#define     STR_CARD_PASSWORD_NUM                       @"请输入六位数字密码"
#define     STR_CARD_PASSWORD_NUM_SAME                  @"两次密码输入不一致"

#define     STR_CARD_INPUT_NAME_TOOLONG                 @"输入的证件名字数请小于11位"
#define     STR_ACCOUNTPREPAIDTITLE                     @"账户充值"

//社区相关
#define     STR_COMMUNITY_NO_OFFICE                 @"该社区求助电话还没有"
#define     STR_MYCOMMUNITY_NOTOPEN                 @"我的社区未开通"


// 交互相关
#define    STR_INTERFACE_COMMIT_SUCCESS           @"发表评论成功"
#define    STR_INTERFACE_COMMIT_FAIL              @"发表评论失败"
#define    STR_INTERFACE_DYNAMIC_SUCCESS          @"发表动态成功"
#define    STR_INTERFACE_DYNAMIC_FAIL             @"发表动态失败"
#define    STR_INTERFACE_DYNAMIC_CHECK_LIKED      @"已经点过赞"
#define    STR_INTERFACE_DYNAMIC_LIKES_FAIL       @"点赞失败"

//定位
#define    STR_LOCATION_FAIL                      @"定位失败"




//IM 相关
#define     STR_IM_LOGIN_FAIL                      @"IM服务器登录失败"


//通用支付提示
#define STR_CPPAYIDNO_VALIDATE_ERROR                @"请输入正确的身份证号码"
#define STR_CPPAYVALIDATE_NULL                      @"请输入信用卡有效期"
#define STR_CPPAYCVV2_NULL                          @"请输入信用卡安全码"
#define STR_CPPAYBIND_MOBILE_NULL                   @"请输入持卡人银行预留手机号"
#define STR_CPPAYBIND_MOBILE_ERROR                  @"请输入正确的银行预留手机号"
#define STR_INPUT_WRONG_SMS_CODE                    @"请输入正确的验证码"


#endif

