import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.gameStarted && !viewModel.gameEnded {
                SetupView(viewModel: viewModel)
            } else if viewModel.gameEnded {
                ResultView(viewModel: viewModel)
            } else {
                GamePlayView(viewModel: viewModel)
            }
        }
    }
}

struct SetupView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var nameInput = ""
    
    var body: some View {
        ZStack {
            OfficeBackground()
            
            VStack(spacing: 30) {
                Text("解压小游戏")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                
                VStack(spacing: 20) {
                    Picker("选择领导", selection: $viewModel.isMaleBoss) {
                        Text("男领导").tag(true)
                        Text("女领导").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 40)
                    
                    BossCharacter(
                        isMale: viewModel.isMaleBoss,
                        mood: .arrogant,
                        isStunned: false
                    )
                    .padding(.top, 20)
                    
                    TextField("输入领导名字", text: $viewModel.bossName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                        .font(.title)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(16)
                .shadow(radius: 10)
                .padding(.horizontal, 30)
                
                Button(action: {
                    viewModel.startGame()
                }) {
                    Text("开始游戏")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 15)
                        .background(Color(red: 0.8, green: 0.2, blue: 0.2))
                        .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

struct GamePlayView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var bossScale: CGFloat = 1.0
    @State private var shakeOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                OfficeBackground()
                
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("时间: \(viewModel.timeRemaining)s")
                                .font(.headline)
                                .foregroundColor(viewModel.timeRemaining <= 10 ? .red : .primary)
                            
                            Text(viewModel.bossName)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Text("血量")
                                .font(.caption)
                            ProgressView(value: Double(viewModel.bossHP) / Double(viewModel.maxHP))
                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                .frame(width: 150)
                            Text("\(viewModel.bossHP)/\(viewModel.maxHP)")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .padding()
                    
                    Spacer()
                    
                    ZStack {
                        BossCharacter(
                            isMale: viewModel.isMaleBoss,
                            mood: viewModel.bossMood,
                            isStunned: viewModel.isStunned
                        )
                        .scaleEffect(bossScale)
                        .offset(shakeOffset)
                        .onTapGesture { location in
                            let screenLocation = CGPoint(
                                x: location.x + geometry.size.width / 2 - 60,
                                y: location.y + 200
                            )
                            viewModel.normalAttack(at: screenLocation)
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                bossScale = 0.95
                                shakeOffset = CGSize(width: CGFloat.random(in: -5...5), height: CGFloat.random(in: -5...5))
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring()) {
                                    bossScale = 1.0
                                    shakeOffset = .zero
                                }
                            }
                        }
                        
                        if viewModel.showHitEffect {
                            HitEffectView()
                                .position(viewModel.hitPosition)
                        }
                    }
                    .frame(height: 200)
                    .padding(.bottom, 50)
                    
                    VStack(spacing: 10) {
                        Text("怒气值")
                            .font(.caption)
                        ProgressView(value: Double(viewModel.rage) / Double(viewModel.maxRage))
                            .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                            .padding(.horizontal, 50)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                }
                
                if viewModel.showWeaponCard, let weapon = viewModel.currentWeapon {
                    VStack {
                        WeaponCard(weapon: weapon) { dropPoint in
                            viewModel.useWeapon(weapon, at: dropPoint)
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct HitEffectView: View {
    @State private var opacity = 1.0
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            Text("💥")
                .font(.system(size: 50))
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                scale = 1.5
                opacity = 0.0
            }
        }
    }
}

struct ResultView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            OfficeBackground()
            
            VStack(spacing: 30) {
                Text(viewModel.victory ? "🎉 胜利！" : "⏰ 时间到！")
                    .font(.system(size: 40, weight: .bold))
                
                if viewModel.victory {
                    Text("成功让\(viewModel.bossName)服输了！")
                        .font(.title2)
                } else {
                    Text("\(viewModel.bossName)还很嚣张...")
                        .font(.title2)
                    Text("剩余血量: \(viewModel.bossHP)")
                        .font(.title3)
                }
                
                BossCharacter(
                    isMale: viewModel.isMaleBoss,
                    mood: viewModel.victory ? .beg : .arrogant,
                    isStunned: false
                )
                .padding(.top, 20)
                
                Button(action: {
                    viewModel.resetGame()
                }) {
                    Text("再来一局")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 15)
                        .background(Color(red: 0.2, green: 0.6, blue: 0.3))
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Color.white.opacity(0.95))
            .cornerRadius(20)
            .shadow(radius: 15)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    ContentView()
}
