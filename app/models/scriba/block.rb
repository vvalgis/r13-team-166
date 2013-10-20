module Scriba
  class Block
    def initialize(text, order_no)
      @text, @order_no = text, order_no
    end
    def to_s
      @text
    end
    def to_html
      Scriba.markdown_text_to_html(@text)
    end
    def to_partial_path
      "documents/block"
    end
    def to_param
      @order_no
    end
    def id
      @order_no
    end
  end
end