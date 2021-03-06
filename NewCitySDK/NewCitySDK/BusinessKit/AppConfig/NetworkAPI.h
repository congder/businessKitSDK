//
//  NetworkAPI.h
//  iOSAppFramework
//
//  Created by kongjun on 14-5-22.
//  Copyright (c) 2014年 Shenghuotong. All rights reserved.
//

#ifndef iOSAppFramework_NetworkAPI_h
#define iOSAppFramework_NetworkAPI_h

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

////SIT 外网(因特网) ip配置
#define kBaseURL                                @"http://test-appsrv-sit.sct360.com:8082/"
#define kBaseWithMoive                          @"http://test-appgw-sit.sct360.com:8101"
#define HHtmlBaseURL                            @"http://test-appsrv-sit.sct360.com:8082/html5/"
#define kActivityURL                            @"http://online-ac.shenghuo.com/"



//冒烟 外网(因特网) ip配置
//#define kBaseURL                                @"http://test-appsrv-smk.sct360.com:8102/"
//#define HHtmlBaseURL                            @"http://test-appsrv-smk.sct360.com:8102/html5"
//#define kBaseWithMoive                          @"http://test-appgw-smk.sct360.com:8098"
//#define kActivityURL                            @"http://172.16.6.82:8980/"
//////
//////
//#define kBaseWithMoive                          @"http://192.168.12.206:8080"

//////冒烟 ip配置
////
//#define kBaseURL                                @"http://172.16.6.83/"
//#define HHtmlBaseURL                            @"http://172.16.6.83/html5"
//// 电影测试
//#define kBaseWithMoive                          @"http://172.16.6.82:8080"
//#define kActivityURL                            @"http://172.16.6.82:8980/"
//


//生产/SIT ip配置
//电影生产
//#define kBaseWithMoive                          @"https://appgw.sct360.com/"
//////亚联环境<生产、SIT>
//#define kBaseURL                                @"https://appsrv.sct360.com/"
//#define HHtmlBaseURL                            @"https://appsrv.sct360.com/html5/"
//#define kActivityURL                            @"https://online-ac.sct360.com/"
//


//#define kIMServer                               ServerTypeTest

//#define kBaseURL                                @"http://172.16.6.84/"
//#define HHtmlBaseURL                            @"http://172.16.6.84/html5"

//电影SIT
//#define kBaseWithMoive                          @"http://124.202.135.196:8084"

//#define kBaseURL                                @"http://172.16.6.84/"
//#define HHtmlBaseURL                            @"http://172.16.6.84/html5"

//电影SIT
//#define kBaseWithMoive                          @"http://124.202.135.196:8084"


//#define kActivityURL                            @"http://192.168.12.206:8080/"

//首页按钮 轮播图
#define kBaseHomePage                           @"http://124.202.135.196:8098"

#define HAppInit                                @"/app/init"
#define HAppVersionUpdate                       @"/app/version"

#define HAppUpdateVersion                       @"/app/updateversion"
#define HAppUserCheckLogin                      @"/user/checkLogin"
#define HAppUserCheckLogout                     @"/user/logout"

#define HAppRegionLbs                           @"/region/lbs"
#define HAppRegionCityList                      @"/region/cityList"
#define HAppRegionCommunityListList             @"/region/communityList"
#define HUserSetDefaultCommunity                @"/user/setCommunity"

#define HAppNewsList                            @"/news/list"
#define HAppTeamGetHotList                      @"/team/getHotList"//获取热门小组
#define HAppCommunityDynamic                    @"/community/dynamic"

#define HAppDynamiLlist                         @"/communityservice/list"

#define HAppDynamicDetail                       @"/dynamic/detail"
#define HAppDeleteDynamic                       @"/dynamic/delDynamic"
#define HAppMsgList                             @"/msg/list"
#define HAppDynamicAddComment                   @"/dynamic/addComment"
#define HAppDynamicCommentList                  @"/dynamic/commentList"

