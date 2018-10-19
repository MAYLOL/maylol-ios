//
//  PMLPublishViewController.swift
//  PMLCommunity
//
//  Created by panchuang on 2018/9/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

import AVFoundation
import AVKit
import Aztec
import Foundation
import Gridicons
import MobileCoreServices
import Photos
import UIKit
import SnapKit
import WordPressEditor

let videoDuration = 60
let maxImageCount = 1
let ScreentWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

class PMLPublishViewController: UIViewController {
    
    fileprivate var mediaErrorMode = false
    
    lazy var leftBarItem:UIBarButtonItem = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setTitle(NSLocalizedString("取消", comment: "cancel"), for: .normal)
        leftBtn.setTitleColor(UIColor(red: 101.0/255, green: 101.0/255, blue: 101.0/255, alpha: 1), for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftBtn.addTarget(self, action: #selector(leftItemTouch), for: .touchUpInside)
        let item = UIBarButtonItem(customView: leftBtn)
        return item;
    }()
    
    lazy var topView:PMLPublishTopView = {
        let top = Bundle.main.loadNibNamed(NSStringFromClass(PMLPublishTopView.self), owner: nil, options: nil)?.first as! PMLPublishTopView
        top.delegate = self
        return top
    }()

    fileprivate(set) lazy var toolsBar: PMLPublishBottomView = {
        return self.createToolsBar()
    }()
    
    private var richTextView: TextView {
        get {
            return editorView.richTextView
        }
    }
    
    private var htmlTextView: UITextView {
        get {
            return editorView.htmlTextView
        }
    }
    
    fileprivate(set) lazy var editorView: Aztec.EditorView = {
        let defaultHTMLFont: UIFont
        
        if #available(iOS 11, *) {
            defaultHTMLFont = UIFontMetrics.default.scaledFont(for: Constants.defaultContentFont)
        } else {
            defaultHTMLFont = Constants.defaultContentFont
        }
        
        let editorView = Aztec.EditorView(
            defaultFont: Constants.defaultContentFont,
            defaultHTMLFont: defaultHTMLFont,
            defaultParagraphStyle: .default,
            defaultMissingImage: Constants.defaultMissingImage)
        //如果为false 将导致richViewc滑到外部
        editorView.clipsToBounds = true
        setupHTMLTextView(editorView.htmlTextView)
        setupRichTextView(editorView.richTextView)
        
        return editorView
    }()
    
