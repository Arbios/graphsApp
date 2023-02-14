import UIKit

// MARK: MainUIView

final class MainUIView: UIView {

    // MARK: - Types

    typealias TextChange = (String?) -> Void

    // MARK: - Internal Properties

    var onTextChange: TextChange?
    var onRequestDotsTap: IntBlock?

    // MARK: - Private Properties

    private lazy var titleLabel = UILabel().then {
        $0.text = "Graphs"
        $0.font = UIFont.systemFont(ofSize: 32)
        $0.textColor = UIColor.subTitleColor
        $0.textAlignment = .center
    }

    private lazy var imageView = UIImageView().then {
        $0.image = UIImage.logo
        $0.contentMode = .scaleAspectFit
    }

    private lazy var subTitleLabel = UILabel().then {
        $0.text = "Введите количество требуемых точек"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.subTitleColor
    }

    private lazy var textField = DGTextField().then {
        $0.borderStyle = .roundedRect
        $0.keyboardType = .numberPad
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 22)
        $0.textAlignment = .right
        $0.pp.editingChanged { [weak self] textField in
            self?.onTextChange?(textField.text)
        }
    }

    private lazy var button = UIButton().then {
        $0.setTitle("Поехали", for: .normal)
        $0.setTitleColor(UIColor.blueLineColor, for: .normal)
        
        $0.pp.tap { [weak self] _ in
            guard let self = self else { return }
            self.onRequestDotsTap?(self.count)
        }
    }

    private var count: Int = 0

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .backgroundColor

        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }

        addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
        }

        addSubview(button)
        button.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(32)
            $0.top.equalTo(textField.snp.bottom).offset(20)
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(32)
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-40)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-20)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("not impelemted")
    }

    // MARK: - Internal Methods

    func set(count: Int) {
        self.count = count
    }

    func setButtonIsEnabled(_ isEnabled: Bool) {
        if isEnabled {
            button.setTitleColor(UIColor.blueLineColor, for: .normal)
        } else {
            button.setTitleColor(UIColor.subTitleColor, for: .normal)
        }
    }

    func wiggleTextField() {
        textField.wiggle()
    }
}
