//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Dasan & Mary on 2023/07/12.
//

import Foundation

final class Bank {
    private var customerQueue: Queue<Customer> = Queue()
    private var timeTracker = TimeTracker()
    private var customerCount: Int = 0
    private let group = DispatchGroup()
    private let depositDepartment: BankDepartment
    private let loanBankDepartment: BankDepartment
    
    init() {
        depositDepartment = BankDepartment(numberOfBankTeller: 2, group: group)
        loanBankDepartment = BankDepartment(numberOfBankTeller: 1, group: group)
    }

    func handOutNumberTickets(numberOfCustomer: Int) -> [Customer] {
        var customers: [Customer] = []
        for _ in 0..<numberOfCustomer {
            customerCount += 1
            let customer = Customer(numberTicket: customerCount)
            customerQueue.enqueue(customer)
            customers.append(customer)
        }

        return customers
    }
    
    func startBusiness(startHandler: @escaping (Customer) -> Void,
                                        completionHandler: @escaping (Customer) -> Void) {
        while let currentCustomer = customerQueue.dequeue() {
            switch currentCustomer.service {
            case .deposit:
                depositDepartment.takeOnTask(for: currentCustomer,
                                             startHandler: startHandler,
                                             completionHandler: completionHandler)
            case .loan:
                loanBankDepartment.takeOnTask(for: currentCustomer,
                                              startHandler: startHandler,
                                              completionHandler: completionHandler)
            }
        }
    }
    
    private func stopBusiness() {
        group.notify(queue: .main) {
            //타이머 멈춰
        }
    }
}

extension Bank {
    private enum MessageFormat {
        static let closing: String = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %u명이며, 총 업무시간은 %.2f입니다."
        static let startTask: String = "%u번 고객 %@ 시작"
        static let finishTask: String = "%u번 고객 %@ 완료"
    }
}
