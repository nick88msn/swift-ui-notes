# Swift UI

A declarative user interface for developing apps on every Apple platform.
SwiftUI provides views, controls, and layout structures for declaring your app user interface. The framework provides event handlers for delivering taps, gestures, and other types of input, and tools to manage the flow of data from app’s models down to the views and controls. [Apple Official Documnentation](https://developer.apple.com/documentation/swiftui/)

Swift UI uses the Swift programming language [Swift Notes](https://github.com/nick88msn/swift-starter-kit)

## Your first view
Swift UI does a great job separating the interface from the logic.
A View and most of the types we are gonna use in Swift UI are Struct.
Struct are commons in other language programs are an abbreviation for 
Data Structure. A struct can be seen as a collections of variables, however we'll
see they are powerful types on which most of the Swift UI elements are built up.
Struct have variables but can also have functions. They are similar to classes
but we'll see they lack inheritance. Struct are not object oriented things.
Swift support also classes and supports both Object Oriented Programming or Functional Programming.
We'll use OOP to hook our models to the UI, while our logic and UI will basically a set of structs.

A basic Swift UI view can be:
```Swift
struct MyFirstView: View {
    var body: some View {
        Text("Hello World")
    }

}
```

In functional programming the behavior of things is important. In this case the struct MyFirstView "behaves" like a View.
Behaving like something in functional programming usually mean we inherit some work already done for us but also means we may need to 
provide something to conform to the type. In the case of View, we'll see that View is a Swift protocol. 
It is possible to create custom views by declaring types that conform to the [View](https://developer.apple.com/documentation/swiftui/view) protocol. 
To conform to the protocol we need to implement the required body computed property to provide the content for our custom view.

.....

# Animation
Animation is very important in a mobile UI.
Swift makes very easy to do.
There are basically two ways to do animation: 
1. by animating a Shape
2. by animating Views via their ViewModifiers

## So what is a ViewModifier?
View modifiers are all those little functions that modified our Views (like aspectRatio, padding etc)
They are (likely) turning right aroud and calling a function in View called Modifier.
e.g. .aspectRatio(2/3) is likely something like .modifier(AspectModifier(2/3))
AspectModifier can be anything that conforms to the ViewModifier protocol.

[Apple Documentation - View Modifier](https://developer.apple.com/documentation/swiftui/viewmodifier)
A modifier that you apply to a view or another view modifier, producing a different version of the original value.

ViewModifier is a protocol that lets us create a reusable modifier that can be applied to any view.

Conceptually, this protocol is sort of like this...
```Swift
protocol ViewModifier{
    typealias Content //the type of the View passed to body(content:)
    func body(content: Content) -> some View {
        //return some View that almost certainly contains the View content
    }
}
```

An example of view modifier is:
```Swift

struct BorderdLabel: ViewModifier{
    var isSet: Bool
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius:10))
    }.foregroundColor(Color.blue)
}
```
Where Content is the View that we are actually going to modify. 
The code is similar to the View code, but we have func body(content:) instead of var body.
That's beacause ViewModifiers are Views, and writing the code for one is almost identical.
There is also a special ViewModifier, GeometryEffect, for building geometry modifiers (scaling, rotation etc..).

## How to apply a ViewModifier?
We have two ways to apply a view modifier:
1. Apply the modifier directly to the view (e.g. Text("Some Text").modifier(BorderedLabel()))
2. Create an extension that use a modifier to the View itself and return the View modified

```Swift
extension View{
    func borderedLabel(isSet: Bool) -> some View {
        return self.modifier(BorderedLabel(isSet: isSet))
    }
}
```

It is important to highlight a couple of things on how this works.
1. The content argument is just the Text view we pass
2. We pass the arguments like in the View
3. We could have an init (it is allowed)

These arguments are crucial in ViewModifiers since when this changes it will kick off an animation.
ViewModifiers always return a View (some View) not multiple views or something else.
They take a view and return a new one (remember they are structs, they are read only in memory so we return always a new one).

P.S. (ViewModifiers do not have var body so you do not need the SwiftUI Template when implementing on a single new file)

## [Animation](https://www.youtube.com/watch?v=PoeaUMGAx6c)
Basics:
- Important takeaways about Animation
  - Only changes can be animated. Changes to what?
    - arguments to ViewModifiers  
    - arguments to the cretion of Shapes
    - the existence (or not) of a View in the UI
- Animation is showing the user changes that have already happened (i.e.the recent past)
  - Our code does something, makes a change, and only then swift ui triggers the animation
- ViewModifiers are the primary change agents in the UI
  - It is important to understand that: 
    - A change to a ViewModifier's arguments has to happen after the View is initially put in the UI
    - In other words: only changes in a ViewModifier's arguments since it joined the UI are animated.
    - Not all ViewModifier's arguments are animatable (e.g. .font is not), but most are. 
  - When a View arrives or departs, the entire thing is animated as a unit:
    - A View coming on-screen is only animated if it is joining a container that is already in the UI.
    - A View going off-screen is only animated if it is leaving a container that is staying in the UI.
    - ForEach and if-else in ViewBuilders are common ways to make VIews come and go

How do we make an animation "go"?
1. Implicitly (automatically), by using the view modifier .animation(Animation)
2. Explicitly, by wrapping withAnimation(Animation) {  } around code that might change things
3. Indipendently, By making Views be included or excluded from the UI

Again, all of the above only cause animations to "go" if the View is already part of the UI (or if the View is joining a container that is already part of the UI)

### Implicit Animation
- Automatic animation, essentially marks a View so that ...
- All ViewModifier arguments that precede the animation modifier will always be animated
- the changes are animated with the duration and "curve" you specify

To create a simple implicit animation add a .animation(Animation) view modifier to the View you want to auto-animate.

```Swift
Text("👻")
    .opacity(scary ? 1 : 0)
    .rotationEffect(Angle.degrees(upsideDown ? 180 : 0))
    .animation(Animation.easeInOut)
```

Now whenever scary or upsideDown changes, the opacity/rotation will be animated.
All changes to arguments to animatable view modifiers preceding .animation are animated.
If we put something after .animation() those will not be animated (since animation is a view modifier)
Without .animation(), the changes to opacity/rotation would appear instantly on screen.

Warning! The .animation modifier does not work well on a container.
A container just propagates the .animation modifier to all the Views it contains.
In other words, .animation does not work not like .padding, it works more like .font.
It is good for single view like Text, Image etc.

```Swift
//
//  ImplicitAnimation.swift
//  Memorize
//
//  Created by nick88msn on 08/06/21.
//

import SwiftUI

struct AnimationView: View {
    @State var isScary: Bool = true
    @State var isUpsideDown: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("👻")
                .font(.largeTitle)
                .opacity(isScary ? 1 : 0)
                .rotationEffect(Angle.degrees(isUpsideDown ? 180 : 0))
                .animation(.easeInOut)
            Button(action: {
                isScary.toggle()
                isUpsideDown.toggle()
            }, label: {
                Text(isScary ? "Press me" : "Bring me back")
            })
            .padding()
            .font(.title)
            .foregroundColor(isScary ? .primary : .secondary)
            Spacer()
        }
    }
}


struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        return AnimationView()
            .previewDevice("iPhone 12 Pro")
            .preferredColorScheme(.dark)
    }
}

```