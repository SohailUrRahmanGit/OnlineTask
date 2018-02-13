//
//  RowModelData.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "RowModelData.h"

@implementation RowModelData
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"rowTitle" : @"title",
             @"rowDescription" : @"description",
             @"rowImageURL" :@"imageHref"
             };
}
@end
