//
//  HotelsViewController.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import RxSwift
import RxCocoa

class HotelsViewController: UIViewController {

    @IBOutlet private weak var hotelTableView: UITableView!
    
    private lazy var viewModel: HotelsViewModelProtocol = {
        return HotelsViewModel()
    }()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchHotels()
    }
    

}

fileprivate extension HotelsViewController {
    
    func setupTableView() {
        hotelTableView.registerCellNib(cellClass: HotelCell.self)
        viewModel.hotelsDriver.drive(hotelTableView.rx.items(cellIdentifier: Constants.hotelCell, cellType: HotelCell.self)) {(row,item,cell) in
            cell.configureCell(image: item.image?[0].url ?? "", name: item.hotelName ?? "")
        }.disposed(by: disposeBag)
        
        hotelTableView.rx.itemSelected.subscribe { (indexPath) in
            
        }.disposed(by: disposeBag)
    }
}
