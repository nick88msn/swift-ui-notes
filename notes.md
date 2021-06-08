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
    }asd
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
        return some View // that almost certainly contains the View content
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
1. Apply the modifier directly to the view (e.g. Text("Some Text").BorderedLabel())
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