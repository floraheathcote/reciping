class Recipe < ApplicationRecord
    has_many :recipe_ingredient_groups, dependent: :destroy
    has_many :recipe_ingredients, through: :recipe_ingredient_groups
    has_many :ingredients, through: :recipe_ingredients
    has_many :meal_recipes, dependent: :destroy

    belongs_to :user

    has_one_attached :main_image
    before_save do 
        self.name = name.capitalize
      end
end
