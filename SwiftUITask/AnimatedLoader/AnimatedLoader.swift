//
//  AnimatedLoader.swift
//  SwiftUITask
//
//  Created by Decagon on 04/11/2021.
//

import SwiftUI

struct AnimatedLoader: View {
    
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.75
    
    @State var isAnimating: Bool = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = Angle.degrees(0)
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 20))
                    .fill(Color.white)
                Circle()
                    .trim(from: circleStart, to: circleEnd)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .fill(Color.black)
                    .rotationEffect(self.rotationDegree)
            }.frame(width: 200, height: 200)
            .onAppear() {
                self.animateLoader()
                Timer.scheduledTimer(withTimeInterval: self.trackerRotation * self.animationDuration + (self.animationDuration), repeats: true) { (mainTimer) in
                    self.animateLoader()
                }
            }
        }
    }
    
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation) + .degrees(120)
    }
    
    func animateLoader() {
        withAnimation(Animation.spring(response: animationDuration * 2 )) {
            self.rotationDegree = .degrees(-57.5)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.trackerRotation * self.animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: (self.trackerRotation * self.animationDuration) / 2.25 )) {
                self.circleEnd = 0.925
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            self.rotationDegree = .degrees(47.5)
            withAnimation(Animation.easeOut(duration: self.animationDuration)) {
                self.circleEnd = 0.325
            }
        }
    }
}

struct AnimatedLoader_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedLoader()
    }
}
