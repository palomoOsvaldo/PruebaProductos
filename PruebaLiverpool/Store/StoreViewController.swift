//
//  StoreViewController.swift
//  PruebaLiverpool
//
//  Created Osvaldo Salas Palomo on 10/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Osva
//

import UIKit

class StoreViewController: UIViewController {
	var presenter: StorePresenterProtocol?
    var products: [Record] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var numberPage: Int = 1
    var currentType: FilterUrl = .Predefinida
    var types: [FilterUrl] = []
    let spinner = UIActivityIndicatorView(style: .medium)
    var residuo = true
    var onlyOne = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
        let rightItem = UIBarButtonItem(title: "Ordenar", style: .plain, target: self, action: #selector(orderProduct))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: .local), forCellReuseIdentifier: "ProductCell")
        
        spinner.color = .systemPink
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        types = presenter?.getOrderTypes() ?? []
        self.title = "Productos"
    }
    
    func getProducts() {
        self.tableView.tableFooterView?.isHidden = false
        self.tableView.tableFooterView = spinner
        presenter?.willGetData(search: "", page: "\(numberPage)", filtro: .Predefinida)
        self.onlyOne = true
    }
    
    @objc func orderProduct() {
        let alert = UIAlertController(title: "Filtro", message: "Elige un filtro", preferredStyle: .actionSheet)
        for type in types {
            let action = UIAlertAction(title: type.rawValue, style: .default) { _ in
                if type != self.currentType {
                    self.products.removeAll()
                    self.currentType = type
                    self.numberPage = 1
                    self.getProducts()
                }
            }
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}

extension StoreViewController: StoreViewProtocol {
    func showError() {
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.tableFooterView = nil
        let  alert = UIAlertController(title: "Usuario", message: "Ocurrio un error.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { _ in
            self.presenter?.willGetData(search: "", page: "1", filtro: .Predefinida)
            self.activityIndicator.isHidden = false
        }))
        present(alert, animated: true)
    }
    
    func showData(data: StoreModel) {
        if products.count == 0 {
            products = data.plpResults.records
        } else {
            products.append(contentsOf: data.plpResults.records)
        }
        activityIndicator.isHidden = true
        tableView.reloadData()
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.tableFooterView = nil
    }
}

extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let currentProduct = products[indexPath.row]
        cell.setData(product: currentProduct)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetMaxY: Float = Float(scrollView.contentOffset.y + scrollView.bounds.size.height)
        let contentHeight: Float = Float(scrollView.contentSize.height)
        let lastCellIsVisible = contentOffsetMaxY > contentHeight
        if lastCellIsVisible && self.onlyOne {
            debugPrint("loader")
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            if numberPage != 0 {
                self.onlyOne = false
                self.numberPage += 1
                debugPrint("Contador:  \(self.numberPage)")
                self.getProducts()
            }else {
                self.tableView.tableFooterView = nil
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
}