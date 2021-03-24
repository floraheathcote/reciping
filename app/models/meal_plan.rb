class MealPlan < ApplicationRecord
  belongs_to :user
 
  has_many :days, dependent: :destroy
  has_many :meals, through: :days
  has_many :shopping_list_items, dependent: :destroy

  attr_accessor :start_date_from_form
  attr_accessor :number_of_days_from_form
  
  def start_date
    self.days.order(:date).first.date
  end

  def number_of_days
    self.days.count
  end

  # def all_meal_ingredients
  #   @all_meal_ingredients ||= []
  #   self.days.each do |day|
  #     day.meals.each do |meal|
  #       meal.meal_ingredients.each do |meal_ingredient|
          
  #         @all_meal_ingredients << meal_ingredient
  #       end
  #     end
  #   end
  #   return @all_meal_ingredients
  # end


  def all_meal_plan_ingredients
        MealPlan
        .joins(   " INNER JOIN days on meal_plans.id=days.meal_plan_id AND meal_plans.id='#{self.id}'
                    INNER JOIN meals on days.id=meals.day_id
                    INNER JOIN meal_ingredients on meals.id=meal_ingredients.meal_id
                    INNER JOIN ingredients on meal_ingredients.ingredient_id=ingredients.id
                    INNER JOIN ingredient_categories on ingredients.ingredient_category_id = ingredient_categories.id")
        .select(  " meal_plans.id, 
                    ingredient_categories.name AS cat_name,
                    ingredients.name AS ing_name,
                    SUM(meal_ingredients.quantity),
                    meal_ingredients.unit")
        .group(     'meal_ingredients.ingredient_id, meal_plans.id, meal_ingredients.unit, ingredients.name, ingredient_categories.id')
        .order(     'cat_name ASC, ing_name ASC')
        # .where(     "meal_plans.id = '#{self.id}'")
  end

end

