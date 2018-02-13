//
//  CellForTableView.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "CellForTableView.h"

@implementation CellForTableView

@synthesize descriptionLabel = _descriptionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        
        
        self.imageForTitle = [[UIImageView alloc]init];
        [self.imageForTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.imageForTitle];
        [self addContraintsForImageForTitle];

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.textColor = [UIColor blackColor];
       self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
        self.descriptionLabel.numberOfLines = 0;
        
        
        //self.descriptionLabel.word
        /*
         
         cell.textLabel.font = [UIFontboldSystemFontOfSize:14];
         

         CGSize expectedLabelSize = [yourString sizeWithFont:yourLabel.font constrainedToSize:maximumLabelSize lineBreakMode:yourLabel.lineBreakMode];
         
         //adjust the label the the new height.
         CGRect newFrame = yourLabel.frame;
         newFrame.size.height = expectedLabelSize.height;
         yourLabel.frame = newFrame;
         */
        
        [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.descriptionLabel];
        
        [self addContraintsForTitleLabel];
        [self addContraintsForDescriptionLabel];

    }
    return self;
}

-(void)addContraintsForImageForTitle
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.imageForTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:8];
    
    NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:self.imageForTitle attribute:NSLayoutAttributeLeading   relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.imageForTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.imageForTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:85];
    
    [self addConstraints:@[top, lead,height,width]];
    
}

-(void)addContraintsForTitleLabel
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    
    
    NSLayoutConstraint *lead =  [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.imageForTitle attribute:NSLayoutAttributeRight
                                                              multiplier:1.0 constant:10];
    
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
    
    [self addConstraints:@[top,lead,height,width]];
    
    
}

-(void)addContraintsForDescriptionLabel
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    
    NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:self.descriptionLabel
                                                               attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.imageForTitle attribute:NSLayoutAttributeRight
                                                              multiplier:1.0 constant:10];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
    

    
    [self addConstraints:@[top,lead,width]];
    
    
}



@end