    private func setupRichTextView(_ textView: TextView) {
        if wordPressMode {
            textView.load(WordPressPlugin())
        }
        
        let accessibilityLabel = NSLocalizedString("Rich Content", comment: "Post Rich content")
        self.configureDefaultProperties(for: textView, accessibilityLabel: accessibilityLabel)
        
        textView.delegate = self
        textView.formattingDelegate = self
        textView.textAttachmentDelegate = self
        textView.accessibilityIdentifier = "richContentView"
        textView.clipsToBounds = false
        if #available(iOS 11, *) {
            textView.smartDashesType = .no
            textView.smartQuotesType = .no
        }
    }
    
    private func setupHTMLTextView(_ textView: UITextView) {
        let accessibilityLabel = NSLocalizedString("HTML Content", comment: "Post HTML content")
        self.configureDefaultProperties(for: textView, accessibilityLabel: accessibilityLabel)
        
        textView.isHidden = true
        textView.delegate = self
        textView.accessibilityIdentifier = "HTMLContentView"
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.clipsToBounds = false
        if #available(iOS 10, *) {
            textView.adjustsFontForContentSizeCategory = true
        }
        
        if #available(iOS 11, *) {
            textView.smartDashesType = .no
            textView.smartQuotesType = .no
        }
    }
    
    fileprivate(set) lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.accessibilityLabel = NSLocalizedString("Title", comment: "Post title")
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        textView.returnKeyType = .next
        textView.textColor = .darkText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textAlignment = .natural
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    /// Placeholder Label
    ///
    fileprivate(set) lazy var titlePlaceholderLabel: UILabel = {
        let placeholderText = NSLocalizedString("请输入标题", comment: "Post title placeholder")
        let titlePlaceholderLabel = UILabel()
        
        titlePlaceholderLabel.backgroundColor = UIColor.white
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor(red: 179.0/255, green: 179.0/255, blue: 179.0/255, alpha: 1), .font: UIFont(name: "PingFang-SC-Medium", size: 18)!]
        
        titlePlaceholderLabel.attributedText = NSAttributedString(string: placeholderText, attributes: attributes)
        titlePlaceholderLabel.sizeToFit()
        titlePlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        titlePlaceholderLabel.textAlignment = .natural
        
        return titlePlaceholderLabel
    }()
    
    fileprivate var titleTextViewHtight:CGFloat = 0.0
    
    fileprivate(set) lazy var separatorView: UIImageView = {
        let separatorView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 1))
        separatorView.image = UIImage(named: "release_line")
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return separatorView
    }()
    
    fileprivate var currentSelectedAttachment: MediaAttachment?
    
    let sampleHTML: String?
    let wordPressMode: Bool
    let source: Int // 0 发布文章  1 发布话题  2 写回答
    
    fileprivate var optionsViewController: OptionsTableViewController!
    
    
    // MARK: - Lifecycle Methods
    
    @objc init(withSampleHTML sampleHTML: String? = nil, wordPressMode: Bool, source: Int) {
        
        self.sampleHTML = sampleHTML
        self.wordPressMode = wordPressMode
        self.source = source
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        sampleHTML = nil
        wordPressMode = false
        source = 0
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = leftBarItem;
        switch source {
        case 0:
            self.navigationItem.rightBarButtonItem = self.createRightItem(title: NSLocalizedString("下一步", comment: "next"))
        case 1, 2:
            self.navigationItem.rightBarButtonItem = self.createRightItem(title: NSLocalizedString("发布", comment: "next"))
        default:
            break
        }
        
        MediaAttachment.defaultAppearance.progressColor = UIColor.blue
        MediaAttachment.defaultAppearance.progressBackgroundColor = UIColor.lightGray
        MediaAttachment.defaultAppearance.progressHeight = 2.0
        MediaAttachment.defaultAppearance.overlayColor = UIColor(red: CGFloat(46.0/255.0), green: CGFloat(69.0/255.0), blue: CGFloat(83.0/255.0), alpha: 0.6)
        // Uncomment to add a border
        
        edgesForExtendedLayout = UIRectEdge()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        if self.source == 0 {
            view.addSubview(self.topView)
        }else if source == 1 {
            
        }
        view.addSubview(titleTextView);
        view.addSubview(editorView)
        view.addSubview(titlePlaceholderLabel)
        view.addSubview(separatorView)
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        //Don't allow scroll while the constraints are being setup and text set
        editorView.isScrollEnabled = false
        configureConstraints()
        registerAttachmentImageProviders()
        
        let html: String
        
        if let sampleHTML = sampleHTML {
            html = sampleHTML
        } else {
            html = ""
        }
        
        editorView.setHTML(html)
        editorView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Reanable scroll after setup is done
        editorView.isScrollEnabled = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //防止导航栏上移
        view.endEditing(true)
        IQKeyboardManager.shared().isEnabled = true
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        nc.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        dismissOptionsViewControllerIfNecessary()
    }
    
    func updateTitleHeight() {
        let layoutMargins = view.layoutMargins
        let insets = titleTextView.textContainerInset
        
        var titleWidth = titleTextView.bounds.width
        if titleWidth <= 0 {
            // Use the title text field's width if available, otherwise calculate it.
            titleWidth = view.frame.width - (insets.left + insets.right + layoutMargins.left + layoutMargins.right)
        }
        let sizeThatShouldFitTheContent = titleTextView.sizeThatFits(CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude))
        titleTextViewHtight = max(sizeThatShouldFitTheContent.height, titleTextView.font!.lineHeight + insets.top + insets.bottom)
        
        titlePlaceholderLabel.isHidden = !titleTextView.text.isEmpty
        
        var contentInset = editorView.contentInset
        contentInset.top = (titleTextViewHtight + separatorView.frame.height)
        //这一句导致界面跳动
