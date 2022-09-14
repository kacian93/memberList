//
//  JoinMember.swift
//  GngMember
//
//  Created by PC156 on 2022/09/05.
//

import Foundation
import UIKit
class JoinMemberController : UIViewController{
    
    var signupMember : SignupMember = SignupMember()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var scrollView: UIScrollView!
    var member : Member = Member(emloyeeNumber: "", kanjiName: "", kanaName: "", englishName: "", position: "", affiliation: "", email: "", tel: "", dateOfEmployee: Date.now)
    
    @IBOutlet var positionLabel: UILabel!
    //入力もらうtextField
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repasswordTextField: UITextField!
    
    
    @IBOutlet var magazineSwitch: UISwitch!
    @IBOutlet var positionTextField: UITextField!
    
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
    
    
    let noneCheckImage = UIImage(systemName: "square")
    let checkImage = UIImage(systemName: "checkmark.square.fill")
    
    let circle = UIImage(systemName: "circle")
    let selectedCircle = UIImage(systemName:  "smallcircle.filled.circle")
    
    var positionArray = ["平社員","主任","課長","部長","次長","代表"]
    
    @IBOutlet var joinMemberButton: UIButton!
    
    //validation
    var validationResultBool : Bool = false
    var idBool : Bool = false
    var idFormatBool : Bool = false
    var passwordBool : Bool = false
    var passwordFormatBool : Bool = false
    var repasswordBool : Bool = false
    var repasswordMatchBool : Bool  = false
    
    
    let defaultAction : UIAlertAction = UIAlertAction(title: "直す", style: UIAlertAction.Style.default)
    var alert : UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        
        
