//
//  Email.swift
//  TempMail
//
//  Created by Paul Jojy on 6/3/20.
//  Copyright © 2020 Paul Jojy. All rights reserved.
//

//This is supposed to be an "Email" Object. The purpose of the email object will be to generate and store the email address, along with the emails attached to it. 
import SwiftUI

class Email : ObservableObject{
    @Published var email_addr: String
    
//  init method
    init() {
        self.email_addr = ""
        genEmailAddr()
    }
//  generates an email address
    func genEmailAddr() -> Void {
        //list of acceptable chars
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//      returns a random permutation of letters; string of up to length 9       for email addr
        self.email_addr = String((0..<9).map{ _ in letters.randomElement()!})
    }
    
//  getter for email addr
    func getEmailAddr() -> String {
        return "Current Address: \(email_addr)@1secmail.com"
    }
//  getter for emails
    func getEmails() {
//        make the HTTP GET request to return the JSON shit
    }
}