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

/** Title of Content. Eg:"title" **/
@property(nonatomic,copy)NSString *navigationTitle;
/** List of Rows. Eg:"rows" **/
@property(nonatomic,copy)NSArray *rowsArray;

@end

