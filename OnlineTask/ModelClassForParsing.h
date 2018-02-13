//
//  ModelClassForParsing.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 13/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface ModelClassForParsing : MTLModel<MTLJSONSerializing>

@property(nonatomic,copy)NSString *navigationTitle;
@property(nonatomic,copy)NSArray *rowsArray;

@end
