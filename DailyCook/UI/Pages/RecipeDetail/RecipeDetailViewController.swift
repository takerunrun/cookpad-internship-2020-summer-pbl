//
//  RecipeDetailViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import ReusableKit
import Photos

final class RecipeDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let cookedRecipeCell = ReusableCell<RecipeDetailCookedRecipeCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let skipButton = SkipButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 96, height: 24)
    }
    
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = RecipeDetailHeaderView()
    
    private let cookedRecipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = RecipeDetailCookedRecipeCell.Const.itemSize
        $0.minimumLineSpacing = 0
    }).then {
        $0.register(Reusable.cookedRecipeCell)
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        
        view.backgroundColor = .white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.setCustomSpacing(32, after: header)
        stackView.addArrangedSubview(cookedRecipeCollectionView)
        
        header.postImageButton.addTarget(self, action: #selector(didTapRecipeOverlay), for: .touchUpInside)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecipeDetailReactor) {
        header.reactor = reactor
        
        // Action
        skipButton.rx.tap
            .bind { _ in
                reactor.action.onNext(.skip)
            }
            .disposed(by: disposeBag)
        
        header.recipeUrlButton.rx.tap
            .bind { [weak self] in
                let viewController = WebRecipeViewController(url: reactor.currentState.recipe.recipeUrl)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.recipe.isSkipped }
            .distinctUntilChanged()
            .bind(to: skipButton.rx.isSkipped)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.cookedRecipeReactors }
            .distinctUntilChanged()
            .bind(to: cookedRecipeCollectionView.rx.items(Reusable.cookedRecipeCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.cookedRecipeReactors.count }
        .distinctUntilChanged()
            .bind { [weak self] count in
                self?.cookedRecipeCollectionView.removeConstraints(self?.cookedRecipeCollectionView.constraints ?? [])
                self?.cookedRecipeCollectionView.snp.makeConstraints {
                    $0.width.equalTo(DeviceSize.screenWidth)
                    $0.height.equalTo(RecipeDetailCookedRecipeCell.Const.cellHeight * CGFloat(count))
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RecipeDetailViewController {
    @objc private func didTapRecipeOverlay() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            showCameraRoll()
            return
        }
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .authorized:
                    self?.showCameraRoll()
                case .denied, .restricted:
                    let noCameraAccessAlertController = UIAlertController(title: "アクセスを許可してください。",message: nil,preferredStyle: .alert)
                    let closeAction = UIAlertAction(title: NSLocalizedString("キャンセル", comment: ""), style: .cancel, handler: nil)
                    noCameraAccessAlertController.addAction(closeAction)
                    let settingsAction = UIAlertAction(title: NSLocalizedString("設定を開く", comment: ""), style: .default) { _ in
                        let url = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(url)
                    }
                    noCameraAccessAlertController.addAction(settingsAction)
                    self?.present(noCameraAccessAlertController, animated: true, completion: nil)
                case .notDetermined:
                    assertionFailure()
                @unknown default:
                    assertionFailure()
                }
            }
        }

    }

    private func showCameraRoll() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension RecipeDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        let imageData = image.jpegData(compressionQuality: 1.0)
        reactor?.action.onNext(.postImageData(imageData))
    }
}
