# frozen_string_literal: true

# Display contains the elements for printing the gameboard
module Display
  TOP_LEFT = "\u250C"
  TOP_RIGHT = "\u2510"
  BOTTOM_LEFT = "\u2514"
  BOTTOM_RIGHT = "\u2518"
  SAD_FACE = "\u2639"
  HAPPY_FACE = "\u263A"
  HOR = "\u2500"
  ROPE = "\u2506"
  FACE = "\u25EF"
  VER = "\u2502"
  T_DOWN = "\u252C"
  T_UP = "\u2534"
  T_RIGHT = "\u251C"
  T_LEFT = "\u2524"
  T_ALL = "\u253C"

  def hang
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + SAD_FACE + "\n" + VER + ' /' + VER + '\\' + "\n" + VER + " / \\ \n" + T_UP
  end

  def win
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + '    \\' + HAPPY_FACE + "/\n" + VER + '     ' + VER + "\n" + T_UP + '    / \\'
  end

  def base
    "\n\n\n\n\n" + T_UP
  end

  def stick
    "\n" + VER + "\n" + VER + "\n" + VER + "\n" + VER + "\n" + VER + "\n" + T_UP
  end

  def full_stick
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + "\n" + VER + "\n" + VER + "\n" + VER + "\n" + T_UP
  end

  def rope
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + "\n" + VER + "\n" + T_UP
  end

  def body
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + '  ' + VER + "\n" + VER + "\n" + T_UP
  end

  def l_arm
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + ' /' + VER + "\n" + VER + "\n" + T_UP
  end

  def r_arm
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + ' /' + VER + '\\' + "\n" + VER + "\n" + T_UP
  end

  def l_leg
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + ' /' + VER + '\\' + "\n" + VER + " /\n" + T_UP
  end

  def r_leg
    TOP_LEFT + HOR * 2 + TOP_RIGHT + "\n" + VER + '  ' + ROPE + "\n" + VER + '  ' + FACE + "\n" + VER + ' /' + VER + '\\' + "\n" + VER + " / \\ \n" + T_UP
  end

  def game_row(pegs, keys, number)
    pegs = pegs.map { |str| get_peg(str) }
    keys = keys.map { |str| get_key(str) }
    number_strings = number < 10 ? " #{number}" : number.to_s
    VER + number_strings + VER + ' ' + pegs.join('  ') + '  ' + VER + ' ' + keys.join(' ') + ' ' + VER
  end

  def code_row(pegs)
    pegs = pegs.map { |str| get_peg(str) }
    VER + ' ' + pegs.join('  ') + '  ' + VER
  end

  def get_peg(color = 'empty')
    {
      'empty' => "\u25ef",
      'red' => "\u2b24".red,
      'green' => "\u2b24".green,
      'blue' => "\u2b24".blue,
      'yellow' => "\u2b24".yellow,
      'purple' => "\u2b24".purple,
      'cyan' => "\u2b24".cyan
    }[color]
  end

  def color_menu
    ' 1 '.bg_red + ' ' + ' 2 '.bg_blue + ' ' + ' 3 '.bg_green + ' ' + ' 4 '.bg_yellow + ' ' + ' 5 '.bg_purple + ' ' + ' 6 '.bg_cyan
  end

  def get_image(option = '0')
    {
      '0' => "\n\n\n\n\n",
      '1' => base,
      '2' => stick,
      '3' => full_stick,
      '4' => rope,
      '5' => body,
      '6' => l_arm,
      '7' => r_arm,
      '8' => l_leg,
      '9' => r_leg,
      '10' => hang,
      '11' => win
    }[option]
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def select_name(number)
    puts "Select player #{number} name"
    gets.chomp
  end
end
