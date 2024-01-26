//
//  CardView.swift
//  FlashZilla
//
//  Created by M Sapphire on 2024/1/23.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnable
    let card: Card
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    enum direction {
        case left, right, none
    }
    @State private var releaseDirection = direction.none
    
    var removeval: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? .green : (releaseDirection == .right ? .green : .red))
                )
                .shadow(radius: 10)
                
            VStack {
                if voiceOverEnable {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(Angle(degrees: Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    if offset.width > 0 {
                        releaseDirection = .right
                    } else {
                        releaseDirection = .left
                    }
                }
                .onEnded { gesture in
                    if abs(offset.width) > 100 {
                        removeval?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                isShowingAnswer.toggle()
            }
        }
        .animation(.spring, value: offset)
    }
}

#Preview {
    CardView(card: Card.example)
}
