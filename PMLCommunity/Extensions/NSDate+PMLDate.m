//
//  NSDate+PMLDate.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "NSDate+PMLDate.h"

@implementation NSDate(PMLDate)

+ (NSString *)updateTimeForRow:(NSString *)createTimeString {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [createTimeString longLongValue] / 1000;
    // 计算时间差
    NSTimeInterval time = currentTime - createTime;
    //如果时间小于60秒 显示 刚刚
    if (time < 60) {
        long long timeSec = time;
        NSString *string = [NSString stringWithFormat:@"%lld秒前",timeSec];
        return string;
    }
    //如果时间大于60秒  小于60分钟  显示多少分钟前
    long long sec = time/60;
    if (sec<60) {
        return [NSString stringWithFormat:@"%lld分钟前",sec];
    }
    //如果时间 小于24小时  显示多少小时前
    // 秒转小时
    long long hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%lld小时前",hours];
    }
    //如果时间大于24小时  小于30天  显示年月日  时间格式自己定 （也可以显示多少天之前  此处注释掉了）
    //秒转天数
    long long days = time/3600/24;
    if (days < 30) {

        NSString * timeString = createTimeString;
        NSTimeInterval interval=[timeString longLongValue] / 1000.0;
        NSDate *conTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter* format = [NSDateFormatter new];
        [format setDateFormat:@"MM-dd HH:mm"];
        NSString* times = [format stringFromDate:conTimesp];
        return times;
        //        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //如果时间大于30天  小于12个月  显示时间格式
    //秒转月
    NSString * timeString = createTimeString;
    NSTimeInterval interval=[timeString longLongValue] / 1000.0;
    NSDate *conTimesp = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter* format = [NSDateFormatter new];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSString* times = [format stringFromDate:conTimesp];
    return times;
}
@end
