
//
//  DDCommonAPIConstant.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDCommonAPIConstant.h"

@implementation DDCommonAPIConstant

/** host*/
NSString *const kTJHostAPI = @"http://103.37.160.99";
//NSString *const kTJHostAPI = @"http://192.168.1.111";

#pragma mark - 登录注册部分
/** 获取验证码*/
NSString *const kTJLoginSendCodeAPI = @"/tojoin/api/get_verify_code.php";
/** 注册*/
NSString *const kTJUserRegisterAPI = @"/tojoin/api/register.php";
/** 登录*/
NSString *const kTJUserLoginAPI = @"/tojoin/api/login.php";
/** 第三方登录*/
//#define kTJOtherLoginAPI @"/tojoin/api/other_login.php"
/** 信息完善*/
NSString *const kTJUserInfoEditAPI = @"/tojoin/api/set_user_info.php";
/** 用户详情*/
NSString *const kTJUserInfoDetailAPI = @"/tojoin/api/get_user_info.php";
/** 修改密码*/
NSString *const kTJUserChangePasswordAPI = @"/tojoin/api/update_pwd.php";
/** 忘记密码*/
NSString *const kTJUserFindPasswordAPI = @"/tojoin/api/forget_pwd.php";
/** 上传相册 */
NSString *const kTJUserUploadAlbumAPI = @"/tojoin/api/set_user_photo.php";
/** 用户详情*/
NSString *const kTJOtherUserInfoDetailAPI = @"/tojoin/api/get_otheruser_info.php";
/** 关注用户*/
NSString *const kTJCareOtherUserAPI = @"/tojoin/api/set_like_friend.php";
/** 取消关注用户*/
NSString *const kTJCancelcareOtherUserAPI = @"/tojoin/api/delete_like_friend.php";
/**获取我关注列表*/
NSString *const kTJCareListAPI = @"/tojoin/api/get_like_friend.php";
/**获取关注我列表*/
NSString *const kTJCaredListAPI = @"/tojoin/api/get_belike.php";
/**获取他人关注列表*/
//NSString *const kTJOtherCareListAPI = @"/tojoin/api/get_belike.php";
/**获取他人被关注列表*/
NSString *const kTJOtherCaredListAPI = @"/tojoin/api/get_other_belike.php";
/**上传用户头像*/
NSString *const kTJUpUserHeaderAPI = @"/tojoin/api/set_user_header.php";
#pragma mark - 地址部分
/** 添加地址*/
NSString *const kTJAddAddressAPI = @"/tojoin/api/set_user_addr.php";
/** 修改地址*/
NSString *const kTJEditAddressAPI = @"/tojoin/api/update_user_addr.php";
/** 删除地址*/
NSString *const kTJDeleteAddressAPI = @"/tojoin/api/delete_user_addr.php";
/** 获取地址列表*/
NSString *const kTJGetAddressListAPI = @"/tojoin/api/get_user_addr.php";
/** 设置默认地址*/
NSString *const kTJSetDefaultAddressAPI = @"/tojoin/api/set_default_addr.php";


