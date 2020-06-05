//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    variable for Email struct
    @ObservedObject var email: Email = Email()
    //this variable is for later, when I implement a feature that will save user data even when the app is closed
    private let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
//          title
            Text("Temp Mail")
                .font(.largeTitle)
                .padding()
            Spacer()
//          Generate new email button
            Button(action: {
                self.email.setNewEmailAddr()
            }) {
                Text("Generate New Email")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.blue, lineWidth: 5))
            }
            
            Spacer()
//          display email address for user
            Text("Current Address: \(self.email.getEmailAddr())@1secmail.com")
                .padding()
            
            Spacer()
//          List of emails attached to above address
            List {
                MessageRow(messageInfo: InboxModel(id: 1234,
                                                   from: "sender@example.com",
                                                   subject: "example subject",
                                                   date: "Today"))
                MessageRow(messageInfo: InboxModel(id: 1234,
                                                   from: "sender@example.com",
                                                   subject: "example subject",
                                                   date: "Today"))
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
