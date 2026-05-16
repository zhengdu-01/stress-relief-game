import SwiftUI
import Combine

enum BossMood: Int, CaseIterable {
    case arrogant = 0
    case angry
    case委屈
    case beg
    
    var description: String {
        switch self {
        case .arrogant: return "傲慢"
        case .angry: return "愤怒"
        case .委屈: return "委屈"
        case .beg: return "求饶"
        }
    }
}

enum WeaponType: CaseIterable {
    case rottenVegetable
    case stinkyEgg
    case kitchenKnife
    case tiffany
    
    var name: String {
        switch self {
        case .rottenVegetable: return "烂菜叶"
        case .stinkyEgg: return "臭鸡蛋"
        case .kitchenKnife: return "菜刀"
        case .tiffany: return "Tiffany饰品"
        }
    }
    
    var damage: Int {
        switch self {
        case .rottenVegetable: return Int.random(in: 10...15)
        case .stinkyEgg: return Int.random(in: 10...15)
        case .kitchenKnife: return 30
        case .tiffany: return 50
        }
    }
    
    var color: Color {
        switch self {
        case .rottenVegetable: return .green
        case .stinkyEgg: return .yellow
        case .kitchenKnife: return .gray
        case .tiffany: return Color(red: 0.29, green: 0.73, blue: 0.71)
        }
    }
    
    var rarity: String {
        switch self {
        case .rottenVegetable, .stinkyEgg: return "基础"
        case .kitchenKnife: return "特殊"
        case .tiffany: return "传奇"
        }
    }
}

class GameViewModel: ObservableObject {
    @Published var bossName = "张总"
    @Published var isMaleBoss = true
    @Published var bossHP = 100
    @Published var maxHP = 100
    @Published var rage = 0
    @Published var maxRage = 100
    @Published var timeRemaining = 60
    @Published var gameStarted = false
    @Published var gameEnded = false
    @Published var victory = false
    @Published var bossMood: BossMood = .arrogant
    @Published var currentWeapon: WeaponType?
    @Published var showWeaponCard = false
    @Published var isStunned = false
    @Published var showHitEffect = false
    @Published var hitPosition = CGPoint.zero
    
    private var timer: AnyCancellable?
    private var moodTimer: AnyCancellable?
    
    init() {}
    
    func startGame() {
        gameStarted = true
        gameEnded = false
        victory = false
        bossHP = maxHP
        rage = 0
        timeRemaining = 60
        bossMood = .arrogant
        currentWeapon = nil
        showWeaponCard = false
        isStunned = false
        
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 && !self.gameEnded {
                    self.timeRemaining -= 1
                } else if self.timeRemaining <= 0 {
                    self.endGame(victory: false)
                }
            }
    }
    
    func normalAttack(at position: CGPoint) {
        guard gameStarted && !gameEnded && !isStunned else { return }
        
        let damage = 5
        bossHP = max(0, bossHP - damage)
        rage = min(maxRage, rage + 10)
        
        showHitEffect = true
        hitPosition = position
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.showHitEffect = false
        }
        
        updateMood()
        
        if bossHP <= 0 {
            endGame(victory: true)
        }
        
        if rage >= maxRage && !showWeaponCard {
            spawnWeaponCard()
        }
    }
    
    func useWeapon(_ weapon: WeaponType, at position: CGPoint) {
        guard gameStarted && !gameEnded else { return }
        
        let damage = weapon.damage
        bossHP = max(0, bossHP - damage)
        rage = 0
        showWeaponCard = false
        currentWeapon = nil
        
        showHitEffect = true
        hitPosition = position
        
        if weapon == .tiffany {
            isStunned = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isStunned = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showHitEffect = false
        }
        
        updateMood()
        
        if bossHP <= 0 {
            endGame(victory: true)
        }
    }
    
    private func spawnWeaponCard() {
        let weapons = WeaponType.allCases
        currentWeapon = weapons.randomElement()
        showWeaponCard = true
    }
    
    private func updateMood() {
        let hpPercentage = Double(bossHP) / Double(maxHP)
        
        if hpPercentage > 0.75 {
            bossMood = .arrogant
        } else if hpPercentage > 0.5 {
            bossMood = .angry
        } else if hpPercentage > 0.25 {
            bossMood = .委屈
        } else {
            bossMood = .beg
        }
    }
    
    private func endGame(victory: Bool) {
        gameEnded = true
        self.victory = victory
        timer?.cancel()
    }
    
    func resetGame() {
        timer?.cancel()
        startGame()
    }
}
