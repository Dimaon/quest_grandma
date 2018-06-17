# На улице
def street_logic
  puts "Двор как двор. Есть скотина в хлеве, недалеко от амбара."
  buffer

  variants = [
      "зайти в хлев",
      "подойти к амбару",
      "зайти в дом"
  ]
  choice = puts_variants(variants)

  if choice == 1
    puts "В хлеве скотина."
    street_logic if get_answer?("1. Выйти во двор")
  end

  if choice == 2
    puts "Амбар заперт на замок."
    if $inventory.include? "ключ"
      variants = ["открыть замок ключом", "выйти во двор"]
      choice = puts_variants(variants)

      if choice == 1
        puts "Ты зашел в амбар. В амбаре старый культиватор."
        buffer

        variants = ["поискать топор", "закрыть амбар и выйти во двор"]
        choice = puts_variants(variants)

        if choice == 1
          puts "+++ Ты нашел топор."
          $inventory << "топор"
          buffer

          street_logic if get_answer?("1. закрыть амбар и выйти во двор")
        else
          street_logic
        end
      else
        street_logic
      end
    else
      street_logic if get_answer?("1. выйти во двор")
    end
  else
    main_process
  end
end