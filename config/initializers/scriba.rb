module Scriba
  class FileNotFound < RuntimeError; end
  def self.repo_path
    Rails.root.join('db', 'repo')
  end

  def self.markdown_text_to_html(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, markdown_options)
    @markdown.render(text).html_safe
  end

  protected

  def self.markdown_options
    {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true
    }
  end
end