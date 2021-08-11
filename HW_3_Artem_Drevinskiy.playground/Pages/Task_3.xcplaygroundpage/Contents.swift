//: [Previous](@previous)

import Foundation
 // Task 3 Счет в банке

/*
                            credit account in bank
 */

/// Можно просто `CreditAccount`
struct BankCreditAccount {
    let accountID: String
    var creditLimit: Double
    /// По умолчанию можно задать баланс в 0
    var creditBalance: Double
    var countOfOperations = 0
    
    /// Лишний пробел перед открывающей скобкой ` (`
    init (accountID: String, creditLimit: Double) {
        self.creditLimit = creditLimit
        creditBalance = creditLimit
        self.accountID = accountID
    }
    
    func printCurrentCreditBalance()  {
        print("Current credit balance of bankID: \(accountID) is - \(creditBalance)$")
    }
    
    /// Почему бы не назвать метод просто `transter(sum: Double, toAccount: BankCreditAccount)`
    /// И выровнять табуляцию при помощи `Control + I`
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func creditBalanceTransfer(to bankAccount: inout BankCreditAccount,
                                           transferAmount: Double) -> String {
        /// А почему сразу не умножить на `1.01`? :)
        /// А еще лучше, вынести значение комиссии в константы.
        let transferAmountWithCommission = transferAmount + transferAmount * 0.01
        /// Тут должна быть проверка `>=`, по идеи
        guard creditBalance > transferAmountWithCommission else {
            return "Not enough credit money for this transaction"
        }
        /// Лучше это делать последним действием, после изменения баланса
        countOfOperations += 1
        bankAccount.creditBalance += transferAmount
        creditBalance -= transferAmountWithCommission
        return "Successful transaction"
    }
    
    /// Почему бы не назвать метод просто `withdraw(sum: Double)`
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func withdrawFromCreditBalance(amount: Double) -> String {
        /// Все комменты аналогичные функции выше.
        let amountWithCommission = amount + amount * 0.04
        guard creditBalance > amountWithCommission else {
            return "Not enough credit money for this operation"
        }
        countOfOperations += 1
        creditBalance -= amountWithCommission
        return "Successful withdrawal"
    }
    
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func refillCreditBalance(with amount: Double) -> String {
        creditBalance += amount
        countOfOperations += 1
        if creditBalance >= creditLimit {
            /// Можно этот `guard` вынести перед `if`. Если лимит максимальный - все остальные проверки не нужны.
            guard creditLimit != 100000 else {
                return "Loan repaid. Credit limit increased to maximum"
            }
            creditLimit += 100
            creditBalance += 100
            return "Loan repaid. Credit limit increased"
        }
        return "Successful refill"
    }
        
}

var myCreditAccount = BankCreditAccount(accountID: "A000001", creditLimit: 99900)
var myMomsCreditAccount = BankCreditAccount(accountID: "A000002", creditLimit: 2100)


// transfering money from myAccount to momsAccount
myCreditAccount.printCurrentCreditBalance()
myMomsCreditAccount.printCurrentCreditBalance()
print(myCreditAccount.creditBalanceTransfer(to: &myMomsCreditAccount, transferAmount: 300))
myCreditAccount.printCurrentCreditBalance()
myMomsCreditAccount.printCurrentCreditBalance()
print("")

// withdrawal money from myAccount
print(myCreditAccount.withdrawFromCreditBalance(amount: 99690))
myCreditAccount.printCurrentCreditBalance()
print("")

print(myCreditAccount.withdrawFromCreditBalance(amount: 100))
myCreditAccount.printCurrentCreditBalance()
print("")

// refill balance of myAccount
print(myCreditAccount.refillCreditBalance(with: 407))
myCreditAccount.printCurrentCreditBalance()
print("___________________________")

/*
 
                            mixed account in bank
 
 */

/// Можно просто `MixedAccount`
struct BankMixedAccount {
    var creditAccount: BankCreditAccount
    /// Личные средства это скорее производное, которое считается на основании
    /// общей суммы и кредитного лимита с средитного счета. Я бы сделал сразу `computed property`
    var balance: Double
    
    func showInfoAboutAccount() {
        print("Information about account with bankID \(creditAccount.accountID): credit limit - \(creditAccount.creditLimit)$; credit balance - \(creditAccount.creditBalance)$; balance \(balance)$ ")
    }
    
    /// Почему бы не назвать метод просто `withdraw(sum: Double)`
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func withdrawFromBalance(amount: Double) -> String {
        // if there is no money on balance at all, withdraw from credit balance with commission
        guard balance != 0 else {
            return creditAccount.withdrawFromCreditBalance(amount: amount)
        }
        // if there is not enough money on balance, withdraw some money from balance and other from credit balance with commission
        guard balance > amount else {
            let amountToWithdrawFromCreditBalance = amount - balance
            /// А почему сразу не умножить на `1.04`? :)
            /// А еще лучше, вынести значение комиссии в константы.
            let amountWithCommissionToWithdrawFromCreditBalance = amountToWithdrawFromCreditBalance + amountToWithdrawFromCreditBalance * 0.04
            if amountWithCommissionToWithdrawFromCreditBalance > creditAccount.creditBalance {
                return "Not enough credit money for withdrawal"
            }
            creditAccount.countOfOperations += 1
            creditAccount.creditBalance -= amountWithCommissionToWithdrawFromCreditBalance
            balance = 0
            return "Successful withdrawal"
        }
        // if there is money on balance
        creditAccount.countOfOperations += 1
        balance -= amount
        return "Successful withdrawal"
    }
    
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func creditBalanceTransfer(to bankAccount: inout BankMixedAccount,
                                           transferAmount: Double) -> String {
        let transferAmountWithCommission = transferAmount + transferAmount * 0.01
        guard creditAccount.creditBalance > transferAmountWithCommission else {
            return "Not enough credit money for this transaction"
        }
        creditAccount.countOfOperations += 1
        bankAccount.balance += transferAmount
        creditAccount.creditBalance -= transferAmountWithCommission
        return "Successful transaction"
    }
    
