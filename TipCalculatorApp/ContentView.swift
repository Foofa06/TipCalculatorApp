//
//  ContentView.swift
//  TipCalculatorApp
//
//  Created by Fawzia Jassim on 1/27/26.
//

import SwiftUI

struct ContentView: View {

    // MARK: - State Variables
    @State private var billAmount: Double = 50
    @State private var tipPercentage: Double = 15
    @State private var numberOfPeople: Double = 1
    @State private var showResults: Bool = false
    @State private var selectedCurrency: String = "USD"

    let currencies = ["USD", "EUR", "GBP", "JPY"]

    // MARK: - Computed Properties
    var tipAmount: Double {
        billAmount * tipPercentage / 100
    }

    var totalAmount: Double {
        billAmount + tipAmount
    }

    var amountPerPerson: Double {
        totalAmount / numberOfPeople
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {

                // Subtitle
                Text("Modern Tip Calculator")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Title
                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Dollar Icon
                Image(systemName: "dollarsign")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 90, height: 90)
                    .background(Color.black)
                    .clipShape(Circle())
                    .shadow(radius: 6)

                // Currency Picker
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // The Bill Amount
                VStack(spacing: 8) {
                    Text("Bill Amount")
                        .font(.headline)

                    Text("\(billAmount, format: .currency(code: selectedCurrency))")
                        .foregroundColor(.purple)
                        .font(.title2)
                        .fontWeight(.bold)

                    Slider(value: $billAmount, in: 0...500, step: 1)
                        .tint(.purple)
                }
                .padding()

                // Tip Percentage
                VStack(spacing: 8) {
                    Text("Tip Percentage")
                        .font(.headline)

                    Text("\(Int(tipPercentage))%")
                        .foregroundColor(.green)
                        .font(.title2)
                        .fontWeight(.bold)

                    Slider(value: $tipPercentage, in: 0...30, step: 1)
                        .tint(.green)
                }
                .padding()

                // The Number of People
                VStack(spacing: 8) {
                    Text("Number of People")
                        .font(.headline)

                    Text("\(Int(numberOfPeople))")
                        .foregroundColor(.orange)
                        .font(.title2)
                        .fontWeight(.bold)

                    Slider(value: $numberOfPeople, in: 1...20, step: 1)
                        .tint(.orange)
                }
                .padding()

                // Calculate / Hide Results Button
                Button {
                    withAnimation {
                        showResults.toggle()
                    }
                } label: {
                    Text(showResults ? "Hide Results" : "Calculate")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(showResults ? Color.red : Color.black)
                        .cornerRadius(14)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)

                // Results Card
                if showResults {
                    VStack(spacing: 10) {
                        Text("Tip Amount: \(tipAmount, format: .currency(code: selectedCurrency))")
                        Text("Total Amount: \(totalAmount, format: .currency(code: selectedCurrency))")
                        Text("Amount per Person: \(amountPerPerson, format: .currency(code: selectedCurrency))")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(radius: 8)
                    .padding(.top)
                }
            }
            .padding()
            .padding(.bottom, 30)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview("Tip Calculator App") {
    ContentView()
}


