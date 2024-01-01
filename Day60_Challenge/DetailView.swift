//
//  DetailView.swift
//  Day60_Challenge
//
//  Created by M Sapphire on 2023/12/21.
//

import SwiftUI

struct DetailView: View {
    var user: User
    
    var body: some View {
        NavigationStack {
            List {
                Text("Name: \(user.name)")
                Text("Address:  \(user.address)")
                Text("Company:  \(user.company)")
                Text("About:    \(user.about)")
                Section("friends") {
                    ForEach(user.friends, id: \.id) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(user: User(isActive: false, name: "name", age: 19, company: "company", email: "mail", address: "address", about: "about", tags: ["tags"], friends: [Friends(name: "friends")]))
}
