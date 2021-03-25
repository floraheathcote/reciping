class Meal < ApplicationRecord
  belongs_to :day
  has_many :meal_ingredients, dependent: :destroy
  has_many :meal_recipes, dependent: :destroy


  validates :meal_type, presence: true

  
  

  MEALTYPES = ["breakfast", "lunch", "evening meal", "snack", "substantial snack", "extra meal"]
  validates :meal_type, inclusion: { in: MEALTYPES, message: "must be between 1 and 5" }

  def collection_select_nice_data
    "#{name} | #{quantity} | #{unit}"
  end

  def all_meal_ingredients
    self.meal_ingredients
  end


end