//        editorView.contentInset = contentInset
//        editorView.contentOffset = CGPoint(x: 0, y: -contentInset.top)
        titleTextView.snp.updateConstraints { (make) in
            make.height.equalTo(titleTextViewHtight)
        }
    }
    
    fileprivate func refreshInsets(forKeyboardFrame keyboardFrame: CGRect) {
        let keyboardHeight = view.frame.maxY - (keyboardFrame.minY + view.layoutMargins.bottom)
        let contentInset = UIEdgeInsets(top: editorView.contentInset.top, left: 0, bottom: keyboardHeight, right: 0)
        editorView.contentInset = contentInset
    }
    
    private func configureConstraints() {
//        self.topView.frame = CGRect(x: 0, y: 40, width: ScreentWidth, height: 40)
        self.topView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.equalTo(40)
        }

        titleTextView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(8)
            make.right.equalTo(view).offset(-8)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(ceil(titleTextView.font!.lineHeight) + 17)
        }

        titlePlaceholderLabel.snp.makeConstraints { (make) in
            make.top.right.height.equalTo(titleTextView)
            make.left.equalTo(titleTextView).offset(8)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleTextView)
            make.top.equalTo(titleTextView.snp.bottom)
            make.height.equalTo(1)
        }
        
        editorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(separatorView.snp.bottom)
        }

    }
    
    
    private func configureDefaultProperties(for textView: UITextView, accessibilityLabel: String) {
        textView.accessibilityLabel = accessibilityLabel
        textView.font = Constants.defaultContentFont
        textView.keyboardDismissMode = .interactive
        textView.textColor = UIColor.darkText
    }
    
    private func registerAttachmentImageProviders() {
        let providers: [TextViewAttachmentImageProvider] = [
            GutenpackAttachmentRenderer(),
            SpecialTagAttachmentRenderer(),
            CommentAttachmentRenderer(font: Constants.defaultContentFont),
            HTMLAttachmentRenderer(font: Constants.defaultHtmlFont),
            ]
        
        for provider in providers {
            richTextView.registerAttachmentImageProvider(provider)
        }
    }
    
    // MARK: - Helpers
    
    @IBAction func toggleEditingMode() {
//        formatBar.overflowToolbar(expand: true)
        editorView.toggleEditingMode()
    }
    
    fileprivate func dismissOptionsViewControllerIfNecessary() {
        if let optionsViewController = optionsViewController,
            presentedViewController == optionsViewController {
            dismiss(animated: true, completion: nil)
            
            self.optionsViewController = nil
        }
    }
    
    // MARK: - Keyboard Handling
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        refreshInsets(forKeyboardFrame: keyboardFrame)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        refreshInsets(forKeyboardFrame: keyboardFrame)
        dismissOptionsViewControllerIfNecessary()
    }
    
    override var keyCommands: [UIKeyCommand] {
        return []
    }
    
    
    // MARK: - Sample Content
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if richTextView.resignFirstResponder() {
            richTextView.becomeFirstResponder()
        }
        
        if htmlTextView.resignFirstResponder() {
            htmlTextView.becomeFirstResponder()
        }
        
        if titleTextView.resignFirstResponder() {
            titleTextView.becomeFirstResponder()
        }
    }
    
    @objc func leftItemTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightItemTouch() {
        //这句代码是转换显示样式的 richText 或者是htmlText
//        toggleEditingMode()
        switch source {
        case 0:
            var params = [String:AnyObject]()
            params["title"] = "新文章" as AnyObject
            params["uid"] = "123456-12345678-123456789" as AnyObject
//            params["hasTxt"] = "1" as AnyObject
//            params["hasImg"] = "1" as AnyObject
//            params["hasVdo"] = "1" as AnyObject
            params["content"] = richTextView.getHTML() as AnyObject
            
            PMLNetWorkRequest.requestData(withParams: params, interfaceName: "articles", requestType: PMLRequestType.post, success: { (task, responeObject) in
                print(responeObject!)
            }) { (task, error) in
                print(error!)
            }
//            print("普通文本 === \(richTextView.getHTML())")
//            print("富文本 ===== \(richTextView.attributedText)")
            
//            let coverVC = PMLSelectCoverViewController()
//            coverVC.coverImage = UIImage(named: "")
//            self.navigationController?.pushViewController(coverVC, animated: true)
        case 1:
            break
        case 2:
            break
        default:
            break
        }
        
    }
    
    //MARK: tools bar
    func createToolsBar() -> PMLPublishBottomView {
        let toolsBar = PMLPublishBottomView(frame: CGRect(x: 0, y: view.frame.height - 44, width: view.frame.width, height: 44.0))
        toolsBar.delegate = self
        return toolsBar
    }
    
    func createRightItem(title: String) -> UIBarButtonItem {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(UIColor(red: 240.0/255, green: 46.0/255, blue: 68.0/255, alpha: 1), for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.addTarget(self, action: #selector(rightItemTouch), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: rightBtn)
        return rightItem
    }
}

//MARK: PMLPublishTopViewDelegate
extension PMLPublishViewController : PMLPublishTopViewDelegate {
    func selectPlate() {
        let plateVC = PMLSelectedPlateViewController()
        plateVC.delegate = self
        self.navigationController?.pushViewController(plateVC, animated: true)
    }
}

//MARK: PMLSelectedPlateViewControllerDelegate
extension PMLPublishViewController : PMLSelectedPlateViewControllerDelegate {
    func selectedPlate(_ plate: String) {
        self.topView.nameField.text = plate
    }
}

//MARK: UITextViewDelegate
extension PMLPublishViewController : UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
//        updateFormatBar()
//        changeRichTextInputView(to: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case richTextView: break
//            updateFormatBar()
        case titleTextView:
            updateTitleHeight()
        default:
            break
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        switch textView {
        case titleTextView: break
//            formatBar.enabled = false
        case richTextView: break
//            formatBar.enabled = true
        case htmlTextView: break
//            formatBar.enabled = false
        default: break
        }
        
        textView.inputAccessoryView = toolsBar
        return true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateTitlePosition()
    }
}

