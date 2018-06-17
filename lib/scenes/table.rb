# Рядом со столом
def table_logic
  puts "Обычное окно и рядом стол. На нем ваза цветов. Тебе они могут понадобиться на похороны."
  close_window
end

private
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