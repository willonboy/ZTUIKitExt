//
//  AppDelegate.swift
//  ZTUIKitDemo
//
//  Created by trojan on 2024/6/4.
//

import UIKit
import ZTChain
import Stevia
import ZTUIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let bs = true
        window = UIWindow {
            UINavigationController {
                SteviaVC()
                ZTVC {
                    UIView {
                        ZTVStack {
                            if bs {
                                UILabel("User:").zt.domId("#lbl").makeStevia { v, dom in
                                    v.left(10).top(10).width(80).height(20)
                                }.subject
                            } else {
                                UILabel("PWD:").zt.makeStevia { v, dom in
                                    v.left(10).top(10).width(80).height(20)
                                }.subject
                            }
                            UITextField("字母数字下划线").zt.backgroundColor(.gray).makeStevia { v, dom in
                                v.Left == dom("#lbl")!.Right + 10
                                v.Top == dom("#lbl")!.Top
                                v.width(200).height(20)
                            }.subject
                            
                            ZTVStack {
                                ZTSpacer(50)
                                if bs {
                                    ZTVStack {
                                        UILabel("if :")
                                        ZTSpacer(10)
                                        UILabel("ZTWrapperWidget:kkkk")
                                        ZTSpacer(10)
                                        UILabel("tips:")
                                    }
                                }
                                ZTSpacer(10)
                                if #available(iOS 17, *) {
                                    ZTVStack {
                                        UILabel("if #available")
                                        ZTSpacer(10)
                                        UILabel("if #available")
                                        ZTSpacer(10)
                                        UILabel("if #available").zt.textColor(.red).build()
                                    }
                                } else {
                                    for _ in 0..<10 {
                                        ZTWrapperWidget {
                                            ZTSpacer(10)
                                            UILabel("for in")
                                        }
                                    }
                                }
                            }
                        }.zt.makeStevia { v, dom in
                            v.width(300).height(280).centerInContainer()
                        }.backgroundColor(.red).build()
                    }.zt.render()
                }
            }
        }
        
        return true
    }
}


class PagingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private let items = Array(1...20).map { "Item \($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 配置布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height) // 每页占满屏幕
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // 配置 CollectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true // 启用分页
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .blue : .green
        
        // 添加标签
        let label = UILabel(frame: cell.bounds)
        label.text = items[indexPath.row]
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    // MARK: - UIScrollViewDelegate (可选，用于监控分页)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / view.frame.width)
        print("当前页: \(currentPage)")
    }
}
