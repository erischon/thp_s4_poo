class Player
  
  # Getters et Setters
  attr_accessor :name
  attr_accessor :life_points

  # Initialize
  def initialize(name)
    @name = name
    @life_points = 10
  end

  # Affiche l'état du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie."
  end

  # Méthode pour infliger des dommages au joueur
  def get_damages(damages)
    @life_points -= damages
    @life_points = 0 if @life_points < 0

    if @life_points == 0
      puts "Le joueur #{@name} a été tué !"
    end
  end

  # Méthode pour attaquer une cible
  def attack(target)
    puts "Le joueur #{@name} attaque le joueur #{target.name}"
    damages = compute_damage
    puts "Il lui inflige #{damages} points de dommages"
    target.get_damages(damages)
  end

  # Méthode pour obtenir le nombre de dégâts
  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player

  # Getters et Setters
  attr_accessor :weapon_lvl

  # Initialize
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_lvl = 1
  end

  # Affiche l'état du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_lvl}."
  end

  def compute_damage
    rand(1..6) * @weapon_lvl
  end

  def search_weapon
    new_weapon_lvl = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_lvl}."

    if new_weapon_lvl > @weapon_lvl
      @weapon_lvl = new_weapon_lvl
      puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    result_shp = rand(1..6)

    if result_shp == 1
      puts "Tu n'as rien trouvé... "
    elsif result_shp <= 5
      @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points += 80
      puts "Bravo, tu as trouvé un pack de +80 points de vie !"
    end

    @life_points = 100 if @life_points > 100
  end

end

