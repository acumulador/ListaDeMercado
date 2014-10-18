//
//  ProductsTableViewController.m
//  Lista de Mercado
//
//  Created by Jhon Wilfer Orrego on 12/10/14.
//  Copyright (c) 2014 Juan C Salazar. All rights reserved.
//

#import "ProductsTableViewController.h"

@interface ProductsTableViewController ()
{
    int cantProduct;
    int nRow;
    int subT;
    int valUn;
    int idCategoryDataTransfer;
}

@end

@implementation ProductsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    varAppDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    productsOfCategory = [[Market alloc]init];
    idCategoryDataTransfer = [_dataTransferIdCategory intValue]+1;
    [productsOfCategory loadProductsOfCategory:idCategoryDataTransfer];
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
    return [productsOfCategory.arrayProductsOfCategory count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellProduct" forIndexPath:indexPath];
    
    cell.textLabel.text = [(repoMarketProduct *)[productsOfCategory.arrayProductsOfCategory objectAtIndex:indexPath.row] dsProduct];
    
    cell.detailTextLabel.text = [(repoMarketProduct *)[productsOfCategory.arrayProductsOfCategory objectAtIndex:indexPath.row] valUnitProduct];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //nRow = [self.tableView indexPathForSelectedRow];
    nRow = indexPath.row;
    
    //Metodo que Indica cuando se toca una celda
    messageCantProduct = [[UIAlertView alloc]initWithTitle:@"Mercado" message:@"Ingrese la cantidad" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
    messageCantProduct.alertViewStyle = UIAlertViewStylePlainTextInput;
    messageCantProduct.tag = 1;
    [messageCantProduct show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (messageCantProduct.tag==1) {
        
        //Ojo falta en la operación de subtotal determinar el valor unitario
        cantProduct = [[alertView textFieldAtIndex:0].text intValue];
        
        valUn = [[[productsOfCategory.arrayProductsOfCategory objectAtIndex:nRow] valUnitProduct]intValue];
        
        subT = cantProduct * valUn;
        
        [productsOfCategory addProductAtMarketWhithIdMarket: [varAppDelegate.idSuperMercado intValue] AndIdProduct:[[(repoMarketProduct *)[productsOfCategory.arrayProductsOfCategory objectAtIndex:nRow] idProduct] intValue] AndDsProduct:[(repoMarketProduct *)[productsOfCategory.arrayProductsOfCategory objectAtIndex:nRow] dsProduct] AndCantProduct:cantProduct AndValUnitProduct:[[(repoMarketProduct *)[productsOfCategory.arrayProductsOfCategory objectAtIndex:nRow] valUnitProduct] intValue] AndSubTotal:subT];
        
        messageCantProduct = [[UIAlertView alloc]initWithTitle:@"Mercado" message:productsOfCategory.status delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        messageCantProduct.tag = 2;
        [messageCantProduct show];
    }
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
