//
//  BankTeller.swift
//  BankManagerConsoleApp
//
//  Created by Dasan & Mary on 2023/07/12.
//

import Foundation

struct BankDepartment {
    private let responsibility: BankingService
    private let departmentQueue: OperationQueue
    
    init(responsibility: BankingService, numberOfBankTeller: Int, queue: OperationQueue) {
        self.responsibility = responsibility
        self.departmentQueue = queue
        self.departmentQueue.maxConcurrentOperationCount = numberOfBankTeller
    }
    
    private func work() {
        Thread.sleep(forTimeInterval: responsibility.duration)
    }
    
    func takeOnTask(for customer: Customer,
                    startHandler: @escaping (Customer) -> Void = { _ in },
                    completionHandler: @escaping (Customer) -> Void = { _ in }) {
        let task = BlockOperation {
            startHandler(customer)
            work()
            completionHandler(customer)
        }
        departmentQueue.addOperation(task)
    }
}
