# Рядом с бабушкой
def grandma_logic
  puts "Окрававленное тело бабушки. Чем мочил? Не помнишь? Ничего, на следствии всё вспомнишь!" if $grandma_status == ""
  puts "Разрубленное тело бабушки. Что, скотина, не насмотрелся ещё????" if $grandma_status == "разрублена"
  buffer

  variants = []
  variants << "пошарить в карманах" unless $grandma_status == "разрублена"
  variants <<  "разрубить тело бабушки" if $inventory.include? "топор"
  variants <<  "осмотреться"

  choice = puts_variants(variants)

  if choice == 1
    if $inventory.include? "спички"
      puts "Ничего не найдено (:"
    else
      puts "+++ Вы нашли спички"
      $inventory << "спички"
    end

    puts
    grandma_logic
  elsif choice == 2 && $inventory.include?("топор") && $grandma_status != "разрублена"
    puts "Ты разрубил бездыханное тело бабушки на части."
    buffer
    puts "Какая же ты сволочь всё таки!!!"
    $grandma_status = "разрублена"
    buffer

    main_process if get_answer?
  else
    main_process
  end
end
