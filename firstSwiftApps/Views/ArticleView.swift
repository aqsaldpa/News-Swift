//
//  ArticleView.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        HStack{
            if let imgUrl = article.urlToImage,
               let url = URL(string: imgUrl){
                
                URLImage(url,
                         failure: {
                    error, _ in
                    PlaceHolderImageView()
                },
                  content: {
                    image in image
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                })
                .frame(width: 100,height: 100)
                .cornerRadius(10)
            }else{
                PlaceHolderImageView()
            }
            VStack(
                alignment: .leading, spacing: 4, content: {
                    Text(article.title ?? "Empty")
                        .foregroundColor(.black)
                        .font(.system(size: 18,weight: .semibold))
                    Text(article.source.name ?? "Empty")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    
                }
            ).padding(.vertical , 10)
            Spacer()
        }
     
    }
}

struct PlaceHolderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100,height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider{
    static var previews: some View{
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
