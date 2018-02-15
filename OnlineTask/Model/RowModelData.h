//
//  RowModelData.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

/* Mantle model for Each Row */
@interface RowModelData : MTLModel<MTLJSONSerializing>
/* Title of Row data. Eg."Beavers" */
@property(nonatomic,copy)NSString *rowTitle;
/* Description of Row data. Eg. "Than you might think." */
@property(nonatomic,copy)NSString *rowDescription;
/* Image url string of Row data.Eg: http://icons.iconarchive.com/icons/iconshock/alaska/256/icon.png */
@property(nonatomic,copy)NSString *rowImageURL;
@end