#pragma mark - 桌子部分
/** 创建桌子*/
NSString *const kTJCreateDeskAPI = @"/tojoin/api/set_table_info.php";
/** 桌子列表*/
NSString *const kTJGetDeskListsAPI = @"/tojoin/api/get_table_list.php";
/** 获取要参加的桌子列表（参加）*/
NSString *const kTJGetJoinedDeskListsAPI = @"/tojoin/api/get_join_table.php";
/** 获取关注的桌子列表（感兴趣）*/
NSString *const kTJGetInterestedDeskListsAPI = @"/tojoin/api/get_like_table.php";
/** banner*/
NSString *const kTJHeaderBannerAPI = @"/tojoin/api/get_banner.php";
/** 获取桌子地图(即一定范围内的活动)*/
NSString *const kTJGetMapRangeDesksAPI = @"/tojoin/api/get_table_map.php";
/** 获取桌子详情*/
NSString *const kTJDetailDeskInfoAPI = @"/tojoin/api/get_table_info.php";
/** 桌主签到桌子*/
NSString *const kTJHosterSignInAPI = @"/tojoin/api/table_sign.php";
/** 参与者签到桌子的二维码*/
NSString *const kTJPartintsSignQRAPI = @"/tojoin/api/get_sign_code.php";
/** 申请加入桌子*/
NSString *const kTJApplyJoinInDeskAPI = @"/tojoin/api/user_in_table.php";
/** 用户通过加入桌子*/
NSString *const kTJUserAcceptJoinDeskAPI = @"/tojoin/api/user_in_table.php?m=join";
/** 参与者签到桌子*/
NSString *const kTJUserSignInDeskAPI = @"/tojoin/api/user_in_table.php?m=sign";
/** 参与者退出桌子*/
NSString *const kTJUserSignOutDeskAPI = @"/tojoin/api/user_in_table.php?m=quit";
/** 桌主审核参与者*/
NSString *const kTJHosterVerifyOthersAPI = @"/tojoin/api/examine_join_table.php";
/** 用户关注桌子*/
NSString *const kTJUserCaredDeskAPI = @"/tojoin/api/set_like_table.php";
/** 用户取消关注桌子*/
NSString *const kTJUserUncaredDeskAPI = @"/tojoin/api/delete_like_table.php";
/** 用户关注桌子列表*/
NSString *const kTJUserCaredDeskListsAPI = @"/tojoin/api/get_like_table.php";
/** 桌子感兴趣的人*/
NSString *const kTJDeskInterestedPeopleAPI = @"/tojoin/api/get_table_like.php";
/** 桌子申请的用户*/
NSString *const kTJDeskApplyPeopleAPI = @"/tojoin/api/get_table_wait.php";
/** 收到的桌子邀请*/
NSString *const kTJReceiveDeskInviteListAPI = @"/tojoin/api/get_table_invite.php";
/** 邀请好友页面*/
NSString *const kTJDeskInviteFriedAPI = @"/tojoin/api/invitation_friend.php";
/** 邀请好友加入桌子*/
NSString *const kTJInviteFriedsJoinDeskAPI = @"/tojoin/api/send_invitation.php";
/** 桌主发送公告*/
NSString *const kTJHosterSendNoticeAPI = @"/tojoin/api/send_notice.php";
/** 获取券的信息*/
NSString *const kTJTicketsInfoAPI = @"/tojoin/api/get_prop.php";



/** 获取用户未读消息条数*/
NSString *const kTJUserMessageNumAPI = @"/tojoin/api/get_msg_num.php";
/** 获取用户消息列表*/
NSString *const kTJUserMessageListsAPI = @"/tojoin/api/get_msg_list.php";
/** 获取用户消息具体内容*/
NSString *const kTJUserMessageContentAPI = @"/tojoin/api/receive_msg.php";
/** 用户删除消息*/
NSString *const kTJUserDeleteMessageAPI = @"/tojoin/api/delete_msg.php";
/** 获取用户充值消息*/
NSString *const kTJUserRechargeMessageAPI = @"/tojoin/api/get_user_deposit.php";
/** 获取打赏记录*/
NSString *const kTJUserRewardRecordAPI = @"/tojoin/api/get_user_be_praised.php";
/** 获取他人打赏记录*/
NSString *const kTJUserRewardOthersRecordAPI = @"/tojoin/api/get_other_be_praised.php";
/** 获取标签列表*/
NSString *const kTJUserLabelListsAPI = @"/tojoin/api/get_label_list.php";
/** 获取好友列表*/
NSString *const kTJUserFriendListsAPI = @"/tojoin/api/get_friend_list.php";




/** 系统消息*/
NSString *const MSG_TYPE_SYS = @"1";
/** 打赏通知*/
NSString *const MSG_TYPE_REWORD = @"2";
/** 我的关注*/
NSString *const MSG_TYPE_ATTENTION = @"3";
/** 申请回复*/
NSString *const MSG_TYPE_APPLY = @"4";
/** 邀请我加入的*/
NSString *const MSG_TYPE_INVITE = @"5";
/** 桌主消息*/
NSString *const MSG_TYPE_HOST = @"7";
/** 参加桌子消息*/
NSString *const MSG_TYPE_JOIN = @"8";
/** 好友申请*/
NSString *const MSG_TYPE_ADDFRIEND = @"9";

@end












