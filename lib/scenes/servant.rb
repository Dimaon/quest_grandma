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
