//
//  HomeView.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsVMImpl(service: NewsServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let articles):
                NavigationView {
                    List {
                        ForEach(articles) { item in
                            ArticleView(article: item)
                                .listRowSeparator(.hidden)
                            Divider()
                                .frame(height: 1.5)
                                .background(Color.black).opacity(0.2)
                                .padding(.vertical, 10)
                        }
                    }
                    .navigationTitle(Text("News"))
                }
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getArticles()
                }
            }
        }.onAppear(perform: viewModel.getArticles) // initstate
    }
}

#Preview {
    HomeView()
}
