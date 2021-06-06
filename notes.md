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
