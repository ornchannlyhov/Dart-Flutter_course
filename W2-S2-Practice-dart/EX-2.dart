enum Status {
  ACTIVE("active"),
  INACTIVE("inactive"),
  CLOSED("closed"),
  SUSPENDED("suspended"),
  PENDING("pending");

  final String label;
  const Status(this.label);

  String toString() => 'Status: $label';
}

class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final String description;

  Transaction(this.id, this.amount, this.date, this.description);

  @override
  String toString() {
    return 'Transaction ID: $id \n'
        'Amount: $amount \n'
        'Date: ${date.toIso8601String()} \n'
        ' Description: $description';
  }
}

class BankAccount {
  final String _accountNumber;
  final String _accountType;
  final String _accountHolder;
  double _balance;
  final double _interestRate;
  final DateTime _createdDate;
  Status _status;
  List<Transaction> _transactions;

  // Constructor
  BankAccount({
    required String accountNumber,
    required String accountType,
    required String accountHolder,
    required double balance,
    required double interestRate,
    required DateTime createdDate,
    required Status status,
    List<Transaction>? transactions,
  })  : _accountNumber = accountNumber,
        _accountType = accountType,
        _accountHolder = accountHolder,
        _balance = balance,
        _interestRate = interestRate,
        _createdDate = createdDate,
        _status = status,
        _transactions = transactions ?? [];

  // Getter for balance
  double get balance => _balance;

  //credit money into the account
  void credit(double amount) {
    if (amount <= 0) {
      throw Exception('Amount must be greater than zero.');
    }
    _balance += amount;
    _transactions.add(Transaction(
        'TX${_transactions.length + 1}', amount, DateTime.now(), 'Credit'));
  }

  //withdraw money from the account
  void withdraw(double amount) {
    if (amount <= 0) {
      throw Exception('Amount must be greater than zero.');
    }
    if (amount > _balance) {
      throw Exception('Insufficient balance for withdrawal!');
    }
    _balance -= amount;
    _transactions.add(Transaction('TX${_transactions.length + 1}', -amount,
        DateTime.now(), 'Withdrawal'));
  }

  @override
  String toString() {
    return 'Account Number: $_accountNumber\n'
        'Account Type: $_accountType\n'
        'Account Holder: $_accountHolder\n'
        'Balance: $_balance\n'
        'Interest Rate: $_interestRate\n'
        'Created Date: $_createdDate\n'
        'Status: $_status\n'
        'Transactions: $_transactions\n'
        '------------------------------';
  }
}

class Bank {
  final String name;
  final String address;
  final String contactInfo;
  List<BankAccount> _accounts;

  Bank({
    required this.name,
    required this.address,
    required this.contactInfo,
  }) : _accounts = [];

  //create a new account
  BankAccount createAccount({
    required String accountNumber,
    required String accountType,
    required String accountHolder,
    required double initialBalance,
    required double interestRate,
    required Status status,
  }) {
    // Check if the account already exists
    if (_accounts.any((account) => account._accountNumber == accountNumber)) {
      throw Exception('Account with ID $accountNumber already exists!');
    }
    var newAccount = BankAccount(
      accountNumber: accountNumber,
      accountType: accountType,
      accountHolder: accountHolder,
      balance: initialBalance,
      interestRate: interestRate,
      createdDate: DateTime.now(),
      status: status,
    );
    _accounts.add(newAccount);
    return newAccount;
  }

  //get account by account number
  BankAccount getAccount(String accountNumber) {
    return _accounts.firstWhere(
      (account) => account._accountNumber == accountNumber,
      orElse: () =>
          throw Exception('Account with number $accountNumber not found!'),
    );
  }

  //list all accounts
  void listAccounts() {
    for (var account in _accounts) {
      print(account);
    }
  }

  String toString() {
    return 'Bank Name: $name\n'
        'Address: $address\n'
        'Contact Info: $contactInfo\n'
        'Accounts:\n${_accounts.isEmpty ? 'No accounts available.' : _accounts.join('\n')}\n'
        '------------------------------';
  }
}

void main() {
  // Create a bank
  var myBank = Bank(
    name: 'CADT Bank',
    address: '123 Bank St',
    contactInfo: 'info@cadtbank.com',
  );

  // Create accounts
  try {
    var account1 = myBank.createAccount(
      accountNumber: '001',
      accountType: 'Savings',
      accountHolder: 'Ronan',
      initialBalance: 0,
      interestRate: 0.02,
      status: Status.ACTIVE,
    );

    print(account1);
    account1.credit(100);
    print('Balance after credit: ${account1.balance}');

    account1.withdraw(50);
    print('Balance after withdrawal: ${account1.balance}');
    try {
      account1.withdraw(75);
    } catch (e) {
      print(e);
    }
    // List all accounts
    myBank.listAccounts();
  } catch (e) {
    print(e);
  }
}
