//
//  ProgressView.swift
//  BankManagerUIApp
//
//  Created by Dasan & Mary on 2023/08/22.
//

import UIKit

final class ProgressView: UIView {
    let addCustomerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("고객 10명 추가", for: .normal)
        
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("초기화", for: .normal)
        
        return button
    }()
    
    private let workTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .black
        label.text = "업무시간"
        label.textAlignment = .center
        
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let waitingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        let titleLabel = UILabel()
        titleLabel.text = "대기중"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .green
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        stackView.addArrangedSubview(titleLabel)
        
        titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        return stackView
    }()
    
    private let workingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        let titleLabel = UILabel()
        titleLabel.text = "업무중"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .systemBlue
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        stackView.addArrangedSubview(titleLabel)
        
        titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        return stackView
    }()
    
    private let waitingCustomerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let workingCustomerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addWaitingCustomerList(customers: [Customer]) {
        customers.forEach { customer in
            let label = UILabel()
            label.textColor = customer.service == .loan ? .purple : .black
            label.text = "\(customer.numberTicket) - \(customer.service)"
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            label.tag = customer.numberTicket
            waitingCustomerListStackView.addArrangedSubview(label)
        }
    }
    
    func addWorkingCustomerList(customer: Customer) {
        let label = UILabel()
        label.textColor = customer.service == .loan ? .purple : .black
        label.text = "\(customer.numberTicket) - \(customer.service)"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        workingCustomerListStackView.addArrangedSubview(label)
    }
    
    func deleteWaitingCustomerList(customer: Customer) {
        waitingCustomerListStackView.subviews.forEach { subview in
            if subview.tag == customer.numberTicket {
                subview.removeFromSuperview()
                return
            }
        }
    }
    
    func deleteWorkingCustomerList(customer: Customer) {
        workingCustomerListStackView.subviews.forEach { subview in
            if subview.tag == customer.numberTicket {
                subview.removeFromSuperview()
                return
            }
        }
    }
    
    private func configureUI() {
        buttonStackView.addArrangedSubview(addCustomerButton)
        buttonStackView.addArrangedSubview(resetButton)
        waitingStackView.addArrangedSubview(waitingCustomerListStackView)
        workingStackView.addArrangedSubview(workingCustomerListStackView)
        listStackView.addArrangedSubview(waitingStackView)
        listStackView.addArrangedSubview(workingStackView)
        
        addSubview(buttonStackView)
        addSubview(workTimeLabel)
        addSubview(listStackView)
    }
    
    private func setupConstraints() {
        setupButtonStackViewConstraints()
        setupWorkTimeLabelConstraints()
        setupListStackViewConstraints()
    }
    
    private func setupButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupWorkTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            workTimeLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            workTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            workTimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupListStackViewConstraints() {
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 20),
            listStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            listStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
}

// 메서드 분리
