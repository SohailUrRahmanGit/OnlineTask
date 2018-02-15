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

@property(strong, nonatomic)NSArray *rows;    // Rows will hold data of Rows array present response receicved from a given URL
@property(strong, nonatomic)UITableView *tableView;

@end

