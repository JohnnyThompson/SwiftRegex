//
//  ViewController.swift
//  CleverRegEx
//
//  Created by Евгений Карпов on 04.09.2022.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    // MARK: - Private vars
    private lazy var regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    // MARK: - Views
    private lazy var cleverLogo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cleverLogo"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect

        return textField
    }()

    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true

        return label
    }()

    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBackgroundColor
        button.layer.cornerRadius = 10
        button.setTitle("CHECK", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(checkEmailWithRegularExpression), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        configureViews()
        setupConstraints()
    }

    private func configureViews() {
        view.backgroundColor = .mainBackgroundColor
        emailTextField.delegate = self

        view.addSubview(cleverLogo)
        view.addSubview(emailTextField)
        view.addSubview(informationLabel)
        view.addSubview(checkButton)
    }

    private func setupConstraints() {
        cleverLogo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.large)
            $0.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Constants.large)
            $0.right.equalToSuperview().inset(Constants.large)
            $0.top.equalTo(cleverLogo.snp.bottom).offset(Constants.textFieldTopOffset)
        }

        informationLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Constants.large)
            $0.left.equalToSuperview().offset(Constants.medium)
            $0.trailing.equalToSuperview().inset(Constants.medium)
        }

        checkButton.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(Constants.large)
            $0.left.equalToSuperview().offset(Constants.large)
            $0.trailing.equalToSuperview().inset(Constants.large)
            $0.height.equalTo(Constants.buttonHeight)
        }
    }

    // MARK: - Actions
    @objc
    private func checkEmailWithRegularExpression() {
        informationLabel.isHidden = false
        if
            let email = emailTextField.text?.trimmingWhitespaces,
            !email.isEmpty,
            email.matches(regex)
        {
            informationLabel.textColor = .black
            informationLabel.text = "Введенный E-mail валидный"
        } else {
            informationLabel.textColor = .red
            informationLabel.text = "Ожидаемый формат E-mail example@example.com"
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.text = ""
        informationLabel.text = ""
        informationLabel.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkEmailWithRegularExpression()
        informationLabel.isHidden = false
        return true
    }
}

// MARK: - Constants
private extension ViewController {
    private struct Constants {
        static let medium: CGFloat = 16
        static let large: CGFloat = 32
        static let textFieldTopOffset: CGFloat = 70
        static let buttonHeight: CGFloat = 45
    }
}

