scores = [83, 71, 92, 64, 98, 87, 75, 69]

high_scores = scores.select { |score| score > 80 }
p high_scores

low_scores = scores.reject { |score| score > 80 }
p low_scores

puts scores.any? { |score| score < 70 }
puts scores.detect { |score| score < 70 }

scores_doubled = scores.map { |score| score * 2 }
p scores_doubled

total = scores.reduce(0) { |sum, score| sum + score }
puts "Total score: #{total}"

evens, odds = scores.partition { |score| score.even? }
puts "Evens:"
p evens
puts "Odds:"
p odds