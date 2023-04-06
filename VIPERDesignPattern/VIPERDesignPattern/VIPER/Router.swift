//
//  Router.swift
//  VIPERDesignPattern
//
//  Created by Ahmed Salem on 06/04/2023.
//

import Foundation
import UIKit

//object
//Entry Point
typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter
{
    //Entry Point
    var entry: EntryPoint? { get }
    static func start()->AnyRouter
    
    // func stop
    //func route(to destination)
}

class UserRouter:AnyRouter{
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        //define relations
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        //setting the default router
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