    /// Почему бы не назвать метод просто `transter(sum: Double, toAccount: BankCreditAccount)`
    /// Не обязательно возвращать инфу для консоли из функции. Можно просто писать `print` внутри.
    mutating func transferOwnMoney(to bankAccount: inout BankMixedAccount, amount: Double) -> String {
        // if there is no money on balance at all, transfer from credit balance with commission
        guard balance != 0 else {
            return creditBalanceTransfer(to: &bankAccount, transferAmount: amount)
        }
        // if there is not enough money on balance,transfer some money from balance and other from credit balance with commission
        guard balance > amount else {
            let amountToTransferFromCreditAccount = amount - balance
            if amountToTransferFromCreditAccount + amountToTransferFromCreditAccount * 0.01 > creditAccount.creditBalance {
                return "Not enough credit money for this transaction"
            }
            bankAccount.balance += amount
            balance = 0
            return creditBalanceTransfer(to: &bankAccount, transferAmount: amountToTransferFromCreditAccount)
        }
        // if there is money on balance
        bankAccount.balance += amount
        balance -= amount
        return "Successful transaction"
    }
}

var myMixedAccount = BankMixedAccount(creditAccount: myCreditAccount, balance: 1200)
var myMomMixedAccount = BankMixedAccount(creditAccount: myMomsCreditAccount, balance: 0)

// transfering own money to moms account
print(myMixedAccount.transferOwnMoney(to: &myMomMixedAccount, amount: 200))
myMixedAccount.showInfoAboutAccount()
myMomMixedAccount.showInfoAboutAccount()
// withdrawal money from balance
print(myMixedAccount.withdrawFromBalance(amount: 300))
myMixedAccount.showInfoAboutAccount()
myMomMixedAccount.showInfoAboutAccount()
print("_______________________________")

/*
                              bank profiles
 */

/// Лучше назвать `BankPortfolio`
struct BankAccountsSet {
    var mixedBankAccount: BankMixedAccount
    var creditBankAccount: BankCreditAccount
}

struct BankProfile {
    let ownerName: String
    var bankAccountsSet: BankAccountsSet
    var defaultAccount: BankMixedAccount
    
    /// Лишний пробел перед открывающей скобкой ` (`
    init (ownerName: String, bankAccountsSet: BankAccountsSet) {
        self.ownerName = ownerName
        self.bankAccountsSet = bankAccountsSet
        defaultAccount = self.bankAccountsSet.mixedBankAccount
    }
     
    mutating func deleteProfile(bankProfile: BankProfile) -> String {
        var indebtednessOfClient = 0.0
        let bankIndebtednessToClient = bankProfile.defaultAccount.balance
        /// Легче было сделать сначала
        /// `let defaultCreditAccount = bankProfile.defaultAccount.creditAccount`
        /// И затем его использовать везде
        if bankProfile.defaultAccount.creditAccount.creditBalance < bankProfile.defaultAccount.creditAccount.creditLimit {
            indebtednessOfClient = bankProfile.defaultAccount.creditAccount.creditLimit - bankProfile.defaultAccount.creditAccount.creditBalance
        }
        /// Аналогично
        if bankProfile.bankAccountsSet.creditBankAccount.creditBalance < bankProfile.bankAccountsSet.creditBankAccount.creditLimit {
            indebtednessOfClient += bankProfile.bankAccountsSet.creditBankAccount.creditLimit - bankProfile.bankAccountsSet.creditBankAccount.creditBalance
        }
        if indebtednessOfClient > bankIndebtednessToClient {
            return "Profile was deleted. U indebt to the bank \(indebtednessOfClient - bankIndebtednessToClient)$"
        } else {
            return "Profile was deleted. Bank indebt to U \(bankIndebtednessToClient - indebtednessOfClient)$"
        }
        
    }
}
var myBankAccountsSet = BankAccountsSet(mixedBankAccount: myMixedAccount, creditBankAccount: myMomsCreditAccount)
var myBankProfile = BankProfile(ownerName: "Artem Drevinskiy", bankAccountsSet: myBankAccountsSet)
print("Information about profile \(myBankProfile.ownerName):\nMain account: balance - \(myBankProfile.defaultAccount.balance)$; credit balance - \(myBankProfile.defaultAccount.creditAccount.creditBalance)$. \nCredit account: credit balance - \(myBankProfile.bankAccountsSet.creditBankAccount.creditBalance); credit limit - \(myBankProfile.bankAccountsSet.creditBankAccount.creditLimit) ")

print(myBankProfile.defaultAccount.withdrawFromBalance(amount: 600))
print(myBankProfile.bankAccountsSet.creditBankAccount.withdrawFromCreditBalance(amount: 90))

print("Information about profile \(myBankProfile.ownerName):\nMain account: balance - \(myBankProfile.defaultAccount.balance)$; credit balance - \(myBankProfile.defaultAccount.creditAccount.creditBalance)$. \nCredit account: credit balance - \(myBankProfile.bankAccountsSet.creditBankAccount.creditBalance); credit limit - \(myBankProfile.bankAccountsSet.creditBankAccount.creditLimit) ")
print(myBankProfile.deleteProfile(bankProfile: myBankProfile))


//: [Next](@next)
