
//
//  ViewController.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MainViewController.h"
#import "ModelClassForParsing.h"
@interface MainViewController ()
@end

@implementation MainViewController
{
    UITableView *tableView;
    UIRefreshControl *refreshController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeServiceCall];

    
    refreshController = [[UIRefreshControl alloc] init];

    _titleArray = [NSMutableArray arrayWithObjects:@"India", @"New Zealand",@"London", @"Germany",@"Saudi", nil];
    _descriptionArray = [NSMutableArray arrayWithObjects:
                         @"Place where i Live",
                         @"Bindog",
                         @"New second-largest state in the Arab world after Algeria. Saudi Arabia is bordered by Jordan and Iraq to the nort",
                         @"Place for tour",
                         @"A moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you" , nil];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 100 ;
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    tableView.rowHeight = UITableViewAutomaticDimension ;

    
    [refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshController];
    
    
    [self.view addSubview:tableView];
    [self setContraints];
    
}
-(void)makeServiceCall
{
    NSURLConnectDelegateClass *testclass = [[NSURLConnectDelegateClass alloc]init];
   
    [testclass fetchURL:[NSURL URLWithString:API_URL] withCompletion:^(NSData *receivedData){
        NSError* error;
        NSString *iso = [[NSString alloc] initWithData:receivedData encoding:NSISOLatin1StringEncoding];
        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
        NSError *pError;

       ModelClassForParsing *  parseData = [MTLJSONAdapter modelOfClass:ModelClassForParsing.class fromJSONDictionary:dict error:&pError];
                NSLog(@"parseData %@", parseData);
        
    } failure:^(NSError *error){
        NSLog(@"%@", error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handle Refresh Method

-(void)handleRefresh : (id)sender
{
    NSLog (@"Pull To Refresh Method Called");
    [refreshController endRefreshing];
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
//    NSString *descriptionString = [_descriptionArray objectAtIndex:indexPath.row];
//    CGRect newFrame = cell.descriptionLabel.frame;
//    newFrame.size.height = [self dynamicHeight:descriptionString :cell.descriptionLabel.font :newFrame :cell.descriptionLabel.lineBreakMode];
//    cell.descriptionLabel.frame = newFrame;
    
    
    
   cell.descriptionLabel.text = [_descriptionArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    // return UITableViewAutomaticDimension;
////    CellForTableView *cell = (CellForTableView *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
////    NSString *descriptionString = [_descriptionArray objectAtIndex:indexPath.row];
////    CGRect newFrame = cell.descriptionLabel.frame;
////    newFrame.size.height = [self dynamicHeight:descriptionString :cell.descriptionLabel.font :newFrame :cell.descriptionLabel.lineBreakMode];
////
////    if(newFrame.size.height >= 50)
////        return 100 + newFrame.size.height ;
////    else
        return 100;
//
}



#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}

//-(NSUInteger) dynamicHeight:(NSString *)descriptionString :(UIFont *)font :(CGRect)cellFrame :(NSLineBreakMode)cellLineBreakMode{
//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    CGSize expectedLabelSize = [descriptionString sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:cellLineBreakMode];
//    //adjust the label the the new height.
//    CGRect newFrame = cellFrame;
//    newFrame.size.height = expectedLabelSize.height;
//    return newFrame.size.height;
//}

@end

