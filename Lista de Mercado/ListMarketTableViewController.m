//
//  ListMarketTableViewController.m
//  Lista de Mercado
//
//  Created by Jhon Wilfer Orrego on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "ListMarketTableViewController.h"
#import "SWTableViewCell.h"
#import "UMTableViewCell.h"
#import "ProductsTableViewController.h"

@interface ListMarketTableViewController ()
{
    int nRow;
    NSString * pruebaNombreProduct;
}

@property (nonatomic) BOOL useCustomCells;
@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end

NSString * pruebaIdMarket;

@implementation ListMarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    varAppDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    listMarket = [[Market alloc]init];
    //defino si es una lista nueva
    if (varAppDelegate.swEditMarketList) {
        //se toma la lista selccionada como referencia
        [listMarket createNewMarketListWhithArrayProductsWhithNameMarket:_nameMarketDataTransfer];
        
        [listMarket loadMarketWithIdListMarket:varAppDelegate.idNewSuperMercado];
        
    } else {
        [listMarket loadMarketWithIdListMarket:_dataTransferIdList];
        [listMarket sumValuesMarketList:_dataTransferIdList];
    }
    
    _totalMarketLabel.text = [NSString stringWithFormat:@"Total: $ %@",listMarket.totalValuesMarket];

    if (!varAppDelegate.swEditMarketList) {
        _addProductButton.enabled = NO;
    }
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
    return [listMarket.arrayProductsOfCategory count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UMTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"UMCell" forIndexPath:indexPath];
    
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    cell.delegate = self;
    
    cell.dsProductLabel.text = [(repoMarketProduct *)[listMarket.arrayProductsOfCategory objectAtIndex:indexPath.row] dsProduct];
    
    cell.cantProductLabel.text = [NSString stringWithFormat:@"(%@)", [(repoMarketProduct *)[listMarket.arrayProductsOfCategory objectAtIndex:indexPath.row] cantProduct]];
    
    cell.subtotalProductLabel.text = [NSString stringWithFormat:@"$%@", [(repoMarketProduct *)[listMarket.arrayProductsOfCategory objectAtIndex:indexPath.row] subTotal]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    nRow = indexPath.row;
    pruebaNombreProduct = [(repoMarketProduct *)[listMarket.arrayProductsOfCategory objectAtIndex:indexPath.row] dsProduct];
}

- (NSArray *)rightButtons
{
    if (varAppDelegate.swEditMarketList) {
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                     icon:[UIImage imageNamed:@"comparar.png"]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                     icon:[UIImage imageNamed:@"editar"]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                     icon:[UIImage imageNamed:@"eliminar.png"]];
        
        return rightUtilityButtons;
    }
    else{
        return nil;
    }
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:            
            varAppDelegate.idProductcompare = [(repoMarketProduct *)[listMarket.arrayProductsOfCategory objectAtIndex:nRow] idProduct];
            
            break;
        case 1:
            NSLog(@"Boton Editar");
            break;
        case 2:
            NSLog(@"Boton Eliminar");
            break;
            
        default:
            break;
    }
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selecciono la celda: %@", [self.tableView indexPathForSelectedRow]);
    
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
*/


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
