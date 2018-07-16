/*
 *    Copyright 2018 Prebid.org, Inc.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

#import <Foundation/Foundation.h>
#import "SettingsViewAdSizeController.h"
@interface SettingsViewAdSizeController () <UITableViewDelegate, UITableViewDataSource>
@property NSArray *sizesArray;
@property NSString *selectedSize;
@end

@implementation SettingsViewAdSizeController
- (void)viewDidLoad
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    doneButton.target = self;
    doneButton.action = @selector(doneAction:);
    
    doneButton.title = @"Done";
    self.navigationItem.rightBarButtonItem = doneButton;
    _sizesArray = @[@"320x50", @"300x85",@"250x90",@"100x100",@"200x50",@"300x50"];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sizesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    }
    cell.textLabel.text = _sizesArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    for (UITableViewCell *cell in [tableView visibleCells]){
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedSize = cell.textLabel.text;
    NSLog(@"cell text: %@", cell.textLabel.text);
    
}

-(void) doneAction :(id) sender {
    [self.delegate sendSelectedAdSize:self.selectedSize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
