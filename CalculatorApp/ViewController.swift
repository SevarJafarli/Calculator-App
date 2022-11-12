import UIKit

class ViewController: UIViewController
{

	@IBOutlet weak var calculatorWorkings: UILabel!
	@IBOutlet weak var calculatorResults: UILabel!
	
	var workings:String = ""
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		clearAll()
	}
	
	func clearAll() -> Void{
		workings = ""
		calculatorWorkings.text = ""
		calculatorResults.text = ""
	}

	@IBAction func equalsTap(_ sender: Any)
	{
        if(validInput())
        {
                let expression = NSExpression(format: workings)
                let result = expression.expressionValue(with: nil, context: nil) as! Double
                let resultString = formatResult(result: result)
                calculatorResults.text = resultString
                }
                else
                {
                    let alert = UIAlertController(
                        title: "Invalid Input",
                        message: "Wrong type of input",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
		
		
		
	}
    
    
	
	func formatResult(result: Double) -> String
	{
		if(result.truncatingRemainder(dividingBy: 1) == 0)
		{
			return String(format: "%.0f", result)
		}
		else
		{
			return String(format: "%.2f", result)
		}
	}
    
    func validInput() ->Bool
        {
            var count = 0
            var funcCharIndexes = [Int]()
            
            for char in workings
            {
                if(specialCharacter(char: char))
                {
                    funcCharIndexes.append(count)
                }
                count += 1
            }
            
            var previous: Int = -1
            
            for index in funcCharIndexes
            {
                if(index == 0)
                {
                    return false
                }
                
                if(index == workings.count - 1)
                {
                    return false
                }
                
                if (previous != -1)
                {
                    if(index - previous == 1)
                    {
                        return false
                    }
                }
                previous = index
            }
            
            return true
        }
    func specialCharacter (char: Character) -> Bool
        {
           
            if(char == "+")
            {
                return true
            }
            return false
        }
        
	
	@IBAction func allClearTap(_ sender: Any)
	{
		clearAll()
	}
	
	@IBAction func backTap(_ sender: Any)
	{
		if(!workings.isEmpty)
		{
			workings.removeLast()
			calculatorWorkings.text = workings
		}
	}
	
	func addToWorkings(value: String)
	{
		workings += value
		calculatorWorkings.text = workings
	}
	
	
	
	@IBAction func plusTap(_ sender: Any)
	{
		addToWorkings(value: "+")
	}
	
	@IBAction func decimalTap(_ sender: Any)
	{
		addToWorkings(value: ".")
	}
	
	
    
    @IBAction func numberTap(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            addToWorkings(value: number)
        }
       
    }
    
	
}

