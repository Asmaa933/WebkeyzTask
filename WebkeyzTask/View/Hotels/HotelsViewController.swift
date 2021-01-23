//
//  HotelsViewController.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

//MARK: - HotelsViewController

class HotelsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var hotelTableView: UITableView!
    
    //MARK: - Variables
    
    private let refreshControl = UIRefreshControl()
    private var viewModel = HotelsViewModel.shared
    private let disposeBag = DisposeBag()
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindObservables()
        refreshControl.beginRefreshing()
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

//MARK: - Helper Methods

fileprivate extension HotelsViewController {
    
    /// Register Cell and Add UIRefreshControl to UITableView
    func setupTableView() {
        hotelTableView.registerCellNib(cellClass: HotelCell.self)
        hotelTableView.addSubview(refreshControl)
    }
    
    /// Bind MVVM Observables
    func bindObservables() {
        bindTableView()
        bindRefreshControl()
        bindErrorsHandler()
    }
    
    func bindTableView() {
        viewModel.hotelsDriver.drive(hotelTableView.rx.items(cellIdentifier: Constants.hotelCell, cellType: HotelCell.self)) {[weak self](row,item,cell) in
            self?.refreshControl.endRefreshing()
            cell.configureCell(image: item.image?[0].url ?? "", name: item.hotelName ?? "")
        }.disposed(by: disposeBag)
        
        hotelTableView.rx.itemSelected.subscribe { (indexPath) in
            self.hotelTableView.deselectRow(at: indexPath, animated: false)
        }.disposed(by: disposeBag)

        hotelTableView.rx.modelSelected(HotelModel.self).subscribe(onNext: {[weak self] (hotel) in
            self?.navigateToDetailsView(hotel: hotel)
        }).disposed(by: disposeBag)
    }
    
    func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged).bind {[weak self] (_) in
            guard let self = self else {return}
            self.hotelTableView.restore()
            self.viewModel.reloadHotels()
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }
    
    func bindErrorsHandler() {
        viewModel.errorSubject.observe(on: MainScheduler.instance).bind {[weak self] (error) in
            guard let self = self else {return}
            if error == Constants.internetConnectionError {
                if self.hotelTableView.numberOfRows(inSection: 0) == 0 {
                    self.hotelTableView.setEmptyView(title: Constants.pullMessage, messageImage: #imageLiteral(resourceName: "no internet"))
                } else {
                    self.view.makeToast(Constants.offlineMessage)
                }
            } else {
                if !error.isEmpty {
                    self.view.makeToast(error)
                }
            }
        }.disposed(by: disposeBag)
    }
    
    /// Navigate to Details View
    func navigateToDetailsView(hotel: HotelModel) {
        viewModel.didSelectHotel(hotel: hotel)
        guard let detailsView = storyboard?.instantiateViewController(withIdentifier: Constants.detailsViewController) as? DetailsViewController else {return}
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