extension PMLPublishViewController : TextViewFormattingDelegate {
    func textViewCommandToggledAStyle() {
//        updateFormatBar()
    }
}

extension PMLPublishViewController : UITextFieldDelegate {
    
}

extension PMLPublishViewController {
    enum EditMode {
        case richText
        case html
        
        mutating func toggle() {
            switch self {
            case .html:
                self = .richText
            case .richText:
                self = .html
            }
        }
    }
}


// MARK: - Format Bar Actions
extension PMLPublishViewController {
    func changeRichTextInputView(to: UIView?) {
        if richTextView.inputView == to {
            return
        }
        
        richTextView.inputView = to
        richTextView.reloadInputViews()
    }
}

//MARK:PMLPublishBottomViewDelegate
extension PMLPublishViewController: PMLPublishBottomViewDelegate {
    func itemTouch(_ itemType: Int32) {
        switch itemType {
        case 0:
            //照片
            self.selectMediaWithType(type: 0)
            break
        case 1:
            //视频
            self.selectMediaWithType(type: 1)
            break
        case 2:
            break
        case 3:
            view.endEditing(true)
            break
        default:
            break
        }
    }
}

//MARK: media operation
extension PMLPublishViewController {
    func selectMediaWithType(type: Int) {
        let imagePickVC = TZImagePickerController(maxImagesCount: maxImageCount, delegate: self)
        imagePickVC?.videoMaximumDuration = TimeInterval(videoDuration)
        imagePickVC?.uiImagePickerControllerSettingBlock = { (imagePick: UIImagePickerController!) in
            imagePick.videoQuality = .typeHigh
        }
        imagePickVC?.showPhotoCannotSelectLayer = true
        // 设置竖屏下的裁剪尺寸
        let left = 30.0;
        let widthHeight = Double(self.view.frame.size.width) - 2 * left;
        let top = (Double(self.view.frame.size.height) - widthHeight) / 2;
        imagePickVC?.cropRect = CGRect(x: left, y: top, width: widthHeight, height: widthHeight)
        if type == 0 {
            imagePickVC?.allowTakeVideo = false;
            imagePickVC?.allowTakePicture = true;
            imagePickVC?.allowPickingImage = true;
            imagePickVC?.allowPickingVideo = false;
        }else {
            imagePickVC?.allowTakeVideo = true;
            imagePickVC?.allowTakePicture = false;
            imagePickVC?.allowPickingImage = false;
            imagePickVC?.allowPickingVideo = true;
        }
        present(imagePickVC!, animated: true, completion: nil)
    }
}