#define HAppDynamicCheckLiked                   @"/dynamic/checkliked"
#define HAppDynamicLikes                        @"/dynamic/likes"
#define HAppDynamicDelComment                   @"/dynamic/delComment"

#define HAppPhotoIndex                          @"/photo/index"

#define HAppNewsBannerList                      @"/news/bannerList"
#define HAppNewsCheckLike                       @"/news/checkliked"

// 首页动态请求图标
#define MainDynamicFunctionList                 @"/column/list"

#define HAppNewsCommentList                     @"/news/commentList"
#define HAppNewsAddComment                      @"/news/addComment"
#define HAppCommunityPubDynamic                 @"/community/pubDynamic"
#define HAppCommunityCreateDynamic              @"/dynamic/publish"

#define HAppUserSearch                          @"/user/search"
#define HAppFriendAdd                           @"/friend/add"
#define HAppFriendList                          @"/friend/list"
#define HAppFriendDelete                        @"/friend/delete"

//好友验证
#define HAppAskFriendList                       @"/friend/newlist"
#define HAppConfirmFriend                       @"/friend/confirm"

#define HAppFriendRemark                        @"/friend/setRemarkName"
#define HAppFriendInfo                          @"/friend/info"
#define HAppUserSetAvatar                       @"/user/setAvatar"
#define HAppUserSetNickname                     @"/user/setNickname"
#define HAppUserUpdateInfo                      @"/user/updateInfo"
#define HAppUserOfficeHolder                    @"/user/officeholder"

//群组
#define HAppGroupGetList                        @"/team/myTeam"
#define HAppGroupCreate                         @"/team/create"
#define HAppGroupGetInfo                        @"/team/info"
#define HAppGroupNameModify                     @"/team/setTeamname"
#define HAppGroupAddUser                        @"/team/addUser"
#define HAppGroupDeleteUser                     @"/team/delUser"
#define HAppGroupInfoSetting                    @"/team/userSetting"
#define HAppGroupLogout                         @"/team/logout"

#define HAppNewsLikes                           @"/news/likes"

#define HAppSmsCodeSend                         @"/sms/code/send"
#define HAppUserRegistry                        @"/user/registry"
#define HAppUserLogin                           @"/user/login"
#define HAppUserCheckphonenum                   @"/user/Checkphonenum"
#define HAppUserResetPwd                        @"/user/resetPassword"

// 测试
#define TestAddress                             @"/sht/BusServlet"
// 公交一卡通相关
#define GetNoticeList                           @"/trafficcard/list"
#define GetConsumeRecordList                    @"/bus/consume"
#define GetchargeRecordList                     @"/bus/recharge"

//办卡指南
//#define Cardguide                               @"/bus/help.html"
#define Cardguide                               @"/news/singlepage?caregory_code=bkzn"

//快捷支付协议
#define FastPaymentProtocol                     @"/news/singlepage?caregory_code=llzfxy"

//银行卡解除绑定
#define UnbindingBank                           @"/service/PTSurdPayApply"
//银行卡列表查询
#define SERVICEPTQRYSIGNPAYCARDLIST             @"/service/PTQrySignPayCardList"
//银行卡卡BAN
#define SERVICEPTQRYCARDBIN                     @"/service/PTQryCardBin"
//支付验证 获取令牌
#define SERVICEORDERPAY                         @"/service/orderPay"
//订单签约支付验证
#define SERVICEORDERPAYVALIDATE                 @"/service/orderPayValidate"
//支付验证码
#define SERVICEPTSMSVERIFICATION                @"/service/PTSmsVerification"

//账户充值订单
#define SERVICEPTTHRDORGTOPUPRGST               @"/service/PTThrdOrgTopupRgst"
//充值支付  获取令牌
#define SERVICEPTSIGNPAYMENT                    @"/service/PTSignPayment"
//支付验证 PTSignPayVerification
#define SERVICEPTSIGNPAYVERIFICATION            @"/service/PTSignPayVerification"

// 缴费相关---------

