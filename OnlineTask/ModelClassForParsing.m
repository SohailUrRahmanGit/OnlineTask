//
//  ModelClassForParsing.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "ModelClassForParsing.h"

@implementation ModelClassForParsing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
        return @{
                 @"navigationTitle" : @"title",
                 @"rowsArray" : @"rows"
                 };
}
    


@end