extension PMLPublishViewController: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
//        for i in 0..<photos.count {
//            self.insertImage(photos[i])
//        }
        self.insertImage(photos[0])
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingVideo coverImage: UIImage!, sourceAssets asset: PHAsset!) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "视频压缩中...";
        TZImageManager.default().getVideoOutputPath(with: asset, presetName: AVAssetExportPresetMediumQuality, success: { (outputPath) in
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: outputPath!) {
                var size:Float = 0
                do {
                    let attr = try fileManager.attributesOfItem(atPath: outputPath!)
                    size += attr[FileAttributeKey.size] as! Float
                } catch  {
                    print("error :\(error)")
                }
                print("\(size/(1024*1024))MB")
//                print(String(size/(1024*1024)) + "MB")
            }
            let URL = NSURL.init(string: outputPath!)
            print(URL!)
            
            self.insertVideo(URL! as URL, coverImage)
            hud.hide(animated: true)
        }) { (errorMessage,nil) in
            print(errorMessage as Any)
        }
    }
}

//MARK: TextViewAttachmentDelegate
extension PMLPublishViewController: TextViewAttachmentDelegate {
    
    func textView(_ textView: TextView, attachment: NSTextAttachment, imageAt url: URL, onSuccess success: @escaping (UIImage) -> Void, onFailure failure: @escaping () -> Void) {
        
        switch attachment {
        case let videoAttachment as VideoAttachment:
            guard let posterURL = videoAttachment.posterURL else {
                // Let's get a frame from the video directly
                exportPreviewImageForVideo(atURL: url, onCompletion: success, onError: failure)
                return
            }
            downloadImage(from: posterURL, success: success, onFailure: failure)
        case let imageAttachment as ImageAttachment:
            if let imageURL = imageAttachment.url {
                downloadImage(from: imageURL, success: success, onFailure: failure)
            }
        default:
            failure()
        }
    }
    
    func textView(_ textView: TextView, placeholderFor attachment: NSTextAttachment) -> UIImage {
        return placeholderImage(for: attachment)
    }
    
    func placeholderImage(for attachment: NSTextAttachment) -> UIImage {
        let imageSize = CGSize(width:64, height:64)
        let placeholderImage: UIImage
        switch attachment {
        case _ as ImageAttachment:
            placeholderImage = Gridicon.iconOfType(.image, withSize: imageSize)
        case _ as VideoAttachment:
            placeholderImage = Gridicon.iconOfType(.video, withSize: imageSize)
        default:
            placeholderImage = Gridicon.iconOfType(.attachment, withSize: imageSize)
        }
        
        return placeholderImage
    }
    
    func textView(_ textView: TextView, urlFor imageAttachment: ImageAttachment) -> URL? {
        guard let image = imageAttachment.image else {
            return nil
        }
        
        // TODO: start fake upload process
//        return saveToDisk(image: image)
        return nil
    }
    
    //移除媒体资源的回调
    func textView(_ textView: TextView, deletedAttachment attachment: MediaAttachment) {
        print("Attachment \(attachment.identifier) removed.\n")
    }
    
    func textView(_ textView: TextView, selected attachment: NSTextAttachment, atPosition position: CGPoint) {
        switch attachment {
        case let attachment as HTMLAttachment:
            displayUnknownHtmlEditor(for: attachment)
        case let attachment as MediaAttachment:
            selected(textAttachment: attachment, atPosition: position)
        default:
            break
        }
    }
    
    func textView(_ textView: TextView, deselected attachment: NSTextAttachment, atPosition position: CGPoint) {
        deselected(textAttachment: attachment, atPosition: position)
    }
    
    fileprivate func resetMediaAttachmentOverlay(_ mediaAttachment: MediaAttachment) {
        mediaAttachment.overlayImage = nil
        mediaAttachment.message = nil
    }
    
    func selected(textAttachment attachment: MediaAttachment, atPosition position: CGPoint) {
        if (currentSelectedAttachment == attachment) {
            displayActions(forAttachment: attachment, position: position)
        } else {
            if let selectedAttachment = currentSelectedAttachment {
                resetMediaAttachmentOverlay(selectedAttachment)
                richTextView.refresh(selectedAttachment)
            }
            
            // and mark the newly tapped attachment
            if attachment.message == nil {
                let message = NSLocalizedString("Options", comment: "Options to show when tapping on a media object on the post/page editor.")
                attachment.message = NSAttributedString(string: message, attributes: mediaMessageAttributes)
            }
            attachment.overlayImage = Gridicon.iconOfType(.pencil, withSize: CGSize(width: 32.0, height: 32.0)).withRenderingMode(.alwaysTemplate)
            richTextView.refresh(attachment)
            currentSelectedAttachment = attachment
        }
    }
    
