//
//  ContentView.swift
//  TempMail
//
//  Created by Aravind Koneru on 5/25/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
    var email_addr: String
    
    // TODO: can the header be abstracted? lots of repeated code...
    
    var body: some View {
        return HStack {
            if orientation.isPortrait {
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
                    
                    Button(action: {
                        print("copy to clipboard")
                        UIPasteboard.general.string = self.email_addr
                        //                let copiedIcon = UIImage(systemName: "doc.on.clipboard")
                    }) {
                        Text("\(email_addr)")
                            .padding()
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    
                    
                    
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
            } else {
                VStack {
                    Text("Temp Mail")
                        .font(.largeTitle)
                        .padding()
                    
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
                    
                    Button(action: {
                        print("copy to clipboard")
                        UIPasteboard.general.string = self.email_addr
                        //                let copiedIcon = UIImage(systemName: "doc.on.clipboard")
                    }) {
                        Text("\(email_addr)")
                            .padding()
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                
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
        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) {_ in
            self.orientation = UIDevice.current.orientation
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(email_addr: "bob@example.com")
    }
}
