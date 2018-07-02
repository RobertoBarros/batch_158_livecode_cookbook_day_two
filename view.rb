class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "-" * 50
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{done} #{index + 1}: #{recipe.name}"
      puts recipe.description
      puts "Preparation Time: #{recipe.prep_time} minutes" unless recipe.prep_time == '0'
      puts "Difficulty: #{recipe.difficulty}" unless recipe.difficulty.nil?
    end
    puts "-" * 50
  end

  def display_imports(results)
    puts "Choose the recipe to import:"
    results.each_with_index do |result, index|
      puts "#{index + 1} - #{result[:name]}"
    end
  end

  def ask_ingredient
    puts "What's the ingredient of the recipe?"
    gets.chomp
  end

  def ask_recipe_name
    puts "What's the recipe name?"
    gets.chomp
  end

  def ask_recipe_description
    puts "What's the description?"
    gets.chomp
  end

  def ask_prep_time
    puts "Preparation Time (in minutes):"
    gets.chomp.to_i
  end

  def ask_recipe_instructions
    puts "What's the instructions?"
    gets.chomp
  end

  def ask_recipe_index
    puts "Index?"
    gets.chomp.to_i - 1
  end

end