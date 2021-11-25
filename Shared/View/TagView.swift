//
//  TagView.swift
//  UI-323 (iOS)
//
//  Created by nyannyan0328 on 2021/10/08.
//

import SwiftUI

struct TagView: View {
    var maxLimit : Int
    @Binding var tags : [Tag]
    var title = "Add Some Tags"
    
    var fontsize : CGFloat = 15
    
    @Namespace var animation
    var body: some View {
        VStack(alignment:.leading,spacing:15){
            
            
            Text(title)
                .font(.body.weight(.light))
                .foregroundColor(Color("Tag"))
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    ForEach(getRows(),id:\.self){rows in
                        
                        HStack(spacing:6){
                            
                            
                            ForEach(rows){row in
                                
                                
                                RowView(tag: row)
                            }
                            
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80,alignment: .leading)
                .padding(.vertical)
                
                
                
            }
            .frame(maxWidth: .infinity)
            .background(
            
            RoundedRectangle(cornerRadius: 13)
                .strokeBorder(Color("Tag"),lineWidth: 1)
            
            
            
            )
            .animation(.easeInOut, value: tags)
            .overlay(
            
            Text("\(getSize(tags:tags)) / \(maxLimit)")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color("Tag"))
                .padding(12)
                .padding(.trailing,10)
            ,alignment: .bottomTrailing
            
            
            )
            
            
            
            
        }
    }
    
    @ViewBuilder
    func RowView(tag : Tag)->some View{
        
        Text(tag.text)
            .font(.system(size: fontsize))
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(
            
            Capsule()
                .fill(Color("Tag"))
            )
            .contentShape(Rectangle())
            .foregroundColor(Color("BG"))
            .lineLimit(1)
            .contextMenu{
                
                
                Button("DELETE"){
                    
                    tags.remove(at: getIndex(tag: tag))
                }
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
         
        
        
        
        
    }
    func getIndex(tag : Tag)->Int{
        
        let index = tags.firstIndex { currentIndex in
            return tag.id == currentIndex.id
        } ?? 0
        
        return index
    }
    
    func getRows()->[[Tag]]{
        
        var rows : [[Tag]] = []
        var currentRow : [Tag] = []
        
        var totalWidth : CGFloat = 0
        
        let screenWidth : CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach { tag in
            
            
            totalWidth += (tag.size + 40)
            
            
            if totalWidth > screenWidth{
                
                totalWidth = (!currentRow.isEmpty || rows.isEmpty  ? (tag.size + 40) : 0)
                
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
                
                
            }
            else{
                
                currentRow.append(tag)
            }
            
        }
        
        if !currentRow.isEmpty{
            
            
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        
        return rows
        
    }
    
    
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func addTag(tags : [Tag],text : String,fontsize : CGFloat,maxLimit : Int,competition : @escaping(Bool,Tag) -> ()){
    
  
    
    
    let font = UIFont.systemFont(ofSize: fontsize)
    
    let attributes = [NSAttributedString.Key.font:font]
    
    
    let size = (text as NSString).size(withAttributes: attributes)
    
    let tag = Tag(text: text, size: size.width)
    
    
    if (getSize(tags: tags) + text.count) < maxLimit{
        
        competition(false,tag)
        
    }
    else{
        
        
        competition(true,tag)
    }
    
    
    
 
    
    
    
    
}

func getSize(tags : [Tag])->Int{
    var count : Int = 0
    
    tags.forEach { tag in
        
        count += tag.text.count
        
        
        
        
    }
    
    return count
    
    
}
