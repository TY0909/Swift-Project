//
//  ContentView.swift
//  Animations
//
//  Created by M Sapphire on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    //@State private var animateAmount = 1.0
    //@State private var degree = 0.0
    
    //@State private var animationAmount = 1.0
    
    //@State private var rotate3DAmount = 0.0
    
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    
    var body: some View {
        //the content below is the implict animation
        /*Button() {
            //animateAmount += 1
            degree += 180
        } label: {
            Image(systemName: "pencil")
                .imageScale(.large)
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.primary)
        .clipShape(.circle)
        //.scaleEffect(animateAmount)
        .rotationEffect(.degrees(degree))
        .animation(.default, value: degree)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animateAmount)
                .opacity(2-animateAmount)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animateAmount)
        )
        .onAppear {
            animateAmount = 2
        }*/
        
        /*VStack {
                   Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

                   Spacer()

                   Button("Tap Me") {
                       animationAmount += 1
                   }
                   .padding(40)
                   .background(.red)
                   .foregroundStyle(.white)
                   .clipShape(.circle)
                   .scaleEffect(animationAmount)
               }*/
        
        /*Button("tap me") {
            withAnimation {
                rotate3DAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(rotate3DAmount),
                                  axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )*/
        
        //the content below is about gestrue
        /*LinearGradient(colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 50))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged {
                        dragAmount = $0.translation
                    }
                    .onEnded { _ in
                        //withAnimation {
                            dragAmount = .zero
                        //}
                    }
            )
            .animation(.bouncy, value: dragAmount)
        HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled ? .blue : .red)
                            .offset(dragAmount)
                            .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            dragAmount = .zero
                            enabled.toggle()
                        }
                )*/
    }
}

#Preview {
    ContentView()
}