    func deselected(textAttachment attachment: NSTextAttachment, atPosition position: CGPoint) {
        currentSelectedAttachment = nil
        if let mediaAttachment = attachment as? MediaAttachment {
            resetMediaAttachmentOverlay(mediaAttachment)
            richTextView.refresh(mediaAttachment)
        }
    }
    
    func displayVideoPlayer(for videoURL: URL) {
        let asset = AVURLAsset(url: videoURL)
        let controller = AVPlayerViewController()
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        controller.showsPlaybackControls = true
        controller.player = player
        player.play()
        present(controller, animated:true, completion: nil)
    }
}

extension PMLPublishViewController: UINavigationControllerDelegate
{
}

// MARK: - Unknown HTML
//
private extension PMLPublishViewController {
    
    func displayUnknownHtmlEditor(for attachment: HTMLAttachment) {
        let targetVC = UnknownEditorViewController(attachment: attachment)
        targetVC.onDidSave = { [weak self] html in
            self?.richTextView.edit(attachment) { updated in
                updated.rawHTML = html
            }
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        targetVC.onDidCancel = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        let navigationController = UINavigationController(rootViewController: targetVC)
        displayAsPopover(viewController: navigationController)
    }
    
    func displayAsPopover(viewController: UIViewController) {
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = view.frame.size
        
        let presentationController = viewController.popoverPresentationController
        presentationController?.sourceView = view
        presentationController?.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
}


// MARK: - UIPopoverPresentationControllerDelegate
//
extension PMLPublishViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        if optionsViewController != nil {
            optionsViewController = nil
        }
    }
}

// MARK: - Media fetch methods
//
private extension PMLPublishViewController {
    
    func exportPreviewImageForVideo(atURL url: URL, onCompletion: @escaping (UIImage) -> (), onError: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)
            guard asset.isExportable else {
                onError()
                return
            }
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: CMTimeMake(2, 1))],
                                                     completionHandler: { (time, cgImage, actualTime, result, error) in
                                                        guard let cgImage = cgImage else {
                                                            DispatchQueue.main.async {
                                                                onError()
                                                            }
                                                            return
                                                        }
                                                        let image = UIImage(cgImage: cgImage)
                                                        DispatchQueue.main.async {
                                                            onCompletion(image)
                                                        }
            })
        }
    }
    
    func downloadImage(from url: URL, success: @escaping (UIImage) -> Void, onFailure failure: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            DispatchQueue.main.async {
                guard self != nil else {
                    return
                }
                
                guard error == nil, let data = data, let image = UIImage(data: data, scale: UIScreen.main.scale) else {
                    failure()
                    return
                }
                
                success(image)
            }
        }
        
        task.resume()
    }
}
// MARK: - Misc
//
private extension PMLPublishViewController
{
//    func saveToDisk(image: UIImage) -> URL {
//        let fileName = "\(ProcessInfo.processInfo.globallyUniqueString)_file.jpg"
//
//        guard let data = UIImageJPEGRepresentation(image, 0.9) else {
//            fatalError("Could not conert image to JPEG.")
//        }
//
//        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
//
//        guard (try? data.write(to: fileURL, options: [.atomic])) != nil else {
//            fatalError("Could not write the image to disk.")
//        }
//
//        return fileURL
//    }
    
    func insertImage(_ image: UIImage) {
        
        //        let fileURL = saveToDisk(image: image)
        let data = UIImageJPEGRepresentation(image, 0.1);
        
        let base64String = data?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        //MARK: data:video/mp4;base64,(视频前缀)  data:image/jpg;base64,(图片前缀)
        let fileURL = NSURL(string:("data:image/jpg;base64," + base64String!))
        let attachment = richTextView.replaceWithImage(at: richTextView.selectedRange, sourceURL: fileURL! as URL, placeHolderImage: image)
        attachment.size = .full
        attachment.alignment = .none
    }
    
    func insertVideo(_ videoURL: URL, _ coverImage:UIImage) {
        let videoData = NSData(contentsOfFile: videoURL.absoluteString)
        let videoBase64String = videoData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let videoUrl = NSURL(string:("data:video/mp4;base64," + videoBase64String!))
        
        let imageData = UIImageJPEGRepresentation(coverImage, 0.3)
        let imageBase64 = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        let imageURL = NSURL(string:("data:image/jpg;base64," + imageBase64!))
        
        let asset = AVURLAsset(url: videoURL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        imgGenerator.appliesPreferredTrackTransform = true
        let posterImage = coverImage
//        let posterURL = saveToDisk(image: posterImage)
        let attachment = richTextView.replaceWithVideo(at: richTextView.selectedRange, sourceURL: URL(string:"placeholder://")!, posterURL: imageURL! as URL, placeHolderImage: posterImage)
        attachment.updateURL(videoUrl! as URL)
    }
    
    var mediaMessageAttributes: [NSAttributedStringKey: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                                                        .paragraphStyle: paragraphStyle,
                                                        .foregroundColor: UIColor.white]
        return attributes
    }
    
