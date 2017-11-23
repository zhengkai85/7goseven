//
//  UserViewMode.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"


@interface UserViewMode : NSObject


- (instancetype)initWitDic:(NSDictionary*)dic;

@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *score1;
@property (nonatomic, strong)NSString *avatar128;
@property (nonatomic, strong)NSString *role_id;
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *computer_name;
@property (nonatomic, strong)NSString *computer_id;

//@property (nonatomic, strong)NSString *avatar512;
//@property (nonatomic, strong)NSString *city;
//@property (nonatomic, strong)NSString *district;
//@property (nonatomic, strong)NSString *email;
//@property (nonatomic, strong)NSArray *expand_info;
//@property (nonatomic, strong)NSString *fans;
//@property (nonatomic, strong)NSString *following;
//@property (nonatomic, strong)NSString *is_admin;
//@property (nonatomic, strong)NSString *is_followed;
//@property (nonatomic, strong)NSString *is_following;
//@property (nonatomic, strong)NSString *is_self;
//@property (nonatomic, strong)NSDictionary *level;
//@property (nonatomic, strong)NSString *message_unread_count;
//@property (nonatomic, strong)NSString *mobile;
//@property (nonatomic, strong)NSString *now_shop_score;
//@property (nonatomic, strong)NSString *pos_city;
//@property (nonatomic, strong)NSString *pos_district;
//@property (nonatomic, strong)NSString *pos_province;
//@property (nonatomic, strong)NSString *province;
//@property (nonatomic, strong)NSArray *rank_link;
//@property (nonatomic, strong)NSString *real_nickname;
//@property (nonatomic, strong)NSString *realname;
//@property (nonatomic, strong)NSString *score1;
//@property (nonatomic, strong)NSString *score2;
//@property (nonatomic, strong)NSString *score3;
//@property (nonatomic, strong)NSString *score4;
//@property (nonatomic, strong)NSString *sex;
//@property (nonatomic, strong)NSString *signature;
//@property (nonatomic, strong)NSArray *tags;
//@property (nonatomic, strong)NSString *title;
//@property (nonatomic, strong)NSArray *user_group;
//@property (nonatomic, strong)NSString *username;
//@property (nonatomic, strong)NSString *weibocount;


@end