// 缴费机构城市查询
#define PAYMENTJIGOUSELECT                      @"/app_gw/film/npp/YL01"
// 查询缴费事业单位的缴费信息
#define PAYMENTUNITSELECT                       @"/app_gw/film/npp/YL02"
// 订单流水查询
#define PAYMENTORDERSELECT                      @"/app_gw/film/npp/YL04"
// 水费支付
#define PAYMENTWARTER                           @"/app_gw/film/npp/YL03"
// 水费签约支付
#define PAYMENTAPPWARTER                        @"/app_gw/film/npp/YL05"
// 水费签约支付验证
#define PAYMENTAPPWARTERVALIDATE                @"/app_gw/film/npp/YL06"
// 缴费号码交易查询
#define PAYMENTAPPQUERYCardNo                   @"/app_gw/film/npp/YL07"
// 缴费号码交易查询
#define PaymentRequestOrderInfo                 @"/app_gw/film/npp/YL09"
// 缴费号码交易查询
#define PaymentNotifiyServer                    @"/app_gw/film/npp/YL10"
// 商圈支付异步通知
#define PTCommonAsynNotify                      @"/app_gw/film/bip/PTCommonAsynNotify"

//手机号充值
#define SERVICEPTPHONEJIAOFEI                   @"/mobile/paymentby19paychannelservice"
//缴费机构查询
#define PAYMENTSEARCHJIGOU                      @"/payment/querypayorglist"
//手机号码归属地查询
#define  PAYMENTQueryBelongsTophone             @"/mobile/attribution"
//手机充值面值查询
#define  PAYMENTPayPhonePrice                   @"/mobile/queryBill"
//话费充值查询
#define  PayPhoneErecord                        @"/businesspaymentinfo"
//欠费账单查询   cardid参数
//#define PAYMENTSEARCHBILL                       @"payment/searchBillNoOrg"
#define PAYMENTSEARCHBILL                       @"/payment/searchBillHasOrg"

//缴费记录查询 cardid参数
#define PAYMENTBUSINESSINFO                     @"/businesspaymentinfo"

//查询缴费机构信息  province  city  paymentType 参数
#define PAYMENTQUERYPAYORGLIST                  @"/payment/querypayorglist"

//获取缴费单位列表
#define PAYMENTKEEPERLIST                       @"/payment/keeperlist"

//添加缴费绑定   uid  bill_type  bill_key  bill_user  bill_county  bill_accept_code  bill_charge_code  bill_charge_name  bill_bind_type  参数
#define PAYMENTGIANTKEEPERADD                   @"/payment/giantkeeperadd"

//删除缴费绑定  uid   bill_keeper_id  参数
#define PAYMENTGIANKEEPERDELE                   @"/payment/giantkeeperdel"

//查询用户综合信息  cardid
#define PAYMENTGETUSERDETAILNFO                 @"/payment/getuserdetailinfo"

//根据第三方客户编码查询缴费账单
#define DATONGWATERQUERYBILL                    @"/service/datongWaterQueryBillFromThirdService"
#define DATONGTELEVISIONQUERY                   @"/service/datongTelevisionQueryBillFromThirdService"
//查询缴费城市
#define PAYMENTCHANGECITY                      @"/service/storecategorya"
// 水费支付
#define WaterPayment                            @"/service/datongWaterPaymentByChannelService"
//有线电视费
#define TelevisionPayment                       @"/service/datongTelevisionPaymentByChannelService"


//商圈店铺列表  udid  reqnum   pageflag   参数
#define SERVICESTORELIST                        @"/service/storelist"
//商品详情
#define SERVICESTORXIANGQIN                     @"/service/queryWebProductInfo"
//店铺分类列表  udid
#define SERVICESTORECATEGORY                    @"/service/storecategory"

//创建订单
#define SALESBATCHCREATE                        @"/sales/batchcreate"


//我的订单
#define GETMYORDERLISTREQUEST                   @"/app_gw/film/rrb/searchOrderTypeList"

//第三方通讯录
#define HANDLEADDRESSBOOK                       @"/app_gw/film/txl/handleAddressBook"

