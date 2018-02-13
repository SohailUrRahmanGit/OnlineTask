//
//  ViewController.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellForTableView.h"
#import "NSURLConnectDelegateClass.h"
#import "Constants.h"
@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray *titleArray;
@property(strong, nonatomic)NSMutableArray *descriptionArray;

@end

