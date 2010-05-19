{
  :uk => {
    :pluralize => lambda { |n|      
      modulo10 = n.modulo(10)
      modulo100 = n.modulo(100)
      
      if modulo10 == 1 && modulo100 != 11
        :one
      elsif (modulo10 == 2 || modulo10 == 3 || modulo10 == 4) && !(modulo100 == 12 || modulo100 == 13 || modulo100 == 14)
        :few
      elsif modulo10 == 0 || (modulo10 == 5 || modulo10 == 6 || modulo10 == 7 || modulo10 == 8 || modulo10 == 9) || (modulo100 == 11 || modulo100 == 12 || modulo100 == 13 || modulo100 == 14)
        :many
      else
        :other
      end
    }
  }
}
