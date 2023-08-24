//
//  BankManagerUIApp - ProgressViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ProgressViewController: UIViewController {
    private let progressView = ProgressView()
    private let bank = Bank()
    
    private lazy var start: (Customer) -> Void = { customer in
        DispatchQueue.main.async {
            self.progressView.deleteWaitingCustomerList(customer: customer)
            self.progressView.addWorkingCustomerList(customer: customer)
        }
    }
    
    private lazy var end: (Customer) -> Void = { customer in
        DispatchQueue.main.async {
            self.progressView.deleteWorkingCustomerList(customer: customer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupConstraints()
        progressView.addCustomerButton.addTarget(
            self,
            action: #selector(addCustomer),
            for: .touchUpInside
        )
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(progressView)
    }
    
    func setupConstraints() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc private func addCustomer() {
        let newCustomers = bank.handOutNumberTickets(numberOfCustomer: 10)
        
        progressView.addWaitingCustomerList(customers: newCustomers)
        bank.startBusiness(startHandler: start,
                           completionHandler: end)
    }
}
