class Recipe
  attr_reader :name, :description
  attr_accessor :prep_time, :difficulty

  def initialize(name, description)
    @name = name
    @description = description
    @prep_time = ""
    @difficulty = ""
    @done = false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end