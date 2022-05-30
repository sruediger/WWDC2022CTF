//
//  HashPresenterView+Builders.swift
//  
//
//  Created by Sérgio Ruediger on 19/04/22.
//

import SwiftUI

/// HashPresenterView+ViewBuilders
extension HashPresenterView {
    
    /// Creates the Main Window
    /// - Returns Main Window View
    @ViewBuilder internal func createMainWindowView() -> some View {
        MacOSWindowView(dimensions: CGSize(width: 640, height: 576), windowClosed: $viewModel.firstWindowPresented) {
            TabView(selection: $viewModel.currentIndex) {
                ForEach(0...viewModel.pagesAmount, id: \.self) { index in
                      self.createIntroWindowViews(fromIndex: index)
                          .tag(index)
                  }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        } onDismiss: {
            if viewModel.introductionFinished {
                self.viewModel.firstWindowPresented = false
                self.viewModel.terminalText.showEndingText = true
                self.completionHandler()
            }
        }.disabled(viewModel.secondWindowPresented && !viewModel.mainWindowTapped ? true : false)
    }
    
    /// Creates the Hash Calculator Window
    /// - Returns Hash Calculator View
    @ViewBuilder internal func createHashCalculatorView() -> some View {
        MacOSWindowView(dimensions: CGSize(width: 480, height: UIScreen.main.bounds.height * 0.56)) {
            HashCalculatorView()
        } onDismiss: {
            self.viewModel.secondWindowPresented = false
        }.offset(x: 16, y: 64)
        .transition(.scale.animation(.linear(duration: 0.25)))
    }
    
}

/// HashPresenterView+SubviewBuilders
extension HashPresenterView {
    
    /// Creates all Introduction Window subviews based on their index
    /// - Parameter index: Index of the window that will have it's content displayed
    /// - Returns IntroWindow View
    @ViewBuilder private func createIntroWindowViews(fromIndex index: Int) -> some View {
        switch index {
            case 0, 1, 2, 3, 4, 5, 6:
                VStack(alignment: .center, spacing: 15) {
                    Spacer()
                    self.createContentHeaderSubview(with: index)
                    self.createContentBodySubview(with: index)
                    self.createNavButtonsSubview(with: index)
                }.frame(width: 576)
            default: EmptyView()
        }
    }
    
    /// Creates an Introduction Window Header Subview based on it's index
    /// - Parameter index: Index of the window to display the header
    /// - Returns chosen IntroWindow ContentHeaderSubview
    @ViewBuilder private func createContentHeaderSubview(with index: Int) -> some View {
        if index == 1 {
            TypingTextAnimationView(mode: .userInterface, content: "", contents: Binding.constant(viewModel.animatedPasswordContent))
        }else {
            let data = viewModel.getTitleAndIcon(ofIndex: index)
            if let imagePath = data.imagePath, let subviewTitle = data.title {
                if index != 4 && index != 6 {
                    self.createEmojiView(from: imagePath)
                }else {
                    self.createImageView(path: imagePath, system: true)
                }
                if !subviewTitle.isEmpty {
                    RoundedText(content: subviewTitle, size: 32, weight: .bold)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    /// Creates an Introduction Window Body Subview based on it's index
    /// - Parameter index: Index of the window to display the body
    /// - Returns chosen IntroWindow ContentBodySubview
    @ViewBuilder private func createContentBodySubview(with index: Int) -> some View {
        let fontWeight: Font.Weight = index == 0 ? .bold : .medium
        let pageContent = viewModel.getFirstWindowContent(fromIndex: index)
        
        if index == viewModel.pagesAmount { self.createHashCalculatorButtonView() }
        
        Group {
            RoundedText(content: pageContent.body, size: viewModel.getFontSize(ofIndex: index), weight: fontWeight)
            
            if let footnote = pageContent.info {
                RoundedText(content: footnote, size: viewModel.getFontSize(ofIndex: index, footnote: true), weight: .semibold)
            }
        }.foregroundColor(.white)
        
        if index != 6 { Spacer() }
    }
    
    /// Creates both Navigation Buttons Subview for an specific IntroWindow page
    /// - Parameter index: Index of the window to display buttons
    /// - Returns chosen IntroWindow NavButtonsSubview
    @ViewBuilder private func createNavButtonsSubview(with index: Int) -> some View {
        HStack {
            if index == viewModel.currentIndex {
                Group {
                    if index > 0 {
                        self.createNavigationButton(nextPage: false)
                            .padding(.leading, 20)
                    }
                    Spacer()
                    if index < viewModel.pagesAmount {
                        self.createNavigationButton(nextPage: true)
                            .padding(.trailing, 20)
                    }
                }.transition(.opacity.animation(.easeIn(duration: 1)))
            }else { Spacer() }
        }.padding(.bottom, 50)
    }
}
    
/// HashPresenterView+ComponentBuilders
extension HashPresenterView {
    
    /// Creates a single Navigation Button
    /// - Parameter nextPage: Boolean that indicates if the IntroWindow isn't on the last index (a.k.a page)
    /// - Returns NavigationButtonView
    @ViewBuilder private func createNavigationButton(nextPage: Bool) -> some View {
        Button {
            viewModel.currentIndex = nextPage ? viewModel.currentIndex + 1 : viewModel.currentIndex - 1
        } label: {
            let imagePath = nextPage ? "arrow.forward.circle.fill" : "arrow.backward.circle.fill"
            Image(systemName: imagePath)
                .resizable()
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
        }
    }
    
    /// Creates a custom Emoji View
    /// - Parameter source: Data source of the emoji
    /// - Returns EmojiView
    @ViewBuilder private func createEmojiView(from source: String) -> some View {
        Group {
            if source == "size" || source == "saltnpepper" || source == "storage" {
                ZStack {
                    Group {
                        let frontEmoji = viewModel.getEmoji(from: source, isFirst: true)
                        let backEmoji = viewModel.getEmoji(from: source, isFirst: false)
                        
                        Text(backEmoji)
                            .scaleEffect(source == "size" || source == "storage" ? 3 : 2.75)
                            .offset(x: source == "saltnpepper" ? -13 : .zero, y: .zero)
                        
                        Text(frontEmoji)
                            .scaleEffect(source == "storage" ? 1.75 : 2.25)
                            .offset(x: source == "storage" ? 30 : (source != "saltnpepper" ? -30 : 15), y: 20)
                            .shadow(radius: source == "storage" ? 50 : 0)
                    }
                }
            }else { // Passwords intro page (index = 0)
                Text(source).scaleEffect(3)
            }
        }.font(.title3).offset(x: 0, y: -20)
    }
    
    /// Creates the Hash Calculator Button View
    /// - Returns HashCalculatorButtonView
    @ViewBuilder private func createHashCalculatorButtonView() -> some View {
        Button {
            self.viewModel.secondWindowPresented.toggle()
        } label: {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 256, height: 55)
                .cornerRadius(12)
                .overlay(
                    HStack(spacing: 10) {
                        RoundedText(content: "Open Hash Calculator", size: 18, weight: .semibold)
                    }.foregroundColor(.white)
                )
        }
    }
    
    /// Creates a simple ImageView
    /// - Parameter path: String containing the imagePath
    /// - Parameter system: Boolean that indicates if the image is standard of the operating system
    /// - Returns ImageView
    @ViewBuilder private func createImageView(path: String, system: Bool = false) -> some View {
        let imageView = system ? Image(systemName: path) : Image(path)
        imageView
            .resizable()
            .foregroundColor(.white)
            .frame(width: 80, height: path.contains("drive") ? 64 : 80)
    }
}
