require 'open-uri'
require 'nokogiri'

require_relative 'view'
require_relative 'recipe'
require_relative 'scrapper'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_all_recipes
  end

  def create
    # ask recipe name
    name = @view.ask_recipe_name
    # ask recipe description
    description = @view.ask_recipe_description
    # Instanciate a new recipe
    recipe = Recipe.new(name, description)
    #ask user the prep time
    recipe.prep_time = @view.ask_prep_time
    # Add the recipe to cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # list all recipes
    display_all_recipes
    # ask recipe index
    index = @view.ask_recipe_index
    # cookbook remove recipe
    @cookbook.remove_recipe(index)
  end

  def mark_as_done
    # list all recipes
    display_all_recipes
    # ask index
    index = @view.ask_recipe_index
    # find recipe in cookbook
    recipe = @cookbook.find(index)
    # mark as done
    recipe.mark_as_done!
    # save cookbook to CSV
    @cookbook.save_csv
  end

  def import
    # ask ingredient
    ingredient = @view.ask_ingredient
    # scrapper of recipes name and href
    results = Scrapper.list_recipes_by_ingredient(ingredient)
    # show recipes names
    @view.display_imports(results)
    # ask recipe index to import
    index = @view.ask_recipe_index
    # get the recipe url
    url = results[index][:href]
    # get the recipe imported
    recipe = Scrapper.import_by_url(url)
    # add the recipe to cookbook
    @cookbook.add_recipe(recipe)

  end

  private

  def display_all_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end


end