//积分商城产生用户信息
#define MallGenerateUserLonginInfo              @"/app_gw/film/online/generateUserLoginInfo"
#define MallGetBsnSysAccessUrl                  @"/app_gw/film/online/getBsnSysAccessUrl"
#define MallProcessMngContactReq                @"/app_gw/film/online/processMngContactReq"

//优惠价格查询
#define SalesQueryDiscounyAmount                @"/sales/salesQueryDiscountAmount"
// 销售订单列表查询
#define SalesInfoList                           @"/sales/infoQuery"
//销售订单明细查询
#define SalesItemQuery                          @"/sales/itemQuery"
//查询待支付订单信息
#define  CheckPTQryCommonToBePaidInfo            @"/app_gw/film/bip/PTQryCommonToBePaidInfo"

//我的订单-退款申请
#define SalesReturnRequest                      @"/sales/returnRequest"
//我的订单-退款订单列表查询
#define SalesReturnListQuery                    @"/sales/returnListQuery"
//确认收货
#define DeliveryGoods                           @"/app_gw/film/bip/deliveryGoods"
//退款订单明细查询
#define SalesReturnItemQuery                    @"/sales/returnItemQuery"
// 取消订单
#define CancelOrder                             @"/service/orderCancel"
// 查看积分账户详情
#define QueryIntrgralAccountDetails             @"/service/searchIntegralAccountTransDetails"
// 查看积分账户
#define QueryIntrgralAccount                    @"/service/searchIntegralAccount"
// 查看线上积分账户
#define QueryIntegralAccountOnLine              @"/service/searchIntegralAccountListPageOnLine"
#define QueryIntegralAccountOffLine             @"/service/searchIntegralAccountListPageOffLine"



//新的查阅积分账户的查询
#define QueryNewTotalIntegralAccount            @"/app_gw/film/bip/searchIntegralAccountTransDetailsALL"

//我的市民卡
// 交易记录列表
#define TradeManagerList                        @"/my/orderList"
//绑定手机号码
#define BindingPhoneNum                         @"/mobile/rebind"


// 关于"我的地址"
#define GetRegionList                           @"/region/list"
// 地址操作
#define GetAddressList                          @"/address/getlist"
#define AddAddress                              @"/address/add"
// 新增
#define DeleteAddress                           @"/address/delete"
#define UpdateAddress                           @"/address/update"
#define SetDefaultsAddress                      @"/address/setDefault"
#define GetDefaultsAddrsss                      @"/address/getDefault"

//特惠商品列表/商品咨询列表
#define StoreProductList                        @"/service/querywebproductlist"
//获取商家详情
#define StoreInfo                               @"/service/storeinfo"
// 商品资讯明细查询,商圈-根据产品编号查询商品详情
#define SERVICEQUERYWEBPRODUCTINFO              @"/service/queryWebProductInfo"

//获取加密随机数
#define APPRANDOM                               @"/app/random"

//查询是否设置交易密码
#define USERQUERYISTRADINGPASSWORD              @"/user/queryIsTradingPassword"

//更新交易密码
#define USERUPDATETRADINGPASSWORD               @"/user/updateTradingPassword"

//设置交易密码
#define USERSETTRADINGPASSWORD                  @"/user/setTradingPassword"

//重置密码
#define USERRESETTRADINGPASSWORD                @"/user/resetTradingPassword"



//电影相关

//人人保险相关
#define APPSERVERRRBWEBURL                      @"/app_gw/film/rrb/ReqThreeWebUrl"
/****人人保险产品入口参数****/
#define RRBWEBURLGETINTYPEOFPRODUCT             @"rrProduct"
/*******人人保险产品列表订单入口参数**********/
#define RRBWEBURLGETINTYPEOFLIST                @"rrOrderList"
//影院详情

