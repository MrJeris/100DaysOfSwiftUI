//
//  Drawing.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct Arrow: Shape {
    var headHeight = 0.5
    var shaflWidth = 0.5
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(headHeight, shaflWidth) }
        set {
            shaflWidth = newValue.first
            headHeight = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight
        let thikness = rect.width * shaflWidth / 4
        
        return Path() { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thikness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thikness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thikness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thikness, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                            endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Drawing: View {
    @State private var show = false
    
    @State private var headHeight = 0.5
    @State private var shaflWidth = 0.5
    @State private var color = 0.2
    
    
    @State private var colorCycle = 0.0
    @State private var gradientStartX = 0.0
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 1.0
    
    var body: some View {
        NavigationView {
            Group {
                if show {
                    Arrow(headHeight: headHeight, shaflWidth: shaflWidth)
                        .fill(Color(hue: color, saturation: 1, brightness: 1))
                        .onTapGesture {
                            withAnimation {
                                headHeight = Double.random(in: 0.2...0.8)
                                shaflWidth = Double.random(in: 0.2...0.8)
                                color = Double.random(in: 0...1)
                            }
                        }
                        .padding(30)
                } else {
                    VStack(spacing: 30) {
                        ColorCyclingRectangle(
                            amount: colorCycle,
                            gradientStartX: gradientStartX,
                            gradientStartY: gradientStartY,
                            gradientEndX: gradientEndX,
                            gradientEndY: gradientEndY
                        )
                        .frame(width: 300, height: 300)
                        
                        HStack {
                            Text("Color")
                            Slider(value: $colorCycle)
                        }
                        
                        HStack {
                            Text("Start X")
                            Slider(value: $gradientStartX)
                        }
                        
                        HStack {
                            Text("Start Y")
                            Slider(value: $gradientStartY)
                        }
                        
                        HStack {
                            Text("End X")
                            Slider(value: $gradientEndX)
                        }
                        
                        HStack {
                            Text("End Y")
                            Slider(value: $gradientEndY)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
        .navigationTitle("Drawing")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            Button {
                show.toggle()
            } label: {
                Text("Стрелка или градиентный круг")
            }
        }
    }
}

struct Drawing_Previews: PreviewProvider {
    static var previews: some View {
        Drawing()
    }
}