    func displayActions(forAttachment attachment: MediaAttachment, position: CGPoint) {
        let mediaID = attachment.identifier
        let title: String = NSLocalizedString("Media Options", comment: "Title for action sheet with media options.")
        let message: String? = nil
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: "User action to dismiss media options."),
                                          style: .cancel,
                                          handler: { [weak self] (action) in
                                            self?.resetMediaAttachmentOverlay(attachment)
                                            self?.richTextView.refresh(attachment)
            }
        )
        alertController.addAction(dismissAction)
        
        let removeAction = UIAlertAction(title: NSLocalizedString("Remove Media", comment: "User action to remove media."),
                                         style: .destructive,
                                         handler: { [weak self] (action) in
                                            self?.richTextView.remove(attachmentID: mediaID)
        })
        
        alertController.addAction(removeAction)
        alertController.title = title
        alertController.message = message
        alertController.popoverPresentationController?.sourceView = richTextView
        alertController.popoverPresentationController?.sourceRect = CGRect(origin: position, size: CGSize(width: 1, height: 1))
        alertController.popoverPresentationController?.permittedArrowDirections = .any
        present(alertController, animated:true, completion: nil)
    }
    
    func displayDetailsForAttachment(_ attachment: ImageAttachment, position:CGPoint) {
        
        let caption = richTextView.caption(for: attachment)
        let detailsViewController = AttachmentDetailsViewController.controller(for: attachment, with: caption)
        
        let linkInfo = richTextView.linkInfo(for: attachment)
        let linkRange = linkInfo?.range
        let linkUpdateRange = linkRange ?? richTextView.textStorage.ranges(forAttachment: attachment).first!
        
        if let linkURL = linkInfo?.url {
            detailsViewController.linkURL = linkURL
        }
        
        detailsViewController.onUpdate = { [weak self] (alignment, size, srcURL, linkURL, alt, caption) in
            guard let `self` = self else {
                return
            }
            
            let attachment = self.richTextView.edit(attachment) { attachment in
                if let alt = alt {
                    attachment.extraAttributes["alt"] = alt
                }
                
                attachment.alignment = alignment
                attachment.size = size
                attachment.updateURL(srcURL)
            }
            
            if let caption = caption, caption.length > 0 {
                self.richTextView.replaceCaption(for: attachment, with: caption)
            } else {
                self.richTextView.removeCaption(for: attachment)
            }
            
            if let newLinkURL = linkURL {
                self.richTextView.setLink(newLinkURL, inRange: linkUpdateRange)
            } else if linkURL != nil {
                self.richTextView.removeLink(inRange: linkUpdateRange)
            }
        }
        
        let selectedRange = richTextView.selectedRange
        
        detailsViewController.onDismiss = { [unowned self] in
            self.richTextView.becomeFirstResponder()
            self.richTextView.selectedRange = selectedRange
        }
        
        let navigationController = UINavigationController(rootViewController: detailsViewController)
        present(navigationController, animated: true, completion: nil)
    }
}


extension PMLPublishViewController {
    
    struct Constants {
        static let defaultContentFont   = UIFont.systemFont(ofSize: 14)
        static let defaultHtmlFont      = UIFont.systemFont(ofSize: 24)
        static let defaultMissingImage  = Gridicon.iconOfType(.image)
        static let formatBarIconSize    = CGSize(width: 20.0, height: 20.0)
        static let headers              = [Header.HeaderType.none, .h1, .h2, .h3, .h4, .h5, .h6]
        static let lists                = [TextList.Style.unordered, .ordered]
        static let moreAttachmentText   = "more"
        static let titleInsets          = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    struct MediaProgressKey {
        static let mediaID = ProgressUserInfoKey("mediaID")
        static let videoURL = ProgressUserInfoKey("videoURL")
    }
}


