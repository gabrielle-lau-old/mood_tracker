//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Jeffrey on 8/4/2019.
//  Copyright © 2019 gabrielle. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons=[UIButton]()
    var rating=0{
        // Property observer that calls the function below whenever the rating changes
        didSet{
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize=CGSize(width:44.0,height: 44.0){
        // Property observer
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int=5{
        // Property observer
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    @objc func ratingButtonTapped(button:UIButton){
            guard let index = ratingButtons.firstIndex(of:button) else {
                fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
            }
            
            // Calculate the rating of the selected button
            let selectedRating=index+1
            
            if selectedRating==rating{
                // If the selected star represents the current rating, reset the rating to 0, ie. unselect the star.
                rating=0
            } else {
                // Otherwise set the rating to the selected star
                rating=selectedRating
            }
    }
    
    // MARK: Private Methods
    private func setupButtons(){
        
        // Clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load button images
        let bundle = Bundle(for: type(of: self))
        let filledStar=UIImage(named: "filledStar",in:bundle,compatibleWith: self.traitCollection)
        let emptyStar=UIImage(named: "emptyStar",in:bundle,compatibleWith: self.traitCollection)
        let highlightedStar=UIImage(named: "highlightedStar",in:bundle,compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount{
            // Create the button
            let button = UIButton()
            
            // Set button images
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .normal)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted,.selected])
            
            // Constraints
            button.translatesAutoresizingMaskIntoConstraints=false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
            
            // Set up button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add button to stack
            addArrangedSubview(button)
            
            // Add new button to rating buttons array
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates(){
        for (index,button) in ratingButtons.enumerated(){
            // If index of a button is less than the rating, that button should be selected
            button.isSelected=index<rating
        }
    }
}



