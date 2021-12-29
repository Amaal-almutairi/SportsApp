//
//  ViewController.swift
//  SportsApp
//
//  Created by Amaal almutairi on 29/12/2021.
//

import UIKit

import CoreData


protocol ShowImageDelegate {
    func showImage(imageName:String?)
}

class SportsVC: UIViewController,UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
     //  var delegate: ShowImageDelegate?
       
       
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
    
    //Se4  delegate?.showImage(imageName: imageName)
        
        dismiss(animated: true)
    }
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var sportList = [SportEntity]()
    var indexPath:Int?
    
//AddSportID
    @IBOutlet weak var tabelview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelview.delegate = self
        tabelview.dataSource = self
        fetchData()
        // Do any additional setup after loading the view.
        
      
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("my button is \(sender.tag)")
        indexPath = sender.tag
    }
    
    func produceImage(imageName: String?) {
           sportList[indexPath!].image = imageName
          save()
        tabelview.reloadData()
        
    }
    func addImage(cell: SportsCustomCell) {
           let picker = UIImagePickerController()
           picker.allowsEditing = true
           picker.delegate = self
           present(picker, animated: true)
       }
       
    @IBAction func addSportsListAction(_ sender: UIBarButtonItem) {
        addAlert()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gonext", sender: sportList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navegation = segue.destination as? UINavigationController
        _ = navegation?.topViewController as? PlayerVC
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelview.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportsCustomCell
       
       // cell.textLabel?.text = sportList[indexPath.row].image
        cell.imagebutton.tag = indexPath.row
        cell.textLabel?.text = sportList[indexPath.row].name
    
       
        if let image = sportList[indexPath.row].image {
            print("image found at \(indexPath.row)")
                   DispatchQueue.main.async {
                       let path = self.getDocumentsDirectory().appendingPathComponent(image)
                       let newImage = UIImage(contentsOfFile: path.path)
                       cell.imagebutton.setImage(newImage, for: .normal)
                       cell.imagebutton.setTitle("", for: .normal)
                       cell.imagebutton.imageView?.contentMode = .scaleAspectFit
                   }
            
        
       
    }
       
        return cell
    }
    func addAlert(){
        
        let addAlert = UIAlertController(title: "New Sport", message: "Add a new sport", preferredStyle: .alert)
        addAlert.addTextField(configurationHandler: nil)
                       let sport =  addAlert.textFields![0]
                        sport.placeholder = "Enter a sport"
               
                let saveAlert = UIAlertAction(title: "Save", style: .default) {  _ in
                    let textField = addAlert.textFields![0]
                    let newSportEntry = SportEntity(context: self.context)
                   newSportEntry.name = textField.text!
                    self.save()
                }
                
                
                let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        addAlert.addAction(saveAlert)
        addAlert.addAction(cancelAlert)
                
                present(addAlert, animated: true, completion: nil)
    
}
     func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
      
        let alert = UIAlertController(title: "Edit Sport",
                                              message: "Edit Sport",
                                              preferredStyle: .alert)
                
                alert.addTextField(configurationHandler: nil)
                
         alert.textFields![0].text = sportList[indexPath.row].name
                
                let saveAction = UIAlertAction(title: "Save", style: .default)
                {
                    _ in
                    let textField = alert.textFields![0]
                    self.sportList[indexPath.row].name = textField.text
                   self.save()
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
         
    }
    
    
    func save(){
        
        do{
            
            try context.save()
            
        } catch let error
                    
        {
            print(error.localizedDescription)
            
        }
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sports = sportList[indexPath.row]
        context.delete(sports)
        sportList.remove(at: indexPath.row)
       
        tableView.reloadData()
   
}
    func fetchData(){
        
        let req = NSFetchRequest<SportEntity>.init(entityName: "SportEntity")
        do {
                     sportList = try context.fetch(req)
                    print("Success")
                } catch {
                    print("Error: \(error)")
                }
        tabelview.reloadData()
        
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
