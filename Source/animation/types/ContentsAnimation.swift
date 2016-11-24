import RxSwift

internal class ContentsAnimation: AnimationImpl<[Node]> {
    
    init(animatedGroup: Group, valueFunc: @escaping (Double) -> [Node], animationDuration: Double, delay: Double = 0.0, autostart: Bool = false, fps: UInt = 30) {
 
        super.init(observableValue: animatedGroup.contentsVar, valueFunc: valueFunc, animationDuration: animationDuration, delay: delay, fps: fps)
        type = .contents
        node = animatedGroup
        
        if autostart {
            self.play()
        }
    }
}

public typealias ContentsAnimationDescription = AnimationDescription<[Node]>

public extension AnimatableVariable where T: GroupInterpolation {
    
    public func animation(_ f: @escaping (Double) -> [Node], during: Double, delay: Double = 0.0) -> Animation {
        let group = node! as! Group
        return ContentsAnimation(animatedGroup: group, valueFunc: f, animationDuration: during, delay: delay, autostart: false)
    }
    
    public func animate(_ f: @escaping (Double) -> [Node], during: Double, delay: Double = 0.0) {
        let group = node! as! Group
        let _ = ContentsAnimation(animatedGroup: group, valueFunc: f, animationDuration: during, delay: delay, autostart: true)
    }
    
    public func animation(_ desc: ContentsAnimationDescription) -> Animation {
        let group = node! as! Group
        return ContentsAnimation(animatedGroup: group, valueFunc: desc.valueFunc, animationDuration: desc.duration, delay: desc.delay, autostart: false)
    }
    
    public func animate(_ desc: ContentsAnimationDescription) {
        let group = node! as! Group
        let _ = ContentsAnimation(animatedGroup: group, valueFunc: desc.valueFunc, animationDuration: desc.duration, delay: desc.delay, autostart: true)
    }
    
}
