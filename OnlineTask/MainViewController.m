
//
//  ViewController.m
//  OnlineTask
//
//  Created by SOHAIL UR RAHMAN on 12/02/18.
//  Copyright © 2018 SOHAIL UR RAHMAN. All rights reserved.
//

#import "MainViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelClassForParsing.h"
#import "RowModelData.h"

@interface MainViewController ()
@end

@implementation MainViewController
{
    /*
     Used to handle refresh when table is swiped down
     */
    UIRefreshControl *refreshController;
}
@synthesize tableView;


/*
Loads the view and adds the table view. Also calls for service when ever view is loaded
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeServiceCall];
    refreshController = [[UIRefreshControl alloc] init];
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = TABLEVIEW_ROW_ESTIMATE_HEIGHT ;
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    tableView.rowHeight = UITableViewAutomaticDimension ;
    
    [refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshController];
    
    
    [self.view addSubview:tableView];
    [self setContraints];
    
}

/*
 -creates a connection delegate and calls fetch url method.
 -API_URL is a constant which hold the url.You can have the value of API_URL in Constants.h file
 -ModelClass for parsing is uses Mantle API for parsing and create a model of the response
 -MAntel a model layer framework which assists with mapping JSON to models and vice versa.
 */
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
        _rows = parseData.rowsArray;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.title = parseData.navigationTitle;
            [tableView reloadData];
        });
        
    } failure:^(NSError *error){
         dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Server Error"
                                                                       message:[NSString stringWithFormat:@"%@",error]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
         });

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 Handle Refresh method is called when table is refreshed it calles the URL request and reloads the data from service
 */
#pragma mark - Handle Refresh Method
-(void)handleRefresh : (id)sender
{
    [self makeServiceCall];
    [refreshController endRefreshing];
}

/*
 Programatical constraints set to table view. Table view Top,Lead,Trail,Bottom are pinned to the super view
 */
#pragma mark - SetContraints
-(void)setContraints
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeading   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    NSLayoutConstraint *trail = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraints:@[top,bottom,lead,trail]];
}


#pragma mark - UITableViewDelegate
/* number of section(s), now I assume there is only 1 section */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}
/*  number of row in the section, I assume there is only 1 row */
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [_rows count];
}
/* the cell will be returned to the tableView */
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = TABLEVIEW_CELL_ID;
    RowModelData *dataFromRowArray = _rows [indexPath.row];
    CellForTableView *cell = (CellForTableView *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[CellForTableView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.imageForTitle sd_setImageWithURL:[NSURL URLWithString:dataFromRowArray.rowImageURL]
                          placeholderImage:[UIImage imageNamed:@"NoPicAvailable"]];
    cell.descriptionLabel.text = dataFromRowArray.rowDescription;
    cell.titleLabel.text = dataFromRowArray.rowTitle;
    return cell;
}

/* Set the cell height according to the size of description text */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    CellForTableView *cell = (CellForTableView *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.descriptionLabel.text;
    height = [text sizeWithFont:[UIFont systemFontOfSize:10.0f] constrainedToSize:CGSizeMake(240, 300) lineBreakMode:NSLineBreakByWordWrapping].height;
    return height+85;
    
}
/* when user tap the row, what action you want to perform */
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}


@end

