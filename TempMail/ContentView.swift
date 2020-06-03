//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var email_addr: String
    
    var body: some View {
        VStack {
            Text("Temp Mail")
                .font(.largeTitle)
                .padding()
            Spacer()
            
            Button(action: {
                print("generate new email addr")
            }) {
                Text("Generate New Email")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.blue, lineWidth: 5))
            }
            
            Spacer()
            
            Text("Current Address: \(email_addr)")
                .padding()
            
            Spacer()
            
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
        ContentView(email_addr: "bob@example.com")
    }
}
