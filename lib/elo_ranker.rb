require_relative 'elo_system'
require_relative 'item'
require_relative 'display'
require 'csv'

class EloRanker
  include Display

  attr_accessor :elo, :current_file_path, :items

  def initialize
    @elo = EloSystem.new
    @items = []
  end

  def run
    path = choose_data_file
    load_data_file(path)
    program_flow
  end

  def program_flow
    loop do
      print_program_flow_prompt

      input = get_operation_input
      case input
      when 'add' then add_new_item
      when 'comp' then random_comparisons
      when 'view' then view_ratings
      when 'exit' then exit_program
      end

      save
    end
  end

  def add_new_item
    print_item_name_prompt
    item = Item.new(gets.chomp)
    @items.push(item)
    do_multiple_comparisons(@items.length / 2 , item)
  end

  def random_comparisons
    print_how_many_comp(@items.length)
    n = get_number_input(1, @items.length)
    do_multiple_comparisons(n)
  end

  def do_multiple_comparisons(no_of_times, item = nil)
    no_of_times.times do
      @items.shuffle!
      if item.nil?
        comparison()
      else
        comparison(item)
      end
    end
  end

  def comparison(item_a = @items.sample, item_b = @items.sample)
    item_b = @items.sample while item_a == item_b
      
    print_items(item_a, item_b)
    winner = get_number_input(0, 1)

    @elo.adjust_rating(item_a, item_b, winner)
  end

  def view_ratings
    @items.sort! { |a, b| b.rating <=> a.rating}
    @items.each_with_index { |item, i| puts "(#{i + 1}) #{item.to_s}" }
  end

  def exit_program
    print_exit_msg
    exit(0)
  end

  def get_number_input(min, max)
    loop do
      input = gets.chomp
      return input.to_i if input.match?(/^\d+$/) && input.to_i.between?(min, max)

      print_incorrect_input_msg
    end
  end

  def get_operation_input
    loop do
      input = gets.chomp
      return input if ['add', 'comp', 'view', 'exit'].include?(input)

      print_incorrect_input_msg
    end
  end

  def load_data_file(path)
    @current_file_path = path
    CSV.open(path, headers: true, header_converters: :symbol) do |file|
      file.each { |item| @items.push(Item.new(item[:name], item[:rating].to_i)) }
    end

    print_file_loaded_success
  end

  def choose_data_file
    print_file_prompt
    paths = []
    CSV.open('saved_data/files_list.csv', headers: true, header_converters: :symbol) do |file|
      file.each_with_index do |row, i|
        puts "(#{i}) #{row[:category]}"
        paths[i] = row[:file_path]
      end
    end
    
    choice = get_file_choice(paths.length)
    paths[choice]
  end

  def get_file_choice(num_of_options)
    loop do
      input = gets.chomp
      return input.to_i if input.match?(/^\d+$/) && input.to_i.between?(0, num_of_options - 1)

      print_incorrect_input_msg
    end
  end

  def save
    @items.sort! { |a, b| b.rating <=> a.rating}

    CSV.open(@current_file_path, "w") do |csv|
      csv << ['name', 'rating']
      @items.each do |item|
        csv << [item.name, item.rating]
      end
    end
  end

end

e = EloRanker.new
e.run