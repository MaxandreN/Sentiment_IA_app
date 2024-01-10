//
//  ContentView.swift
//  Sentiment_IA_app
//
//  Created by Maxandre Neveux on 10/01/2024.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
}

extension Sentiment {
    func getColor()-> Color{
        switch self {
        case .positive:
            return Color.green
        case .negative:
            return Color.red
        case .mixed:
            return Color.purple
        case .neutral:
            return Color.gray
        }
    }
  
    func getEmoji() -> String{
        switch self {
        case .positive:
            return "😃"
        case .negative:
            return "😕"
        case .mixed:
            return "😑"
        case .neutral:
            return "😌"

        }
    }
}

struct ContentView: View {
    @State private var modelInput: String = ""
    @State private var modelOutput: String = ""
    @State public var outputSentiment: Sentiment? = nil
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading, spacing: 18) {
                    Text("Entez une phrase, l'IA va deviner votre sentiment")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                    TextEditor(text: $modelInput)
                    .onChange(of: modelInput, {
                        oldValue, newValue in 
                        outputSentiment = nil
                    })
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    Button(action: {
                        classify()
                    }, label: {
                        Text("Deviner le sentiment")
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .buttonStyle(BorderedButtonStyle())
                    .padding()
                    .disabled(modelInput.isEmpty)
                }
                .padding()
                .background(.purple)
                VStack{
                    Text(outputSentiment?.getEmoji() ?? "")
                    Text(outputSentiment?.rawValue ?? "")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(outputSentiment?.getColor().gradient ?? Color.blue.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .opacity(outputSentiment == nil ? 0 : 1.0)
                .scaleEffect(outputSentiment == nil ? 0.3 : 1.0)
                .animation(.bouncy, value: outputSentiment)
            }.navigationTitle("🧠 IA du future")
        }
    }
    
    func classify() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try Sentiment_ia_1(configuration: .init())
            let prediction = try model.prediction(text: modelInput)
            modelOutput = prediction.label
            outputSentiment = Sentiment(rawValue: modelOutput)
        } catch {
            modelOutput = "Something went wrong"
        }
    }
}



#Preview {
    ContentView()
}
