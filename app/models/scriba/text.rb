module Scriba
  class Text
    attr_reader :blocks
    
    def initialize(text, filename)
      @filename = filename
      @blocks = []
      text.gsub("\r", '').split("\n\n").each_with_index do |block_text, i|
        @blocks << Scriba::Block.new(block_text, i)
      end
    end

    def self.find(filename)
      path = File.join(Scriba.repo_path, filename)
      raise Scriba::FileNotFound unless File.exists?(path)
      self.new(File.read(path), filename)
    end

    def update_block(id, text)
      @blocks[id.to_i] = text.gsub("\n\n", "\n")
    end

    def get_block(id)
      @blocks[id.to_i]
    end

    def save
      path = File.join(Scriba.repo_path, @filename)
      dir = File.dirname(path)
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      File.open(path, 'w') {|f| f.write self.to_s }
    end

    def to_s
      @blocks.join("\n\n")
    end

  end
end