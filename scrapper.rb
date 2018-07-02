class Scrapper

  def self.list_recipes_by_ingredient(ingredient)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    doc = Nokogiri::HTML(open(url).read)

    results = []
    doc.search('.m_titre_resultat a').each do |result|
      name = result.text
      href = "http://www.letscookfrench.com" + result.attributes['href'].value
      results << {name: name, href: href}
    end
    return results.first(5)
  end

  def self.import_by_url(url)
    doc = Nokogiri::HTML(open(url).read)
    name = doc.search('h1').text.strip
    description = doc.search('.m_content_recette_todo').text.split.join(' ')
    prep_time = doc.search('.preptime').text.strip
    difficulty_text = doc.search('.m_content_recette_breadcrumb').text.strip
    difficulty = ['Very easy', 'Easy', 'Moderate', 'Difficult'].select {|d| difficulty_text.include?(d) }[0]

    recipe = Recipe.new(name, description)
    recipe.prep_time = prep_time
    recipe.difficulty = difficulty

    return recipe
  end

end