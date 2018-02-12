
//
//  ViewController.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController
{
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray arrayWithObjects:@"India", @"New Zealand",@"London", @"Germany",@"Saudi", nil];
    _descriptionArray = [NSMutableArray arrayWithObjects:
                         @"Place where i Live",
                         @"Bindog",
                         @"New second-largest state in the Arab world after Algeria. Saudi Arabia is bordered by Jordan and Iraq to the nort",
                         @"Place for tour",
                         @"Officially the Kingdom of Saudi Arabia (KSA),[d] is a sovereign Arab state in Western Asia constituting the bulk of the Arabian Peninsula. With a land area of approximately 2,150,000 km2 (830,000 sq mi), Saudi Arabia is geographically the fifth-largest state in Asia and second-largest state in the Arab world after Algeria. Saudi Arabia is bordered by Jordan and Iraq to the north, Kuwait to the northeast, Qatar, Bahrain and the United Arab Emirates to the east, Oman to the southeast and Yemen to the south. It is separated from Israel and Egypt by the Gulf of Aqaba. It is the only nation with both a Red Sea coast and a Persian Gulf coast and most of its terrain consists of arid desert and mountains" , nil];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    [self.view addSubview:tableView];
    [self setContraints];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SetContraints
-(void)setContraints
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeading   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    NSLayoutConstraint *trail = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraints:@[top,bottom,lead,trail]];
}




#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [_descriptionArray count];
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DataCell";
    
    // Similar to UITableViewCell, but
    CellForTableView *cell = (CellForTableView *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CellForTableView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Just want to test, so I hardcode the data
    NSString *descriptionString = [_descriptionArray objectAtIndex:indexPath.row];
    CGRect newFrame = cell.descriptionLabel.frame;
    newFrame.size.height = [self dynamicHeight:descriptionString :cell.descriptionLabel.font :newFrame :cell.descriptionLabel.lineBreakMode];
    cell.descriptionLabel.frame = newFrame;
    
    cell.descriptionLabel.text = [_descriptionArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // return UITableViewAutomaticDimension;
    CellForTableView *cell = (CellForTableView *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *descriptionString = [_descriptionArray objectAtIndex:indexPath.row];
    CGRect newFrame = cell.descriptionLabel.frame;
    newFrame.size.height = [self dynamicHeight:descriptionString :cell.descriptionLabel.font :newFrame :cell.descriptionLabel.lineBreakMode];
    
    if(newFrame.size.height >= 50)
        return 100 + newFrame.size.height ;
    else
        return 100;
    
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}

-(NSUInteger) dynamicHeight:(NSString *)descriptionString :(UIFont *)font :(CGRect)cellFrame :(NSLineBreakMode)cellLineBreakMode{
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [descriptionString sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:cellLineBreakMode];
    //adjust the label the the new height.
    CGRect newFrame = cellFrame;
    newFrame.size.height = expectedLabelSize.height;
    return newFrame.size.height;
}

@end

