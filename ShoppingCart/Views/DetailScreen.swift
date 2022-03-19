//
//  DetailScreen.swift
//  Furniture_app
//
//  Created by Abu Anwar MD Abdullah on 15/2/21.
//

import SwiftUI

struct DetailScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isAdded : Bool = false
    var product: Product
    
    var body: some View {
        
        ZStack {
            
            ScrollView  {
                // Product Image
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.top)
                        .frame(width: UIScreen.main.bounds.size.width, height: 300)
                        .clipped()
                
                DescriptionView()
            }
            .edgesIgnoringSafeArea(.top)
            
            HStack(alignment: .center) {
                
                Button(action: {}) {
                    Image(systemName: "minus")
                        .foregroundColor(darkGrayBasic)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        .padding(.leading, 13)
                        .padding(.trailing, 13)
                        .background(backgroundColor1)
                        .cornerRadius(10.0)
                }
                
                VStack(alignment: .center) {
                    Text("$1399")
                        .font(.title2)
                        .foregroundColor(.green)
                        .bold()
                    Text("1 kg")
                        .brightness(0.4)
                        .font(.subheadline)
                }
                .padding(.all, 5)
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(darkGrayBasic)
                        .padding(.all, 13)
                        .background(backgroundColor1)
                        .cornerRadius(10.0)
                }
                
                Spacer()
                
                Button(action: {
                    
                    isAdded.toggle()
                    
                }) {
                    
                    Image(systemName: isAdded == true ? "checkmark" : "cart")
                        .padding(.leading, 12)
                    Text( isAdded == true ?  "" : "Add to Cart")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 3)
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.trailing, 5)
//                        .padding(.horizontal, 8)
                        .foregroundColor(backgroundColor3)
                        .cornerRadius(10.0)
                    
                }
                .foregroundColor(backgroundColor3)
                .background(Color.green)
                .cornerRadius(10.0)
                
            }
            .padding(.bottom, 5)
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .background(backgroundColor1)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


//struct RoundedCorner: Shape {
//
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
//
//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//    }
//}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(product: productList[0])
    }
}


struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack (alignment: .leading) {
            // Title
            Text("Long item Name")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 30)
                .frame(width: 200, alignment: .leading)
            
            Text("1 kg / $198.00 ")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(blackBasic)
                .padding(.bottom)
                .brightness(0.3)
            
            Text("$198.00")
                .strikethrough(true)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(darkGrayBasic)
            
            Text("$98.99")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.green)
                .padding(.bottom)
            
            Divider()
            
            VStack {
                HStack(alignment: .center) {
                    Text("Words in russian")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blackBasic)

                    Text("something")
                        .font(.body)
                        .fontWeight(.medium)
                        .brightness(0.3)
                }
                .padding(.bottom, 5)
                
                HStack(alignment: .center) {
                    Text("Russian stuff")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blackBasic)

                    Text("other")
                        .font(.body)
                        .fontWeight(.medium)
                        .brightness(0.3)
                }
                .padding(.bottom, 5)
                
                HStack(alignment: .center) {
                    Text("More")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blackBasic)

                    Text("other thing")
                        .font(.body)
                        .fontWeight(.medium)
                        .brightness(0.3)
                }
                .padding(.bottom, 5)
                
                HStack(alignment: .center) {
                    Text("Russian is cool")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(blackBasic)

                    Text("ofcourse")
                        .font(.body)
                        .fontWeight(.medium)
                        .brightness(0.3)
                }
            }
            
//            Text("Description")
//                .fontWeight(.medium)
//                .padding(.vertical, 8)
//            Text("Luxury Swedian Chair is a contemporary chair based on the virtues of modern craft. it carries on the simplicity and honestly of the archetypical chair.")
//                .lineSpacing(8.0)
//                .opacity(0.6)
//
//            //                Info
//            HStack (alignment: .top) {
//                VStack (alignment: .leading) {
//                    Text("Size")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                    Text("Height: 120 cm")
//                        .opacity(0.6)
//                    Text("Wide: 80 cm")
//                        .opacity(0.6)
//                    Text("Diameter: 72 cm")
//                        .opacity(0.6)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//                Spacer()
//
//                VStack (alignment: .leading) {
//                    Text("Treatment")
//                        .font(.system(size: 16))
//                        .fontWeight(.semibold)
//                    Text("Jati Wood, Canvas, \nAmazing Love")
//                        .opacity(0.6)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            .padding(.vertical)
            
            //                Colors and Counter
            HStack(alignment: .bottom) {
//                VStack (alignment: .leading) {
//                    Text("Colors")
//                        .fontWeight(.semibold)
//                    HStack {
//                        ColorDotView(color: Color.white)
//                        ColorDotView(color: Color.black)
//                        ColorDotView(color: Color(#colorLiteral(red: 0.1803921569, green: 0.6352941176, blue: 0.6705882353, alpha: 1)))
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
                
//                HStack {
//                    //                        Minus Button
//                    Button(action: {}) {
//                        Image(systemName: "minus")
//                            .padding(.all, 8)
//
//                    }
//                    .frame(width: 30, height: 30)
//                    .overlay(RoundedCorner(radius: 50).stroke())
//                    .foregroundColor(.black)
//
//                    Text("1")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 8)
//
//                    //                        Plus Button
//                    Button(action: {}) {
//                        Image(systemName: "plus")
//                            .foregroundColor(.white)
//                            .padding(.all, 8)
//                            .background(Color("Primary"))
//                            .clipShape(Circle())
//                    }
//                }
//                .padding(.bottom, 50)
            }
            Spacer(minLength: 40)
        }
        .padding()
        .padding(.top)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
    }
}


struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}
