//
//  Home.swift
//  SwiftUITask
//
//  Created by Decagon on 04/11/2021.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "house"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Location for each curve
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                
                Color("Color1")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("house")
                Color("Color2")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("bookmark")
                Color.green
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("bell")
                Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("message")
            }
            // Custom tab bar
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedTab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 26)
                                .foregroundColor(selectedTab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedTab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -50 : 0)
                        })
                        .onAppear(perform: {
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    .frame(width: 25, height: 30)
                    if image != tabs.last { Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func getColor(image: String) -> Color {
        switch image {
        case "house":
            return Color("Color1")
        case "bookmark":
            return Color("Color2")
        case "bell ":
            return Color.purple
        default:
            return Color.blue
        }
    }
}

var tabs = ["house", "bookmark", "bell", "message"]


//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
