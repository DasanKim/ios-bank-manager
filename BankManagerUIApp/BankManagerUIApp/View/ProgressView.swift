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
        label.setContentHuggingPriority(.required, for: .vertical)
        
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
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.setContentHuggingPriority(.required, for: .vertical)
        
        return stackView
    }()
    
    private let waitingLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "대기중"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .green
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return titleLabel
    }()
    
    private let workingLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "업무중"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .systemBlue
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return titleLabel
    }()
    
    private let waitingCustomerListScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setContentHuggingPriority(.init(50), for: .vertical)
        
        return scrollView
    }()
    
    private let waitingCustomerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
//        stackView.setContentHuggingPriority(.init(51), for: .vertical)
        
        return stackView
    }()
    
    private let workingCustomerListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.init(50), for: .vertical)
        
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
        titleStackView.addArrangedSubview(waitingLabel)
        titleStackView.addArrangedSubview(workingLabel)
        waitingCustomerListScrollView.addSubview(waitingCustomerListStackView)
        
        addSubview(buttonStackView)
        addSubview(workTimeLabel)
        addSubview(titleStackView)
        addSubview(waitingCustomerListScrollView)
        addSubview(workingCustomerListStackView)
    }
    
    private func setupConstraints() {
        setupButtonStackViewConstraints()
        setupWorkTimeLabelConstraints()
        setupTitleStackViewConstraints()
        setupWaitingCustomerListScrollViewConstraints()
        setupWorkingCustomerListStackViewConstraints()
    }
    
    private func setupButtonStackViewConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            buttonStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupWorkTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            workTimeLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            workTimeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            workTimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupTitleStackViewConstraints() {
        NSLayoutConstraint.activate([
            waitingLabel.widthAnchor.constraint(equalTo: workingLabel.widthAnchor),
            titleStackView.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 20),
            titleStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            titleStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupWaitingCustomerListScrollViewConstraints() {
        let stackViewHeightConstraint = waitingCustomerListStackView.heightAnchor.constraint(equalTo: waitingCustomerListScrollView.frameLayoutGuide.heightAnchor)
        stackViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            waitingCustomerListScrollView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 0),
            waitingCustomerListScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            waitingCustomerListScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            waitingCustomerListScrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            waitingCustomerListScrollView.trailingAnchor.constraint(equalTo: workingCustomerListStackView.leadingAnchor, constant: 0),
            
            waitingCustomerListStackView.topAnchor.constraint(equalTo: waitingCustomerListScrollView.topAnchor, constant: 0),
            waitingCustomerListStackView.bottomAnchor.constraint(equalTo: waitingCustomerListScrollView.bottomAnchor),
            waitingCustomerListStackView.leadingAnchor.constraint(equalTo: waitingCustomerListScrollView.leadingAnchor, constant: 0),
            waitingCustomerListStackView.trailingAnchor.constraint(equalTo: waitingCustomerListScrollView.trailingAnchor, constant: 0),
            waitingCustomerListStackView.widthAnchor.constraint(equalTo: waitingCustomerListScrollView.widthAnchor),
            stackViewHeightConstraint
        ])
    }
    
    private func setupWorkingCustomerListStackViewConstraints() {
        NSLayoutConstraint.activate([
            workingCustomerListStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 0),
            workingCustomerListStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            workingCustomerListStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
        ])
    }
}
