//
//  SampleViewReactor.swift
//  ReactorKitPractice
//
//  Created by Tong on 2021/05/12.
//

import Foundation
import RxSwift
import ReactorKit

final class SampleViewReactor: Reactor{
    enum Action{
        case increase
        case decrease
    }
    
    enum Mutation{
        case setLoading(Bool)
        case changeValue(Int)
    }
    
    struct State{
        var value: Int
        var isLoading: Bool
    }
    
    let initialState: State
    
    init(){
        self.initialState = State(value: 0, isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.changeValue(1)).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.changeValue(-1)).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .changeValue(let value):
            newState.value += value
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
