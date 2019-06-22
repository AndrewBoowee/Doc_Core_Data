//
//  SingleExpenseViewController.swift
//  Expenses
//
//  Created by Tech Innovator on 11/30/17.
//  Copyright © 2017 Tech Innovator. All rights reserved.
//

import UIKit

class SingleExpenseViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var exsistingExpense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        amountTextField.delegate = self
        
        
        nameTextField.text = exsistingExpense?.name
        
        if let amount = exsistingExpense?.amount
        {
            amountTextField.text = "\(amount)"
        }
        else
        {
            amountTextField.text = ""
        }
        
        if let date = exsistingExpense?.date
        {
            datePicker.date = date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveExpense(_ sender: Any)
    {
        let name = nameTextField.text
        let amountText = amountTextField.text ?? ""
        let amount = Double(amountText) ?? 0.0
        let date = datePicker.date
        
        var expense: Expense?
        
        if let exsistingExpense = exsistingExpense
        {
            exsistingExpense.name = name
            exsistingExpense.amount = amount
            exsistingExpense.date = date
            
            expense = exsistingExpense
        }
        else
        {
            expense = Expense(name: name, amount: amount, date: date)
        }
        
        if let expense = expense
        {
        do
        {
            let managedContext = expense.managedObjectContext
            
            try managedContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        }
        catch
        {
            print("Context could not be saved")
        }
        }
    }
}

extension SingleExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
