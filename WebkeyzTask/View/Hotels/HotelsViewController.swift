//
//  HotelsViewController.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import RxSwift

class HotelsViewController: UIViewController {

    private lazy var viewModel: HotelsViewModel = {
        return HotelsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

fileprivate extension HotelsViewController {
    
    func setupTableView() {
        viewModel.hotelSubject.observeOn(MainScheduler.instance)
    }
}
