//
//  MarketTableViewController.m
//  Lista de Mercado
//
//  Created by Juan C Salazar on 13/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "MarketTableViewController.h"

@interface MarketTableViewController ()
{
    int nRow;
}
@end

@implementation MarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    allMarkets = [[Market alloc]init];
    [allMarkets searchListMarket];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [allMarkets.arrayAllMArketsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMarkets" forIndexPath:indexPath];
    
    cell.textLabel.text = [(repoMarketProduct *)[allMarkets.arrayAllMArketsList objectAtIndex:indexPath.row] nameMarketList];
    
    cell.detailTextLabel.text = [(repoMarketProduct *)[allMarkets.arrayAllMArketsList objectAtIndex:indexPath.row] dateMarketList];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ListMarketVC = [segue destinationViewController];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    nRow = indexPath.row;
    
    ListMarketVC.dataTransferIdList = [[(repoMarketProduct *)[allMarkets.arrayAllMArketsList objectAtIndex:nRow] idMarketList] intValue];
    
    ListMarketVC.nameMarketDataTransfer = [(repoMarketProduct *)[allMarkets.arrayAllMArketsList objectAtIndex:indexPath.row] nameMarketList];
    
    appDelegate.idSuperMercado = [NSString stringWithFormat:@"%i", [[(repoMarketProduct *)[allMarkets.arrayAllMArketsList objectAtIndex:nRow] idMarketList] intValue]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
