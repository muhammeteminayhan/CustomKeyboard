//
//  ContentView.swift
//  CustomKeyboard
//
//  Created by Muhammet Emin Ayhan on 6.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isActive: Bool
    var body: some View {
        NavigationStack {
            CustomTextFieldWithKeyboard {
                TextField("App Pin Code", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 250)
                    .background(.fill, in: .rect(cornerRadius: 15))
                    .focused($isActive)
            } keyboard: {
                CustomKeyboardView(text: $text, isActive: $isActive)
            }
            .navigationTitle("Custom Keyboard")

        }
    }
}
struct CustomKeyboardView: View {
    @Binding var text: String
    @FocusState.Binding var isActive: Bool
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3),  spacing: 15) {
            ForEach(1...9, id: \.self) { index in
                ButtonView("\(index)")
            }
            ButtonView("delete.backward.fill", isImage: true)
            ButtonView("0")
            ButtonView("checkmark.circle.fill", isImage: true)
        }
        .padding(15)
        .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    }
    
    @ViewBuilder
    func ButtonView(_ value: String, isImage: Bool = false) -> some View {
        
        Button {
            if isImage {
                if value == "delete.backward.fill" && !text.isEmpty {
                    // Delete Last Character
                    text.removeLast()
                }
                if value == "checkmark.circle.fill" {
                    // Close Keyboard
                    isActive = false
                }
            } else {
                text += value
            }
            
        } label: {
            Group {
                if isImage {
                    Image(systemName: value)
                } else {
                    Text(value)
                }
            }
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 50, height: 50)
            .background {
                if !isImage {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)))
                }
            }
            .foregroundStyle(Color.primary)
        }

    }
}

#Preview {
    ContentView()
}
