module Scriba
  class Block
    def initialize(text)
      @text = text
    end
    def to_s
      @text
    end
  end
end