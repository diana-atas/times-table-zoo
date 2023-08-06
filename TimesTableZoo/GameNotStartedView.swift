//
//  GameNotStartedView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 27/07/23.
//

import SwiftUI

struct GameNotStartedView: View {
    let columns = [
        GridItem(.adaptive(minimum: 90))
    ]

    var body: some View {
        Text("Pick a multiplier")
            .font(.headline)

        LazyVGrid(columns: columns) {
            ForEach(1..<13) { multiplier in
                Button {
                    selectMultiplier(multiplier: multiplier)
                } label: {
                    Text("\(multiplier)")
                        .frame(width: 90, height: 90)
                }
                .padding(10)
                .foregroundColor(.white)
                .background(selectedMultiplier == multiplier ? .red : .blue)
                .clipShape(Circle())
                .scaleEffect(selectedMultiplier == multiplier ? 1 : 0.8)
                .animation(.interpolatingSpring(stiffness: 100, damping: 100), value: selectedMultiplier)
            }
        }
        .padding(.horizontal)

        Section {
            Picker("Pick number of questions", selection: $selectedNumberOfQuestions) {
                ForEach(numberOfQuestions, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.segmented)
        } header: {
            Text("Pick number of questions")
        }

        Button("Start") {
            startGame()
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

struct GameNotStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GameNotStartedView()
    }
}
