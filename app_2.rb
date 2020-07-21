#require 'bundler'
#Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

# On demande le pseudo du joueur
puts "Quel est ton pseudo ?"
print "> "
pseudo = gets.chomp

# On créer le joueur
humanplayer = HumanPlayer.new(pseudo)

# On créer les ennemis
mobs = []
mobs.push(Player.new("Josianne"))
mobs.push(Player.new("José"))



# Boucle principale du jeu
loop do
  # On met fin au jeu si le joueur est mort
  if humanplayer.life_points <= 0
    break
  end

  # Afficher l'état du joueur
  humanplayer.show_state

  # Affichage du menu
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts ""
  
  
  puts "attaquer un joueur en vue :"
  mobs.each_with_index do |mob, index|
    puts "#{index} - #{mob.name} a #{mob.life_points} points de vie"
  end
  puts ""

  print "> "
  player_choice = gets.chomp

  if player_choice == "a"
    humanplayer.search_weapon
  elsif player_choice == "s"
    humanplayer.search_health_pack
  elsif player_choice.to_i < mobs.length
    humanplayer.attack(mobs[player_choice.to_i])
    mobs.delete_if { |mob| mob.life_points <= 0 }
  end

  # On met fin au jeu si tous les mobs sont mort
  if mobs.length == 0
    break
  end

  puts "Les autres joueurs t'attaquent !"

  mobs.each do |mob|
    mob.attack(humanplayer) if mob.life_points > 0
  end

end

puts "La partie est finie"

if humanplayer.life_points > 0 
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end