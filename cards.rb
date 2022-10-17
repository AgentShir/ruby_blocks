cards = ["Jack", "Queen", "King", "Ace", "Joker"]
cards.each { |card| puts "#{card.upcase} - #{card.length}" }

scores = {"Larry" => 10, "Moe" => 8, "Curly" => 12}
scores.each { |name, score| puts "#{name} scored a #{score}!" }