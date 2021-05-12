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
        case increaseValue
        case decreaseValue
    }
    
    struct State{
        var value: Int
    }
    
    let initialState: State
    
    init(){
        self.initialState = State(value: 0)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .increase:
            return Observable.just(Mutation.increaseValue)
        case .decrease:
            return Observable.just(Mutation.decreaseValue)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        default:
            newState.value -= 1
        }
        return newState
    }
}
