require 'timeout'

Timeout.timeout(2.0) do
  sleep 1.0
  puts "That was refreshing..."
end

Timeout.timeout(2.0) do
  sleep 3.0
  puts "That was refreshing..."
end


def try_with_timeout(timeout_duration)
  begin
    Timeout.timeout(timeout_duration) do
      yield
    end
  rescue Timeout::Error
    puts "Took too long!"
  end
end

try_with_timeout(2.0) do
  sleep 1.0
  puts "That was refreshing..."
end

try_with_timeout(2.0) do
  sleep 3.0
  puts "That was refreshing..."
end

require 'open-uri'
web_page = try_with_timeout(1.0) do
  open("http://example.com/")
end

puts web_page.read
