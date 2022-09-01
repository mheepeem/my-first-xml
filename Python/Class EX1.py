class ATM:
    def __init__(self, company, balance):
        self.company = company
        self.balance = balance

    # def transaction(self, activity, money):
    #     if activity == "deposit":
    #         print(f"Your deposit amount is +{money}.")
    #         self.balance += money
    #         print(f"Your balance now: {self.balance}.")
    #     elif activity == "withdraw":
    #         print(f"Your withdraw amount is -{money}.")
    #         self.balance -= money
    #         print(f"Your balance now: {self.balance}.")

    def transaction(self):
        print("1. deposit")
        print("2. withdraw")
        while True:
            choice = int(input(f"Please select your choice with number: "))
            if choice == 1:
                money = int(input(f"Your deposit amount is: "))
                self.balance += money
                print(f"Your balance now: {self.balance}.")
                break
            elif choice == 2:
                money = int(input(f"Your withdraw amount is: "))
                self.balance -= money
                print(f"Your balance now: {self.balance}.")
                break
            else:
                print("Please try again.")

    def check_balance(self):
        print(f"Your balance now: {self.balance}.")

    def transfer(self):
        while True:
            bank = input(f"Please select bank you want to transfer: ")
            if (bank == "TMB" or bank == "K-bank"):
                break
            else:
                print("Please try again.")
        while True:
            account_id = input(f"Please enter account number you want to transfer: ")
            if len(account_id) != 10:
                print("Please try again.")
            else:
                break
        while True:
            money = input(f"Please enter amount of money: ")
            if int(money) < 100:
                print("Minimum is 100, please try again.")
            else:
                break
        print("-------------------------------------------------------------------------")
        print(f"Bank: {bank}")
        print(f"Transfer to Account: {account_id}")
        print(f"Amount: {money}")
        check = input(f"Is your information correct? y/n: ")
        if check == "y":
            print("Your transaction is complete. Thank you :)")
        elif check == "n":
            print("END")
        else:
            print("Please try again.")
