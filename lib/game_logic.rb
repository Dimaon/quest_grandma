# Подключаем логику сцены с печкой. Она сложная поэтому в отдельном файле
require_relative 'stove'

# Основной процесс игры, из него мы попадаем в другую игровую зону
# и возвращаемся, когда делаем выбор "осмотреться"
def main_process
  end_game if TIME_END <= Time.now

  puts_main_choices

  case $choice
  when 1
    stove_logic
  when 2
    table_logic
  when 3
    servant_logic
  when 4
    grandma_logic
  when 5
    street_logic
  else
    main_process
  end
end

# Закрыть окно
def close_window
  variants = ["Закрыть окно", "Осмотреться"]

  choice = puts_variants(variants)
  buffer(0)
  if choice == 1
    puts $window_status = "Окно закрыто"
    buffer
    open_window
  else
    main_process
  end
end

# Открыть окно
def open_window
  variants = ["Открыть окно", "Осмотреться"]
  choice = puts_variants(variants)
  buffer(0)

  if choice == 1
    puts $window_status = "Окно открыто"
    buffer()
    close_window
  else
    main_process
  end
end

# Рядом со столом
def table_logic
  puts "Обычное окно и рядом стол. На нем ваза цветов. Тебе они могут понадобиться на похороны."
  close_window
end

# Рядом с сервантом
def servant_logic
  puts "В серванте стоит хрусталь и фарфоровые орлы и куча другой посуды.
Из этих бокалов бабушка хотела угощать тебя вином на твой день рождения. А ты сволочь убил её."

  puts "Но не будем об этом. Как говорится, кто прошлое помянет, тому глаз вон!"

  puts "На шее орла ключик на веревочке." unless $inventory.include? "ключ"

  buffer

  variants = ["засунуть бабушку в сервант"]
  variants << "взять ключик" unless $inventory.include? "ключ"
  variants << "осмотреться"
  choice = puts_variants(variants)

  if choice == 1
    puts "Где ты видел такую миниатюрную бабушку? Она не лезет в сервант."
    buffer
    servant_logic
  elsif choice == 2 && !$inventory.include?("ключ")
    puts "+++ Ты взял немного поржавевший ключ. Интересно от чего он?"
    $inventory << "ключ"
    buffer
    servant_logic
  else
    main_process
  end
end

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
    buffer

    street_logic if get_answer?("1. Выйти во двор")
  end

  if choice == 2
    puts "Амбар заперт на замок."
    buffer

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

# Конец игры
def end_game
  puts "Пришел дедушка..."
  if $stove_status.include? "бабушка в печке" && $stove_status.include?("горит")
    puts "И спрашивает вас: 'Где бабушка внучок!?'"
    puts

    variants = [
      "Ушла к соседке",
      "Порубил я её дед и в печку засунул! Вон смотри как топит хорошо))) Ха-ха-ха! **злобный смех**"
    ]
    choice = puts_variants(variants)
    buffer

    if choice == 1
      puts "Дед ничего не понял..."
      buffer
      puts "...но потом сообщил что ел странную отбивную на ужин)))"
      puts "...конец истории"
    else
      puts "Дед ударил тебя лопатой по голове и вызвал полицию. Так тебе и надо скотина!!!"
      puts "...конец истории"
    end
  end

  # TODO Сделать логику когда окно закрыто и сильно воняет из печки

  if $grandma_status == "разрублена" && !$stove_status.include?("бабушка в печке")
    puts "Дед увидел разрубленное тело бабушки....."
    sleep 1
    puts "Схватил лопату и резко ударил тебя по голове, а затем вызвал полицию. Так тебе и надо скотина!!!"
    puts "...конец истории"

  elsif $grandma_status == "разрублена" && $stove_status.include?("бабушка в печке") && !$stove_status.include?("горит")
    puts "Дед увидел торчащую ногу бабушки из печки....."
    sleep 1
    puts "Схватил лопату и резко ударил тебя по голове, а затем вызвал полицию. Так тебе и надо скотина!!!"
    puts "...конец истории"
  elsif $grandma_status == ""
    puts "Дед увидел мертвую бабушку посреди избы....."
    sleep 1
    puts "Схватил лопату и резко ударил тебя по голове, а затем вызвал полицию. Так тебе и надо скотина!!!"
    puts "...конец истории"
  end
  exit
end
