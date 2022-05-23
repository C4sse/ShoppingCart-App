//
//  AddItemToShop.swift
//  ShoppingCart
//
//  Created by George Nhari on 22/5/2022.
//

import SwiftUI
import ProgressHUD

struct AddItemToShop: View {
    
    @State var name: String = ""
    @State var price: String = ""
    @State var availableQuantity: String = ""
    @State var description: String = ""
    @State private var selectedIndex: Int = 0
    @State private var selectedCategory: Int = 0
    @State var category: RealmCategory = RealmCategory()
    @State var selectedType: String = ""
    @StateObject var categoriesManager = CategoriesManager()
    @State var isOn: Bool = false
    // for image
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        List {
            Section {
                
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                
                Image(uiImage: self.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fill)
                    .padding(.leading)
                
                Text("Add Image")
                    .padding(.leading, 16)
                    .padding(.trailing)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showSheet = true
                    }
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            
            HStack {
                
                Text("Name")
                    .padding(.leading, 16)
                Spacer(minLength: 30)
                TextField("Enter name", text: $name)
            }
            
            
            HStack {
                
                Text("Price")
                    .padding(.leading, 16)
                Spacer(minLength: 30)
                TextField("Enter price", text: $price)
                    .keyboardType(.numberPad)
            }
            
            HStack {
                
                Text("Available quantity")
                    .padding(.leading, 16)
                Spacer(minLength: 30)
                TextField("Enter quantity", text: $availableQuantity)
                    .keyboardType(.numberPad)
            }
            
            HStack(alignment: .top) {
                
                Text("Description")
                    .padding(.leading, 16)
                Spacer(minLength: 30)
                TextField("Describe the item", text: $description)
                    .frame(height: 50, alignment: .top)
            }
            .padding(.top)
            
            HStack {
                
                Toggle(isOn: $isOn) {
                    Text("On Discount")
                        .foregroundColor(.primary)
                }
            }
            HStack(spacing: 12) {
                
                ForEach (0 ..< categoriesManager.categories.count, id:\.self) { i in
                
                    Button(action: {
                        
                        selectedCategory = i
                        category = categoriesManager.categories[i]
                    }) {
                        
                        CategoryView(isActive: selectedCategory == i, text: categoriesManager.categories[i].name)
                    }
                }
            }
            .padding()
            
            HStack(spacing: 12) {
                
                ForEach (0 ..< category.filters.count, id:\.self) { i in
                    
                    if i != 0 {
                        
                        Button(action: {
                            
                            selectedIndex = i
                            selectedType = category.filters[i]
                        }) {
                            
                            CategoryView(isActive: selectedIndex == i, text: category.filters[i])
                        }
                    }
                }
            }
            .padding()
            
        }
            Section {
                
                Button {
                    if name != "" && price != "" && availableQuantity != "" && description != "" {
                        
                        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                            ProgressHUD.showError("Image error")
                            return
                        }
                        
                        ItemsApi.uploadImageToFirebaseStorage(data: imageData) { imageUrl in
                            
                            let dict: [String: Any] = [
                                "name": name,
                                "image": imageUrl,
                                "price": Int(price)!,
                                "availableQuantity": Int(availableQuantity)!,
                                "type": selectedType,
                                "description": description,
                                "isDiscounted": isOn
                            ]
                            
                            ItemsApi.addProductToStore(dict: dict, forCategoryId: category.id, isDiscounted: isOn)
                        }
                    } else {
                        ProgressHUD.showError("Fill in all items")
                    }
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        Text("Add to shop")
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .listRowBackground(blueAccent)
            }
        }
        }
        .onAppear {
            categoriesManager.getCategories(categoriesManager: categoriesManager)
        }
    }
}

struct AddItemToShop_Previews: PreviewProvider {
    static var previews: some View {
        AddItemToShop()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
