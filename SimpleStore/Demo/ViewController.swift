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

extension UIViewController {
    //MARK: - Top View Controller
    static func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }
        
        return topViewController
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showStore(_ sender: Any) {
        let bundle  = Bundle(for: StoreViewController.self)
        let storeVC = StoreViewController(nibName: "StoreViewController", bundle: bundle)
        StoreManager.shared.storeManagerDelegate = self
        
        storeVC.title     = "Store"
        self.navigationController?.pushViewController(storeVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController : StoreManagerDelegate {
    //MARK:- HudDelegate
    public func showHud() {
        print("Show HUD")
        MBProgressHUD.showAdded(to: UIViewController.topViewController().view, animated: true)
    }
    
    public func hideHud() {
        MBProgressHUD.hide(for: UIViewController.topViewController().view, animated: true)
    }
    
    public func purchaseSuccess(productId: String) {
        if productId == iAP_RemoveAd {
            // TODO: DO SOMETHING
            print("Remove Ads Purchase Success. Do Something!")
            
        }
    }
}

