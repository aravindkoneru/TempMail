//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //variables for Email struct and
    @State var email = Email()
    
    var body: some View {
        VStack {
            Text("Temp Mail")
                .font(.largeTitle)
                .padding()
            Spacer()
            Button(action: {
                self.email.GenEmail()
            }) {
                Text("Generate New Email")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.blue, lineWidth: 5))
            }
            
            Spacer()
            
            Text(email.getEmailAddr())
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
        ContentView()
    }
}
