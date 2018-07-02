require 'csv'

class Cookbook
  def initialize(file_path)
    @file_path = file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def save_csv
    CSV.open(@file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        name = recipe.name
        description = recipe.description
        prep_time = recipe.prep_time
        difficulty = recipe.difficulty
        done = recipe.done? ? 'done' : 'not done'
        csv << [name, description, prep_time, difficulty, done]
      end
    end
  end



  private

  def load_csv
    CSV.foreach(@file_path) do |row|
      name = row[0]
      description = row[1]
      recipe = Recipe.new(name, description)
      recipe.prep_time = row[2]
      recipe.difficulty = row[3]
      recipe.mark_as_done! if row[4] == 'done'
      @recipes << recipe
    end
  end

end