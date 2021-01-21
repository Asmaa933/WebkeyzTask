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
    
    private var viewModel = HotelsViewModel.shared
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchHotels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Hotels"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
}

fileprivate extension HotelsViewController {
    
    func setupTableView() {
        hotelTableView.registerCellNib(cellClass: HotelCell.self)
        viewModel.hotelsDriver.drive(hotelTableView.rx.items(cellIdentifier: Constants.hotelCell, cellType: HotelCell.self)) {(row,item,cell) in
            cell.configureCell(image: item.image?[0].url ?? "", name: item.hotelName ?? "")
        }.disposed(by: disposeBag)
        
        hotelTableView.rx.itemSelected.subscribe { (indexPath) in
            self.hotelTableView.deselectRow(at: indexPath, animated: false)
        }.disposed(by: disposeBag)

        hotelTableView.rx.modelSelected(HotelModel.self).subscribe(onNext: {[weak self] (hotel) in
            self?.navigateToDetailsView(hotel: hotel)
        }).disposed(by: disposeBag)
        
    }
    
    func navigateToDetailsView(hotel: HotelModel) {
        viewModel.didSelectHotel(hotel: hotel)
        guard let detailsView = storyboard?.instantiateViewController(withIdentifier: Constants.detailsViewController) as? DetailsViewController else {return}
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
}