#define APPSERVERCINEMAINFO                     @"/app_gw/film/cinema/cinemaInfo"
//城市列表
#define APPSERVERCITYINFO                       @"/app_gw/film/position/cityinfo"
//地区列表
#define APPSERVERDISTRICTINFO                   @"/app_gw/film/position/districtinfo"
//根据城市对应查询影院列表
#define APPSERVERCINEMAQUERY                    @"/app_gw/film/cinema/cinemaQuery"
//影片详情
#define APPSERVERMOVIEINFO                      @"/app_gw/film/movie/movieInfo"
//影片列表
#define APPSERVERMOVIEQUERY                     @"/app_gw/film/movie/movieQuery"
//查询即将上映的电影
#define APPSERVERMOVIEABOUTQUERY                @"/app_gw/film/movie/movieAboutQuery"
//根据电影查询影院
#define APPSERVERQUERYCINEMAS                   @"/app_gw/film/movie/queryCinemasByMovieId"
//根据影院查影片
#define APPSERVERQUERYCINEMAID                  @"/app_gw/film/movie/queryAllMoviesByCinemaId"
//根据影院名称查询影院列表
#define APPSERVERQUERYCINEMANAME                @"/app_gw/film/movie/queryCinemasByCinemaName"
//场次详情 档期查询
#define APPSERVERSCHEDULES                      @"/app_gw/film/goods/queryMovieSchedules"
//电影订单列表
#define AppServerOrderList                      @"/app_gw/film/order/orderListQuery"
//电影订单明细
#define AppServerOrderDetailQuery               @"/app_gw/film/order/orderDetailQuery"
//新支付已下单电影票的支付信息
#define AppServerResultQueryPayOrderInfo        @"/app_gw/film/pay/queryPayOrderInfo"

//电影座位
#define APPSERVERSEATQUERY                      @"/app_gw/film/cinema/seatQuery"
//选座创建订单
#define APPSERVERSORDERCRESTE                   @"/app_gw/film/pay/createOrder"
//查询kabin
#define APPSERVERQRYCARDBIN                     @"/app_gw/film/pay/qryCardBin"
//签约支付
#define APPSERVERPAYORDER                       @"/app_gw/film/pay/payOrder"
//电影银行卡bin查询
#define APPSERVERCARDBIN                        @"/app_gw/film/pay/qryCardBin"
//电影银行卡列表
#define APPSERVERCARDLIST                       @"/app_gw/film/pay/payCardList"
//重发短信
#define APPSERVERVERIFICATION                   @"/app_gw/film/pay/smsVerification"
//cinema/orderConfirm
// 签约支付验证
#define APPSERVERVERCINEMAORSERCONFIRM          @"/app_gw/film/cinema/orderConfirm"
//电影票新支付支付完成异步通知
#define APPSERVERPAYORDERCONFIRM                @"/app_gw/film/pay/payOrderConfirm"

// 出租车扫码支付
// 车主信息详情查询
#define QUERYTAXIOWNERINFO                      @"/app_gw/film/taxi/queryTaxiOwnerInfo"
// 查询支付方式列表
#define QUERYPAYMENTTYPE                        @"/app_gw/film/payment/queryPaymentType"
// 扫码支付
#define CODESTOPAY                              @"/app_gw/film/codepay/codesToPay"
// 查询支付交易记录
#define QUERYRECORDS                            @"/app_gw/film/qtr/queryRecords"
// 卡券订单列表查询
#define QUERYCARDORDERINFO                      @"/app_gw/film/bip/CardOrderInfoQuery"
#define QUERYCARDORDERITEM                      @"/app_gw/film/bip/CardOrderItemQuery"
#define CARDCUSTOME                             @"/app_gw/film/bip/CardCustome"
#define SOFTDELETEORDER                         @"/app_gw/film/bip/SoftDeleteOrder"
//电影票删除订单
#define MOVIETICKETDELETE                       @"/app_gw/film/newcityfilm/deleteFilmOrder"
//首页轮播图
#define QueryHomeScrollImage                    @"/app_gw/film/get_scroll_img/query"
#define QueryHomeMenu                           @"/app_gw/film/get_menu_list/query"
//根据uid获取绑定城势卡的核算机构号
#define GetAccountingId                         @"/app_gw/film/bip/getAccountingOrgId"
//获取首页显示所需全部信息
#define GetHomePageShow                         @"/app_gw/film/get_menu_list/getAppHomePageShowMenu"

