class String
  def is_wrong!
    self  + "-isWrong"
  end
  def debug
    " >> "+self
  end
end

class Integer
  def is_wrong!
    self + 2
  end
  def debug
    " >> "+self.to_s
  end
end

class Array
  def debug
    " >> "+self.to_s
  end
end

class Hash
  def debug
    " >> "+self.inspect
  end
end
# ---
def debug_output(message)
  puts " DEV NOTE >> "+message.to_s
end
