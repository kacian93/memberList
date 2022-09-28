//
//  JoinMember.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class JoinMemberController : UIViewController{
    
    //MARK:  変数
    var signupMember : SignupMember = SignupMember()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var scrollView: UIScrollView!
    var member : Member = Member(emloyeeNumber: "", kanjiName: "", kanaName: "", englishName: "", position: "", affiliation: "", email: "", tel: "", dateOfEmployee: Date.now)
    
    @IBOutlet var positionLabel: UILabel!
    //入力もらうtextField
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repasswordTextField: UITextField!
    
    //メールメガジン受信のswitch
    @IBOutlet var magazineSwitch: UISwitch!
    //職位のText Field
    @IBOutlet var positionTextField: UITextField!
    
    @IBOutlet var femaleImageView : UIImageView!
    @IBOutlet var maleImageView: UIImageView!
    @IBOutlet var maleView: UIView!
    @IBOutlet var femaleView: UIView!
    @IBOutlet var genderTitle: UILabel!
    @IBOutlet var femaleLabel: UILabel!
    @IBOutlet var maleLabel: UILabel!
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var maleButton: UIButton!
    
    @IBOutlet var positionButton: UIButton!
    
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var checkboxButton: UIButton!
    var checkboxBool : Bool = true
    
    var pickerView: UIPickerView!
    //職業で決定を押す値
    var selectedPickerText : String = ""
    //職業でrowの変化がある場合の値
    var selectingText : String = ""
    var selectArrayRow : Int = 0
    
    var passwordButton = UIButton()
    var repasswordButton = UIButton()
    let noneCheckImage = UIImage(systemName: "square")
    let checkImage = UIImage(systemName: "checkmark.square.fill")
    
    let circle = UIImage(systemName: "circle")
    let selectedCircle = UIImage(systemName:  "smallcircle.filled.circle")
    
    var positionArray = ["平社員","主任","課長","部長","次長","代表"]
    
    @IBOutlet var joinMemberButton: UIButton!
    
    //validation
    var maleBool : Bool = true
    var femaleBool : Bool = false
    
    @IBOutlet var innerView: UIView!
    let defaultAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default)
    var alert : UIAlertController = UIAlertController()
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maleImageView.image = maleBool ? selectedCircle : circle
        femaleImageView.image = femaleBool ? selectedCircle : circle
        
        pickerView = UIPickerView()
        //        scrollView.flashScrollIndicators()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 730)
        //        scrollView.contentOffset.y
        //性別ボタンの基本値
        
        idTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .asciiCapable
        
        //約款の基本値
        checkboxButton.isSelected = true
        checkboxButton.setImage(checkboxButton.isSelected ? checkImage : noneCheckImage, for: .normal)
        checkboxButton.backgroundColor = .clear
        
        
        
        //職業の下の矢印のため
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let button = UIButton(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .systemGray2
        button.layer.cornerRadius = button.frame.width / 2
        //ボタンに処理を追加
        button.addTarget(self, action: #selector(makePositionArrow), for: .touchUpInside)
        view.addSubview(button)
        //デフォルトだと表示されていない
        positionTextField.rightViewMode = .always
        positionTextField.rightView = view
        
        let passwordView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        passwordButton = UIButton(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        passwordButton.setImage(UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
        passwordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        passwordView.addSubview(passwordButton)
        
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView = passwordView
        
        //パスワード（再入力）の 目メークを押せば見えるように
        let repasswordView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        repasswordButton = UIButton(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        repasswordButton.setImage(UIImage(systemName: repasswordTextField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
        repasswordButton.addTarget(self, action: #selector(showRepassword), for: .touchUpInside)
        repasswordView.addSubview(repasswordButton)
        
        repasswordTextField.rightViewMode = .always
        repasswordTextField.rightView = repasswordView
        
        
        
        //pickerviewのキャンセル、決定ボタンのため
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        toolbar.sizeToFit()
        let doneItem = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(JoinMemberController.done))
        let cancelItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(JoinMemberController.cancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([cancelItem,flexibleSpace,doneItem], animated: true)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        //magazinSwitchをディフォルト値＝True
        magazineSwitch.isSelected = true
        
        //pickerView追加
        self.positionTextField.inputView = pickerView
        self.positionTextField.inputAccessoryView = toolbar
        
        //cursorが表示されないように
        positionTextField.tintColor = UIColor.clear
        
        //keyboard以外をタッチした時、キーボードを隠す
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        
        //keyboard showing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repasswordTextField.delegate = self
        self.positionTextField.delegate = self
        
        
        self.positionTextField.text = positionArray[0]
        
        //        let optionClouser = {(action : UIAction) in
        //        }
        
        //        positionButton.menu = UIMenu(children:[
        //            UIAction(title: "平社員", state:  .on, handler:optionClouser)
        //            ,
        //            UIAction(title: "主任", state:  .on, handler:optionClouser),
        //            UIAction(title: "課長", state:  .on, handler:optionClouser),
        //            UIAction(title: "部長", state:  .on, handler:optionClouser),
        //            UIAction(title: "次長", state:  .on, handler:optionClouser),
        //            UIAction(title: "代表", state:  .on, handler:optionClouser)
        
        //        ])
        
        
        
        //性別でViewをクリックした時
        let maleGesture = UITapGestureRecognizer(target: self, action:  #selector (self.maleAction (_:)))
        self.maleView.addGestureRecognizer(maleGesture)
        
        let femaleGesture = UITapGestureRecognizer(target: self, action:  #selector (self.femaleAction (_:)))
        self.femaleView.addGestureRecognizer(femaleGesture)
        
    }
    
    //MARK: --Method
    
    //性別で男のViewをクリックしたら
    //①Bool値を男はTrue、女はFalseに
    //②イメージを切り替える
    @objc func maleAction(_ sender:UITapGestureRecognizer){
        maleBool = true
        femaleBool = false
        
        maleImageView.image = maleBool ? selectedCircle : circle
        femaleImageView.image = femaleBool ? selectedCircle : circle
    }
    //性別で女のViewをクリックしたら
    //①Bool値を男はFalse、女はTrueに
    //②イメージを切り替える
    @objc func femaleAction(_ sender:UITapGestureRecognizer){
        maleBool  = false
        femaleBool = true
        
        maleImageView.image = maleBool ? selectedCircle : circle
        femaleImageView.image = femaleBool ? selectedCircle : circle
    }
    
    
    @IBAction func changeSwitch(_ sender: Any) {
        magazineSwitch.isSelected.toggle()
    }
    
    //パスワード（再入力）で目マークを押せば
    //①Passwordが見えるように
    //②イメージ切り替える
    @objc func showRepassword(){
        
        if repasswordTextField.isSecureTextEntry == true{
            repasswordTextField.isSecureTextEntry = false
            
        }else{
            repasswordTextField.isSecureTextEntry=true
        }
        repasswordTextField.becomeFirstResponder()
        repasswordButton.setImage(UIImage(systemName: repasswordTextField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
    }
    //Passwordで目マークを押せば
    //①Passwordが見えるように
    //②イメージ切り替える
    @objc func showPassword(){
        if passwordTextField.isSecureTextEntry == true{
            passwordTextField.isSecureTextEntry = false
            
        }else{
            passwordTextField.isSecureTextEntry=true
        }
        passwordTextField.becomeFirstResponder()
        passwordButton.setImage(UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
    }
    
    //職業で矢印表示
    //MARK: 修正予定
    @objc func makePositionArrow(){
        
    }
    //約款同意をクリックしたら
    //toggle
    @IBAction func checkboxToggle(_ sender: Any) {
        checkboxButton.isSelected.toggle()
        checkboxBool.toggle()
        
        
        checkboxButton.setImage(checkboxButton.isSelected ? checkImage : noneCheckImage, for: .normal)
    }
    
    
    //MARK: keyboard関連
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //memoTextViewをクリックした時のみキーボード位置調節
    //MARK: 修正予定
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //        if !memoTextView.isFirstResponder {
        //            return
        //        }
        //case iphone11ーok
        //se3世代ーメモに一度クリックしたら元のスクロールビューが縮小される
         
         // キーボードのframeを調べる。
         
         //        let keyboardFrame : CGFloat = 0
         self.scrollView.contentSize = CGSize(
         width: self.scrollView.frame.width,
         height: self.innerView.frame.height
         )
         
         if self.memoTextView.isFirstResponder {
         // 一番下に移動
         let y = self.innerView.frame.height - self.scrollView.frame.height + 20
         self.scrollView.contentOffset = CGPoint(x: 0, y: y)
         }
         
        
        
        //case iphoneSE2-メモにクリックしたらクリック中には真下まで行けない
        //iphone11-メモの真下まで行ける
        //        let userInfo = notification.userInfo
        //        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        //                self.scrollView.contentSize = CGSize(
        //                    width: self.scrollView.frame.width,
        //                    height: self.innerView.frame.height
        //                )
        //
        //                if self.memoTextView.isFirstResponder {
        //                    // 一番下に移動
        //                    let y = self.innerView.frame.height - self.scrollView.frame.height + 20 + keyboardFrame
        //                    self.scrollView.contentOffset = CGPoint(x: 0, y: y)
        //                }
        
        let isiPhoneSE = self.view.safeAreaInsets.bottom <= 80
        
        if isiPhoneSE{
            
            let userInfo = notification.userInfo
            let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
            self.scrollView.contentSize = CGSize(
                width: self.scrollView.frame.width,
                height: 750 + keyboardFrame
            )
            
            if self.memoTextView.isFirstResponder {
                // 一番下に移動
                let y = self.innerView.frame.height - self.scrollView.frame.height + 20 + keyboardFrame
                self.scrollView.contentOffset = CGPoint(x: 0, y: y)
            }
        }
    }
    //キーボードが隠す時の挙動
    @objc func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentSize = CGSize(
            width: self.scrollView.frame.width,
            //case iphone11-ok
            //SE3世代ー元のサイズが縮小される
            //            height: self.innerView.frame.height - 200
            
            
            //case se3-元のサイズの戻る
            //iphone11ではスクロールビューが伸びる
            height: 750
        )
        /*if self.view.frame.origin.y != 0 {
         self.view.frame.origin.y = 0
         }*/
        
        //        let userInfo = notification.userInfo
        //        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        //case3 下記コードをなしに
        //        let y = self.innerView.frame.height - self.scrollView.frame.height + 20
        //        self.scrollView.contentOffset = CGPoint(x: 0, y: y)
    }
    
    //キーボードでreturnボタンを押せば次のTextfieldに移動する
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    //MARK: validationとエラーメッセージ
    //MARK: 修正予定
    
    //エラーメッセージを表示
    func errorMessage(message:  String, view : UIView) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let idAlertAction : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            view.becomeFirstResponder()
        })
        
        alert.addAction(idAlertAction)
        self.present(alert, animated: true, completion: nil)
    }
    func idcheck() -> ValidationResult {
        var result : ValidationResult
        if idTextField.text!.isEmpty{
            result = .idEmpty
            return result
        }
        
        let text = idTextField.text!
        
        if text.range(of: "^([\\w\\.\\_\\-])*[a-zA-Z0-9]+([\\w\\.\\_\\-])*([a-zA-Z0-9])+([\\w\\.\\_\\-])+@([a-zA-Z0-9]+\\.)+[a-zA-Z0-9]{2,8}$", options: .regularExpression) == nil{
            result = .idFormat
            return result
        }
        
        result = .idOK
        return result
    }
    func passwordcheck() -> ValidationResult {
        var result : ValidationResult
        
        if passwordTextField.text!.isEmpty{
            result = .passwordEmpty
            return result
        }
        let text = passwordTextField.text!
        
        if text.range(of: "^.*(?=^.{8,15}$)(?=.*[0-9])(?=.*[a-zA-Z]).*$", options: .regularExpression) == nil{
            result = .passwordFormat
            return result
        }
        
        
        let retext = repasswordTextField.text!
        
        if repasswordTextField.text!.isEmpty{
            result = .repasswordEmpty
            return result
        }else if text != retext{
            result = .repasswordMatch
            return result
        }
        result = .passwordOK
        return result
    }
    func idValidation() -> ValidationResult {
        let result  : ValidationResult = idcheck()
        if result == .idEmpty{
            errorMessage(message: "IDを入力してください。", view: self.idTextField)
            
        }else if result == .idFormat{
            errorMessage(message: "IDはメールアドレスです。\nメールアドレスを入力してください。", view: self.idTextField)
        }
        return result
        
    }
    func passwordValidation() -> ValidationResult {
        let result  : ValidationResult = passwordcheck()
        if result == .passwordEmpty{
            errorMessage(message: "パスワードを入力してください。", view: passwordTextField)
        }else if result == .passwordFormat{
            
            errorMessage(message: "パスワードは小文字、大文字、数字を混ぜて８桁以上になります。", view: passwordTextField)
            
        }else if result == .repasswordEmpty{
            
            errorMessage(message: "パスワード(再入力)を入力してください。", view: repasswordTextField)
            
        } else if result == .repasswordMatch{
            
            errorMessage(message: "パスワード(再入力)とパスワードが一致しません。", view: repasswordTextField)
        }
        return result
    }
    func confirmcheckbox() -> Bool{
        if checkboxBool == false{
            errorMessage(message: "約款に同意してください。", view: checkboxButton)
        }
        return checkboxBool
    }
    @IBAction func joinMemberValidation(_ sender: Any) {
        var validationResultBool : Bool = false
        //修正予定
        let idResult : ValidationResult = idValidation()
        let passwordResult : ValidationResult  = passwordValidation()
        let checkboxBool : Bool = confirmcheckbox()
        
        if idResult == .idOK, passwordResult == .passwordOK, checkboxBool{
            validationResultBool = true
        }
        
        if validationResultBool {
            //Validation通過した後、メンバー変数に入れる
            signupMember = SignupMember(id: idTextField.text!, password: passwordTextField.text!, gender: maleBool ? Gender.male : Gender.female, agreement: checkboxButton.isSelected, megazine: magazineSwitch.isSelected, memo: memoTextView.text!, position: positionTextField.text!)
            //ページ移動するため。下のprepareとセット
            self.performSegue(withIdentifier: "joinMemberDetail", sender: nil)
        }else{
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "joinMemberDetail" {
            guard let desti = segue.destination as? JoinMemberDetailView else {
                fatalError("Failed to prepare DetailViewController.")
                
            }
            desti.signupMember = self.signupMember
        }
    }
    
    //職業にpickerviewにキャンセルをクリックしたら
    //①内容を消す
    //②閉じる
    @objc func cancel() {
        self.positionTextField.text! = selectedPickerText.isEmpty ? positionArray[0] : selectedPickerText
        self.positionTextField.endEditing(true)
        //        pickerView.selectRow(selectArrayRow, inComponent: 0, animated: true)
    }
    
    @IBAction func pushPositionTextField(_ sender: Any) {
        var selectedRow : Int
        
        switch selectedPickerText{
        case positionArray[0]:
            selectedRow = 0
        case positionArray[1]:
            selectedRow = 1
        case positionArray[2]:
            selectedRow = 2
        case positionArray[3]:
            selectedRow = 3
        case positionArray[4]:
            selectedRow = 4
        case positionArray[5]:
            selectedRow = 5
        default:
            selectedRow = 0
        }
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    //職業のpickerviewに決定をクリックしたら閉じる
    @objc func done(_ sender : UIBarButtonItem) {
        self.positionTextField.text! =  selectingText
        selectedPickerText = self.positionTextField.text!
        self.positionTextField.endEditing(true)
    }
}

//MARK: -- Delegate, DataSource 関連
extension JoinMemberController : UIPickerViewDelegate,UIPickerViewDataSource , UITextFieldDelegate{
    
    
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positionArray.count
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positionArray[row]
    }
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectingText = positionArray[row]
        selectArrayRow = row
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //このメソッドでやっていること
    //①英語と数字のみもらうように
    //②桁数の制限をしている
    //③positionTextFieldのみキーボード入力をできないように
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currStr = textField.text! as NSString
        let changed = currStr.replacingCharacters(in: range, with: string)
        //        let characterSet = NSMutableCharacterSet.alphanumeric()
        //        characterSet.addCharacters(in: "_@.")
        
        let invalid  : NSCharacterSet = NSCharacterSet(charactersIn:  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-").inverted as NSCharacterSet
        
        let range = string.rangeOfCharacter(from: invalid as CharacterSet)
        
        if textField == positionTextField{
            return false
        }
        else if textField == idTextField{
            if range != nil {
                return false
            }else if changed.count > 64{
                return false
            }
        }else{
            if range != nil {
                return false
            }else if changed.count > 15{
                return false
            }
        }
        return true
    }
    
    
}
//MARK: --enum ValidationResult
enum ValidationResult {
    
    case validationResult
    case idEmpty
    case idFormat
    case passwordEmpty
    case passwordFormat
    case repasswordEmpty
    case repasswordMatch
    case idOK
    case passwordOK
    
}