        scrollView.contentSize = view.frame.size
        scrollView.flashScrollIndicators()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 850)
        
        maleButton.isSelected = true
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
        checkboxButton.isSelected = true
        checkboxButton.setImage(checkboxButton.isSelected ? checkImage : noneCheckImage, for: .normal)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(JoinMemberController.done))
        let cancelItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(JoinMemberController.cancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        toolbar.setItems([cancelItem,flexibleSpace,doneItem], animated: true)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        magazineSwitch.isSelected = true
        
        self.positionTextField.inputView = pickerView
        self.positionTextField.inputAccessoryView = toolbar
        
        //cursor 
        positionTextField.tintColor = UIColor.clear
        
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
        
        
        
        idTextField.becomeFirstResponder()
        self.positionTextField.text = positionArray[0]
        
        //男のlabelをクリックした時、作動するため
        let tap = UIGestureRecognizer(target: self, action: #selector(JoinMemberController.pushMaleLabel))
        maleLabel.isUserInteractionEnabled = true
        maleLabel.addGestureRecognizer(tap)
        
        
        
        let femaleTap = UIGestureRecognizer(target: self, action: #selector(JoinMemberController.pushFemalLabel))
        maleLabel.isUserInteractionEnabled = true
        maleLabel.addGestureRecognizer(femaleTap)
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
        
        
        
    }
    
    @IBAction func changeSwitch(_ sender: Any) {
        magazineSwitch.isSelected.toggle()
    }
    
    @objc func positionArrow(){
        
    }
    @objc func pushMaleLabel(_ sender : UITapGestureRecognizer){
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
    }
    @objc func pushFemalLabel(_ sender : UITapGestureRecognizer){
        maleButton.isSelected = false
        femaleButton.isSelected = true
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
    }
    //約款同意
    @IBAction func checkboxToggle(_ sender: UIButton) {
        checkboxButton.isSelected.toggle()
        checkboxBool.toggle()
        
        
        checkboxButton.setImage(checkboxButton.isSelected ? checkImage : noneCheckImage, for: .normal)
    }
    @IBAction func pushmaleButton(_ sender: UIButton) {
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
        
    }
    @IBAction func pushFemaleButton(_ sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = true
        maleButton.setImage(maleButton.isSelected ? selectedCircle : circle, for: .normal)
        femaleButton.setImage(femaleButton.isSelected ? selectedCircle : circle, for: .normal)
        
    }
    
    @objc func cancel() {
        self.positionTextField.text = ""
        self.positionTextField.endEditing(true)
    }
    
    @objc func done(_ sender : UIBarButtonItem) {
        sender.title = "決定"
        self.positionTextField.endEditing(true)
    }
    //keyboard関連
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if !memoTextView.isFirstResponder {
            return
        }
        
        if self.view.frame.origin.y == 0 {
            if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardRect.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    //validationとエラーメッセージ
    func idcheck() {
        
        if idTextField.text!.isEmpty, idTextField.text! == ""{
            idBool = false
            return
        }else{
            idBool = true
        }
        
        let text = idTextField.text!
        
        if text.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z]+.[A-Za-z]", options: .regularExpression) == nil{
            idFormatBool = false
            return
        }
        
        idFormatBool = true
    }
    func passwordcheck() {
        
        if passwordTextField.text!.isEmpty, passwordTextField.text! == ""{
            passwordBool = false
            return
        }
        let text = passwordTextField.text!
        passwordBool = true
        
        if text.range(of: "^.*(?=^.{8,15}$)(?=.*[0-9])(?=.*[a-zA-Z]).*$", options: .regularExpression) == nil{
            passwordFormatBool = false
            return
        }
        
        passwordFormatBool = true
        
        let retext = repasswordTextField.text!
        
        if repasswordTextField.text!.isEmpty{
            repasswordBool = false
            return
        }else if text != retext{
            repasswordBool = true
            repasswordMatchBool = false
            return
        }
        repasswordBool = true
        repasswordMatchBool = true
    }
    func idValidation() -> Bool {
        var result  : Bool = false
        if idBool == false{
            alert = UIAlertController(title: "idを入力してください。", message: "IDが空いております。\n 入力してください。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }else if idFormatBool == false{
            
            alert = UIAlertController(title: "メールアドレスを入力してください。", message: "IDはメールアドレスです。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }else{
            result = true
        }
        return result
    }
    func positionCheck() -> Bool {
        var result : Bool = false
        if positionTextField.text!.isEmpty, positionTextField.text! == ""{
            result = false
        }else{
            result = true
        }
        return result
    }
    func positionValidation() -> Bool {
        var result : Bool = false
        if positionCheck() == false{
            alert = UIAlertController(title: "職業を選択してください。", message: "職業を選択してください。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }
        else{
            result = true
        }
        return result
    }
    func passwordValidation() -> Bool {
        var result  : Bool = false
        if passwordBool == false{
            alert = UIAlertController(title: "パスワードを入力してください。", message: "パスワードが空いております。\n 入力してください。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }else if passwordFormatBool == false{
            
            alert = UIAlertController(title: "パスワードは小文字、大文字、数字を混ぜて８桁以上になります。", message: "パスワードは小文字、大文字、数字を混ぜて８桁以上になります。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }else if repasswordBool == false{
            alert = UIAlertController(title: "パスワード(再入力)が空いていおります。", message: "パスワード(再入力)を入力してください。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
            
        } else if repasswordMatchBool == false{
            alert = UIAlertController(title: "パスワード(再入力)とパスワードが合いません。", message: "パスワード(再入力)とパスワードが合いません。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }else if checkboxBool == false{
            
            alert = UIAlertController(title: "約款に同意してください。", message: "約款に同意してください。", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            result = false
        }
        else{
            result = true
        }
        return result
    }
    
    @IBAction func joinMemberValidation(_ sender: Any) {
        idcheck()
        passwordcheck()
        
        
        let idResult : Bool = idValidation()
        let passwordResult : Bool  = passwordValidation()
        let positionResult : Bool = positionValidation()
        if idResult, passwordResult, checkboxBool , positionResult{
            validationResultBool = true
        }
        signupMember = SignupMember(id: idTextField.text!, password: passwordTextField.text!, gender: maleButton.isSelected ? Gender.male : Gender.female, agreement: checkboxButton.isSelected, megazine: magazineSwitch.isSelected, memo: memoTextView.text!, position: positionTextField.text!)
        
        if validationResultBool {
            self.performSegue(withIdentifier: "joinMemberDetail", sender: self.signupMember)
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
}


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
        self.positionTextField.text = positionArray[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //positionTextFieldのみキーボード入力をできないように
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == positionTextField{
            return false
        }
        return true
    }
}
