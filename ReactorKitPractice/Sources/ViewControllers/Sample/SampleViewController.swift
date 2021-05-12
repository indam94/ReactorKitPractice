//
//  SampleViewController.swift
//  ReactorKitPractice
//
//  Created by Tong on 2021/05/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactorKit

final class SampleViewController: UIViewController, View{
    
    typealias Reactor = SampleViewReactor
    
    //MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()
    
    //MARK: UI
    
    private let increaseButton: UIButton = {
        let aButton = UIButton()
        aButton.setTitle("+", for: .normal)
        return aButton
    }()
    private let decreaseButton: UIButton = {
        let aButton = UIButton()
        aButton.setTitle("-", for: .normal)
        return aButton
    }()
    private let valueLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.text = ""
        aLabel.textColor = .white
        return aLabel
    }()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: Configuration
    
    func setup(){
        view.addSubview(increaseButton)
        increaseButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(50)
            $0.size.equalTo(50)
        }
        
        view.addSubview(decreaseButton)
        decreaseButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-50)
            $0.size.equalTo(50)
        }
        
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        
        //Action
        increaseButton.rx.tap
            .map{ Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map{ Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //State
        reactor.state
            .map{ $0.value }
            .distinctUntilChanged()
            .map{ "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}
