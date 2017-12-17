/**
 *  SimpleStore
 *
 *  Copyright (c) 2017 Mahmud Ahsan. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import UIKit
import MBProgressHUD

public class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
     
        let bundle  = Bundle(for: StoreViewController.self)
        tableView.register(UINib.init(nibName: "StoreTableViewCell", bundle: bundle), forCellReuseIdentifier: "cell")
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreManager.shared.storeItems.count
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StoreTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StoreTableViewCell
        cell?.lblName?.text  = StoreManager.shared.storeItems[indexPath.row].name
        cell?.lblPrice?.text = StoreManager.shared.storeItems[indexPath.row].price
        cell?.imgIcon?.image = UIImage(named: StoreManager.shared.storeItems[indexPath.row].image)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storeItem = StoreManager.shared.storeItems[indexPath.row]
        if storeItem.productId == StoreManager.RestoreAll  {
            //Restore All
            StoreManager.shared.restoreProducts()
        }
        else {
            if StoreManager.shared.isProductPurchased(storeItem.productId) {
                showAlert()
            }
            else {
                StoreManager.shared.purchaseProduct(id: storeItem.productId)
            }
        }
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Purchased", message: "You already purchased this item", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
