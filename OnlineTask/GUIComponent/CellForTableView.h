//
//  CellForTableView.h
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForTableView : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel; /*cell's Title table*/
@property (nonatomic, strong) UILabel *descriptionLabel; /*cell's Description Label*/
@property (nonatomic,strong) UIImageView *imageForTitle; /*Cell's image view*/
@end
