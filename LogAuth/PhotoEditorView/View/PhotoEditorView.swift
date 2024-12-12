import SwiftUI
import PencilKit

struct PhotoEditorView: View {
    @StateObject var model = DrawingViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if let _ = UIImage(data: model.imageData) {
                        
                        DrawingScreen()
                            .environmentObject(model)
                            .frame(width: UIScreen.main.bounds.width)
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button {
                                        model.cancelImageEditing()
                                    } label: {
                                        Image(systemName: "xmark")
                                    }
                                }
                            }
                    } else {
                        Button {
                            model.showImagePicker.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundStyle(.black)
                                .frame(width: 70, height: 70)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(
                                    color: .black.opacity(0.07),
                                    radius: 5,
                                    x: 5,
                                    y: 5
                                )
                                .shadow(
                                    color: .black.opacity(0.07),
                                    radius: 5,
                                    x: -5,
                                    y: -5
                                )
                        }
                    }
                }
                .navigationTitle("Image Editor")
            }
            if model.addNewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                TextField("Type Here", text: $model.textBoxes[model.currentIndex].text)
                    .font(
                        .system(
                            size: 35,
                            weight: model.textBoxes[model.currentIndex].isBold ? .bold : .regular
                        )
                    )
                    .colorScheme(.dark)
                    .foregroundStyle(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                HStack {
                    Button {
                        model.textBoxes[model.currentIndex].isAdded = true
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        
                        withAnimation {
                            model.addNewBox = false
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button {
                        model.cancelTextView()
                    } label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .overlay(
                    HStack(spacing: 15) {
                        ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        Button {
                            model.textBoxes[model.currentIndex].isBold.toggle()
                        } label: {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .sheet(isPresented: $model.showImagePicker) {
            ImagePickers(showPicker: $model.showImagePicker, imageData: $model.imageData)
        }
        .alert(isPresented: $model.showAlert) {
            Alert(
                title: Text("Message"),
                message: Text(model.message),
                dismissButton: .destructive(Text("OK"))
            )
        }
    }
}
