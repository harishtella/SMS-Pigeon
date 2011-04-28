class Modem


  def self.read_current_number
    special_string_1 = "#special-line-my-number"

    f = File.open("/etc/kannel/kannel.conf", "rb")
    contents = f.read
    f.close
    contents = contents.split("\n")
    marker_index = contents.index(special_string_1)
    my_number_str = contents[marker_index + 1] 
    my_number_str[12..(my_number_str.size - 1)] 
  end


  def self.set_new_number(new_number)
    special_string_1 = "#special-line-my-number"
    special_string_2 = "#special-line-global-sender"

    f = File.open("/etc/kannel/kannel.conf", "rb")
    contents = f.read
    f.close
    contents = contents.split("\n")

    marker_index_1 = contents.index(special_string_1)
    marker_index_2 = contents.index(special_string_2)

    puts marker_index_1
    puts marker_index_2

    contents[marker_index_1 + 1] = "my-number = " + new_number
    contents[marker_index_2 + 1] = "global-sender = " + new_number

    contents = contents.join("\n")

    f = File.open("/etc/kannel/kannel.conf", "w")
    f.puts(contents)
    f.close

  end

end
