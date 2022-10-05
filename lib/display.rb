module Display
  def print_program_flow_prompt
    puts <<~TEXT
    What do you want to do?
      "add" -> Add a new item to the list
      "comp" -> Do comparisons to improve ratings
      "view" -> View items in decreasing Elo rating
      "exit" -> Exit safely
    TEXT
  end

  def print_items(item_a, item_b)
    puts <<~TEXT
    Which is better?
      (0) #{item_b.to_s}
      (1) #{item_a.to_s}
    TEXT
  end

  def print_item_name_prompt
    puts 'What is the name of the item?'
  end

  def print_how_many_comp(max)
    puts "How many comaprisons do you want to do? (1 to #{max})"
  end

  def print_file_prompt
    puts 'Which file do you want to to load? (type the number)'
  end

  def print_incorrect_input_msg
    puts 'Incorrect Input! Please Enter a correct option'
  end

  def print_file_loaded_success
    puts 'File loaded successfully!'
  end

  def print_exit_msg
    puts 'Program exited successfully'
  end
end