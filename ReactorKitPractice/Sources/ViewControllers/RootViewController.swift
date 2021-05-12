//
//  RootViewController.swift
//  ReactorKitPractice
//
//  Created by Tong on 2021/05/12.
//

import UIKit
import RxSwift
import SnapKit

final class RootViewController: UIViewController{
    
    private(set) var contentViewController: UIViewController?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Did Load \(self.description)")
        
        if let contentViewController = contentViewController{
            contentViewController.view.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
        }
    }
    
    func setContent(_ viewController: UIViewController?, animated: Bool){
        let previousViewController = contentViewController
        
        if let viewController = viewController{
            addChild(viewController)
            view.addSubview(viewController.view)
//            view.sendSubviewToBack(viewController.view)
            contentViewController = viewController
            
            if isViewLoaded{
                viewController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }
        }
        
        if animated{
            UIView.animate(withDuration: 0.125, delay: 0, options: [.curveLinear], animations: {
                previousViewController?.view.alpha = 0
            }){ (success) in
                previousViewController?.dismiss(animated: false)
                previousViewController?.view.removeFromSuperview()
                previousViewController?.removeFromParent()
            }
        }
        else{
            previousViewController?.dismiss(animated: false)
            previousViewController?.view.removeFromSuperview()
            previousViewController?.removeFromParent()
        }
    }
}
