//
//  ZTVCBuilder.swift
//  ZTUIKitDemo
//
//  Created by zt on 2024/11/23.
//

import UIKit

#if compiler(>=5.4)
@resultBuilder
#else
@_functionBuilder
#endif
@MainActor
public struct ZTVCBuilder {
    
    public static func buildBlock(_ vc: UIViewController) -> UIViewController {
        vc
    }
    
    public static func buildBlock(_ vcs: UIViewController...) -> [UIViewController] {
        vcs
    }
    
    public static func buildBlock(_ vcs: [UIViewController]...) -> [UIViewController] {
        vcs.flatMap { $0 }
    }
    
    // handle buildBlock params like:(vc, [vc], vc, [vc1, vc2])
    public static func buildBlock(_ vcs: Any...) -> [UIViewController] {
        var arr = [UIViewController]()
        for v in vcs {
            if let vc = v as? UIViewController {
                arr.append(vc)
                continue
            }
            if let vs = v as? Array<UIViewController> {
                arr.append(contentsOf: vs.flatMap {$0} )
                continue
            }
#if DEBUG
            assert(false)
#endif
        }
        return arr
    }
    
#if compiler(>=5.4)
    // Support for conditional blocks (if statements without else)
    public static func buildOptional(_ vcs: [UIViewController]?) -> [UIViewController] {
        return vcs ?? []
    }
    
#else
    // Support for conditional blocks (if statements without else)
    public static func buildIf(_ vcs: [UIViewController]?) -> [UIViewController] {
        return vcs ?? []
    }
#endif

    // Support for conditional blocks (if-else statements)
    public static func buildEither(first vc: UIViewController) -> UIViewController {
        vc
    }
    
    public static func buildEither(first vcs: [UIViewController]) -> [UIViewController] {
        vcs
    }

    public static func buildEither(second vc: UIViewController) -> UIViewController {
        vc
    }
    
    public static func buildEither(second vcs: [UIViewController]) -> [UIViewController] {
        vcs
    }

    // Support for loops (for-in statements)
    public static func buildArray(_ vcs: [UIViewController]) -> [UIViewController] {
        vcs
    }
    
    public static func buildArray(_ vcs: [[UIViewController]]) -> [UIViewController] {
        vcs.flatMap { $0 }
    }
    
    // Support for limited availability (e.g., #available)
    public static func buildLimitedAvailability(_ vc: UIViewController) -> [UIViewController] {
        [vc]
    }

    // Support for limited availability (e.g., #available)
    public static func buildLimitedAvailability(_ vcs: [UIViewController]) -> [UIViewController] {
        vcs
    }

    // Support for final result transformation
    public static func buildFinalResult(_ vc: UIViewController) -> UIViewController {
        vc
    }
    
    // Support for final result transformation
    public static func buildFinalResult(_ vcs: [UIViewController]) -> [UIViewController] {
        vcs
    }
}
