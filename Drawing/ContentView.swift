//
//  ContentView.swift
//  Drawing
//
//  Created by Vikas Bhandari on 17/7/2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Arc: InsettableShape { //insettableShape builds on Shape so no need to add both
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    var insetAmount = 0.0
    
    // inset(by: ) is required to conform to InsettableShape protocol, once a shape conforms to this, we can use strokeborder
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount = amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        return path
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
                //            path.closeSubpath() //this one connects the last line to the first line when using stroke below to draw borders
            }
            //        .stroke(.blue, lineWidth: 10)
            .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            
            Triangle()
            //            .fill(.red) //fill's fill the entire shape
            //strokes only do the border. linecap: .round makes the end of the line round. linejoin: . round mkaes the line joines round too
                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
        }
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockWise: true)
 //           .stroke(.blue, lineWidth: 10)
        //using strokeborder now that arc conforms to insettableShape
            .strokeBorder(.blue, lineWidth: 15)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
        
        // refer to project 9 day 2 to understand which direction shapes count degrees from.
        
        Circle()
            .strokeBorder(.purple, lineWidth: 8)
        
    }
}

#Preview {
    ContentView()
}
