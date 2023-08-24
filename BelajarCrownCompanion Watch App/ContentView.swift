//
//  ContentView.swift
//  BelajarCrownCompanion Watch App
//
//  Created by Gregorius Yuristama Nugraha on 8/21/23.
//

import SwiftUI
import WatchKit
import CoreMotion


struct ContentView: View {
    @State var scrollAmount = 0.0
    @State var motionManager = CMMotionManager()
    @State var deviceMotion = CMDeviceMotion()
    @State private var accData = "Gyro Data:\nPitch: 0.0\nRoll: 0.0\nYaw: 0.0"
    @State private var ballPosition: CGSize = .zero
    
    @State private var currentShape: Int = 0
    
    @ObservedObject var data = WatchDataModel.shared
    var body: some View {
        //        VStack {
        //            Button {
        //                playLightRainHapticPattern()
        //            } label: {
        //                Text("Tap me for Haptic Feedback")
        //                    .padding()
        //                    .background(Color.blue)
        //                    .foregroundColor(.white)
        //                    .cornerRadius(10)
        //            }
        //
        //        }
        //        .padding()
        
        //        VStack {
        //            Rectangle()
        //                .rotation(Angle(degrees: scrollAmount))
        //                .focusable(true)
        //                .digitalCrownRotation($scrollAmount, from: 1, through: 360, by: 1, sensitivity: .high, isContinuous: true, isHapticFeedbackEnabled: true)
        //            Text(accData)
        //                .onAppear{
        //                    print("cekk")
        //                    print(motionManager.isAccelerometerAvailable)
        //                    motionManager.accelerometerUpdateInterval = 0.1
        //                    motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
        //                        if let accRate = data?.acceleration {
        //                            let pitch = accRate.x
        //                            let roll = accRate.y
        //                            let yaw = accRate.z
        //
        //                            self.accData = String(format: "Gyro Data:\nPitch: %.2f\nRoll: %.2f\nYaw: %.2f", pitch, roll, yaw)
        //                        }
        //                    }
        //                    //
        //
        //                }
        //        }
        
        
        GeometryReader { geometry in
            //            VStack {
            //                Text("\(data.fidgetShape.rawValue)")
            //                if data.fidgetShape == 0 {
            Circle()
                .frame(width: 30, height: 30)
                .position(x: geometry.size.width / 2 + ballPosition.width,
                          y: geometry.size.height / 2 + ballPosition.height)
            //                } else {
            //                    Rectangle()
            //                        .frame(width: 30, height: 30)
            //                        .position(x: geometry.size.width / 2 + ballPosition.width,
            //                                  y: geometry.size.height / 2 + ballPosition.height)
            //                }
            
            //            }
                .onAppear {
                    if motionManager.isAccelerometerAvailable {
                        motionManager.accelerometerUpdateInterval = 0.1 // Set your desired interval
                        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                            if let acceleration = data?.acceleration {
                                let maxX = geometry.size.width / 2 - 15
                                let maxY = geometry.size.height / 2 - 15
                                
                                let newX = CGFloat(acceleration.x) * maxX
                                let newY = CGFloat(-acceleration.y) * maxY
                                withAnimation {
                                    self.ballPosition = CGSize(width: newX, height: newY)
                                }
                            }
                        }
                    }
                }
                .onDisappear {
                    motionManager.stopAccelerometerUpdates()
                }
        }
        
        
    }
    
    
    
    func playLightRainHapticPattern() {
        let hapticTypes: [WKHapticType] = [.click, .directionUp, .directionDown, .click, .directionUp, .directionDown]
        
        for hapticType in hapticTypes {
            WKInterfaceDevice.current().play(hapticType)
            // Pause briefly between haptic types to simulate a pattern
            Thread.sleep(forTimeInterval: 0.2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
