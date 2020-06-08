//
//  MessageView.swift
//  TempMail
//
//  Created by Aravind Koneru on 6/6/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message: MessageModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(message.from)")
                        .font(.headline)
                    Spacer()
                    Text("\(message.date)")
                        .font(.subheadline)
                }
                
                Text("\(message.subject)")
                    .font(.title)
            }.padding()
            Divider()
            Spacer()
            
            Text(message.textBody)
        }
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: MessageModel(id: 1, from: "from@example.com", subject: "sample subject", date: "Today", attachments: nil, body: "somne text", textBody: "some text", htmlBody: "<h1> some text </h1>"))
    }
}
