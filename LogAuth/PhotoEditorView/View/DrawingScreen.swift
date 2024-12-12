//
//  DrawingScreen.swift
import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var model: DrawingViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                
                let size = proxy.frame(in: .global).size
                
                Task { @MainActor in
                    if model.rect == .zero {
                        model.rect = proxy.frame(in: .global)
                    }
                }
                
                return AnyView(
                    ZStack {
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker, rect: size)
                        
                        ForEach(model.textBoxes) { box in
                            Text(model.textBoxes[model.currentIndex].id == box.id && model.addNewBox ? "" : box.text)
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundStyle(box.textColor)
                                .offset(box.offSet)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let current = value.translation
                                            let lastOffset = box.lastOffSet
                                            let newTranslation = CGSize(
                                                width: lastOffset.width + current.width,
                                                height: lastOffset.height + current.height
                                            )
                                            model.textBoxes[getIndex(textBox: box)].offSet = newTranslation
                                        }
                                        .onEnded { value in
                                            model.textBoxes[getIndex(textBox: box)].lastOffSet = value.translation
                                        }
                                )
                                .onLongPressGesture {
                                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                                    model.canvas.resignFirstResponder()
                                    model.currentIndex = getIndex(textBox: box)
                                    withAnimation {
                                        model.addNewBox = true
                                    }
                                }
                        }
                    }
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    model.saveImage()
                } label: {
                    Text("Save")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "camera.filters")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    model.textBoxes.append(TextBox())
                    model.currentIndex = model.textBoxes.count - 1
                    withAnimation {
                        model.addNewBox.toggle()
                    }
                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                    model.canvas.resignFirstResponder()
                } label: {
                    Text("T")
                }
            }
        }
    }
    
    func getIndex(textBox: TextBox) -> Int {
        let index = model.textBoxes.firstIndex { box -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
}
