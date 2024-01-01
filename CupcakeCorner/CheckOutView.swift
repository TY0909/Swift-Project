//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by M Sapphire on 2023/12/9.
//

import SwiftUI

struct CheckOutView: View {
    var order: Order
    
    @State private var confirmMessage = ""
    @State private var showingConfirm = false
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirm) {
            Button("OK", action: {})
        } message: {
            Text(confirmMessage)
        }
        .alert("Error", isPresented: $showingError) {
            Button("OK", action: {})
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode the order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
            
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            
            confirmMessage = "Your order for \(decoded.quantity) x \(Order.types[decoded.type]) is on its way"
            showingConfirm = true
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            errorMessage = "there is an error occured: \(error.localizedDescription)"
            showingError = true
        }
    }
}

#Preview {
    CheckOutView(order: Order())
}