//微信分享优惠券
#define WXShareCoupon                           @"weixin/share/couponInfo"
//微信分享实物商品
#define WXShareProduct                          @"weixin/share/goodsInfo"
//微信分享店铺
#define WXShareStore                            @"weixin/share/sellerDetail"


#define HAppUserAccountCardCheck                @"/account/card/check"
#define HAppUserAccountCardSendMsg              @"/account/card/sendmsg"
#define HAppUserAccountCardBind                 @"/account/card/bind"
#define HAppUserAccountCardList                 @"/account/card/list"
#define HAppUserAccountCardUnbind               @"/account/card/unbind"
#define HAppUserAccountCardBalance              @"/account/card/balance"

#define HAppUserAccountBillList                 @"/account/bill/list"
#define HAppUserAccountBillDetail               @"/account/bill/detail"
#define HAPPUserAccountBillPay                  @"/account/bill/pay"
#define HAppUserAccountTradeList                @"/account/trade/list"   //

#define HCardInfoDetail                         @"/app_gw/film/bip/getCityCardInfoDetail"

#define COLOR(r,g,b,a)                          [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
//所有HTML5URL
//健康管理
#define HHealthManager                          @"/health/index.html"//@"/html/dist/health/index.html"
//生活周边
#define HCommunitySurrounding                   @"/business/index.html"// @"/test/index.html"//
//社区超市
#define HCommunityBusinessOnline                @"/shop/index.html"//@"/html/dist/business/shop.html"
//银行理财
#define HBankFinancing                          @"/financial/index.html"//@"html/dist/money/index.php"
// 办事指南
#define ServieGuide                             @"/work/index.html"

// 教育
#define EducationURl                            @"/video/index.html"
// 物业服务
#define RealtyServieURL                         @"http://www.skyshow.cn:8082/cloud/pages/html5/communityIsExist/communityIsExistClient.jsp?"
//小马金融
//#define PonyFinancialURL                        @"http://www.xmjr.com/?extends=yalian"
#define PonyFinancialURL                        @"https://m.xmjr.com/router/regist?CHANNEL=YaLian&ACTIVITY=YLian1151201"

//健康
#define HHealthURL                              @"http://health.shenghuo.com"


//用户协议
#define HUserAgreement                          @"/html5/dist/agreement/index.html"
//关于我们
#define HAboutUsHtml                            @"HTML5/setting/about.html"
//缴费机构用户协议
#define HSINGLEPAGECAREGORY                     @"news/singlepage?caregory_code=ggsyjf"
#define HINTEGRALRULE                           @"news/integral"

//抽奖活动入口
#define HGetActivityCtrlInfo                     @"/online_activity/get_active_ctrl_info.do"

//通用支付下单接口
#define CCommonPayPayOrder                       @"/app_gw/online_bsn/pay/receivePayOrder"
//通用支付查询银行卡列表
#define CCommonPayQryBindCardList                @"/app_gw/online_bsn/pay/qryUserBindBankCardList"
//通用支付查询银行卡卡信息
#define CCommonPayQryBankCardInfo                @"/app_gw/online_bsn/pay/qryBankCardBankInfo"
//通用支付支付签约
#define CCommonPayQryPaySign                     @"/app_gw/online_bsn/pay/paySign"
//通用支付支付校验
#define CCommonPayQryPayCheck                    @"/app_gw/online_bsn/pay/payCheck"
//通用支付支付校验重发验证码
#define CCommonPayQryReSendPayVerifyCode         @"/app_gw/online_bsn/pay/reSendPayVerifyCode"
//查询商户订单支持的银行列表
#define CCommonPayQryOrderSupBankList            @"/app_gw/online_bsn/pay/qryOrderSupBankList"
//通用支付进行银行卡解约
#define CCommonPayUnbindBankCard                 @"/app_gw/online_bsn/pay/unbindBankCard"

#endif
