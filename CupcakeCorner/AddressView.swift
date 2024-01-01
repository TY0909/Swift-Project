//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by M Sapphire on 2023/12/9.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("StreetAddress", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section {
                    NavigationLink("Checkout") {
                        CheckOutView(order: order)
                    }
                    .disabled(order.isAddressValid() == false)
                }
            }
            .navigationTitle("Delivery deatils")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddressView(order: Order())
}
