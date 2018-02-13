//
//  RowModelData.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface RowModelData : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy)NSString *rowTitle;
@property(nonatomic,copy)NSString *rowDescription;
@property(nonatomic,copy)NSString *rowImageURL;
@end
