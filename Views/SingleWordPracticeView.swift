import SwiftUI

struct SingleWordPracticeView: View {
    let words: [Word]
    @State private var currentIndex = 0
    @State private var userAnswers: [String] = []
    @State private var currentInput = ""
    @State private var showingCheck = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // 进度指示器
            ProgressView(value: Double(currentIndex), total: Double(words.count))
                .padding(.horizontal)
            
            Text("\(currentIndex + 1) / \(words.count)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // 当前单词的中文释义
            VStack(alignment: .leading) {
                Text(words[currentIndex].chinese ?? "")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // 输入框
            TextField("请输入单词", text: $currentInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // 提交按钮
            Button(action: nextWord) {
                Text(currentIndex < words.count - 1 ? "下一个" : "完成")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("返回") {
                    dismiss()
                }
            }
        }
        .onAppear {
            userAnswers = Array(repeating: "", count: words.count)
        }
        .navigationDestination(isPresented: $showingCheck) {
            PracticeCheckView(words: words, userAnswers: userAnswers, isBatchMode: false)
        }
    }
    
    private func nextWord() {
        userAnswers[currentIndex] = currentInput
        
        if currentIndex < words.count - 1 {
            currentIndex += 1
            currentInput = ""
        } else {
            showingCheck = true
        }
    }
}