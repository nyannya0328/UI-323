//
//  Home.swift
//  UI-323 (iOS)
//
//  Created by nyannyan0328 on 2021/10/08.
//

import SwiftUI

struct Home: View {
    @State var text : String = ""
    @State var tags : [Tag] = []
    @State var showAlert = false
    var body: some View {
        VStack{
            
            Text("Filiter\nMenus")
                .font(.largeTitle.bold())
                .foregroundColor(Color("Tag"))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 280)
                .padding(.top,20)
            
            
            TextField("Apple", text: $text)
                .font(.title3)
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(
                
                
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("Tag"),lineWidth: 1)
                    
                
                )
                .environment(\.colorScheme, .dark)
                .padding(.vertical,18)
            
            
            Button {
                addTag(tags: tags, text: text, fontsize: 16, maxLimit: 150) { alert, tag in
                    
                    
                    if alert{
                        
                        showAlert.toggle()
                    }
                    else{
                        
                        tags.append(tag)
                        text = ""
                        
                        
                    }
                }
                
                
            } label: {
                Text("Add Tag")
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
                    .background(Color("Tag"))
                    .cornerRadius(10)
            }
            .disabled(text == "")
            .opacity(text == "" ? 0.3 : 1)

            
            
            
            
            
            
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BG").ignoresSafeArea())
        .alert(isPresented: $showAlert) {
            
            
            Alert(title: Text("Error"), message: Text("Tag Limit Exceeded try to delete some tags"), dismissButton: .destructive(Text("OK")))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
