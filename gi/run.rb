require 'fileutils'
require 'redcarpet'

class Pagename
  attr_reader :ext, :name, :title, :path
  def initialize(path)
    @ext = File.extname(path)
    @name = File.basename(path, @ext)
    @title = @name.gsub('_', ' ')
    @path = path
  end
end

output_dir = '_site'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

# FileUtils.rm_rf(output_dir)
# FileUtils.mkdir(output_dir)
FileUtils.cp_r('css', output_dir)
FileUtils.cp_r('img', output_dir)

head_content = IO.read('_header.htm')
foot_content = IO.read('_footer.htm')

list = Dir.glob('pages/*.*').map { |s| Pagename.new(s) }

content = head_content
content += '<h1 class="page-heading">Posts</h1><ul class="post-list">'
list.each do |f|
  content += "
  <li>
    <h2>
      <a class='post-link' href='#{f.name}.htm'>#{f.title}</a>
    </h2>
  </li>
"
end
content += foot_content
IO.write("#{output_dir}/index.htm", content)

list.each do |f|
  path_content = IO.read(f.path)

  content = head_content
  content += "<header class='post-header'>
              <h1 class='post-title'>#{f.title}</h1>
              </header>"
  if (f.ext == '.markdown')
    content += markdown.render(path_content)
  else
    content += path_content
  end
  content += foot_content
  IO.write("#{output_dir}/#{f.name}.htm", content)
end
