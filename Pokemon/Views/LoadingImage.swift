//
//  LoadingImage.swift
//  Pokemon
//
//  Created by Eric Romrell on 6/24/21.
//

import SwiftUI

struct LoadingImage: View {
    @State private var hitTheSide: Bool = true
    @State private var shouldGoLeft: Bool = true
    @State private var degrees: Double = 0
    private let animation = Animation.linear(duration: 0.1)
    
    var body: some View {
        Image("pokeball")
            .resizable()
            .scaledToFit()
            .modifier(AnimatableModifierDouble(animatableData: degrees, targetHandlers: [
                (20, {
                    hitTheSide = true
                    withAnimation(animation) {
                        degrees = 0
                    }
                }),
                (-20, {
                    hitTheSide = true
                    withAnimation(animation) {
                        degrees = 0
                    }
                }),
                (0, {
                    // Only fire if they hit a side
                    if hitTheSide {
                        hitTheSide = false
                        shouldGoLeft.toggle()
                        withAnimation(animation.delay(0.75)) {
                            degrees = shouldGoLeft ? 20 : -20
                        }
                    }
                })
            ]))
            .rotationEffect(.degrees(degrees))
            .onAppear {
                withAnimation(animation) {
                    degrees = 20
                }
            }
    }
}

struct AnimatableModifierDouble: AnimatableModifier {
    // SwiftUI gradually varies it from old value to the new value
    var animatableData: Double {
        didSet {
            checkIfFinished()
        }
    }
    
    var targetHandlers: [(Double, () -> ())]

    func checkIfFinished() -> () {
        targetHandlers.forEach { (targetValue, completion) in
            //print("Current value: \(animatableData)")
            if (animatableData == targetValue) {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }

    // Called after each gradual change in animatableData to allow the
    // modifier to animate
    func body(content: Content) -> some View {
        // content is the view on which .modifier is applied
        content
        // We don't want the system also to
        // implicitly animate default system animatons it each time we set it. It will also cancel
        // out other implicit animations now present on the content.
            .animation(nil)
    }
}

struct LoadingImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImage()
    }
}
