import UIKit
import CommonModels

public protocol CharacterDetailsInterface {
     func makeCharacterDetailsModule(charater: Character,navigationController: UINavigationController?) -> UIViewController
}
