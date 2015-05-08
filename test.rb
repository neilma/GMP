# exec("gem sources -a http://rubygems.org")
# file_name = 'C:\Users\s74506\.gemrccopy.gemrc'
# c = File.read(file_name)
# c = "---\n:backtrace: false\n:bulk_threshold: 1000\n:sources:\n- http://rubygems.org\n:update_sources: true\n:verbose: true\ninstall: --no-rdoc --no-ri --env-shebang\nupdate: --no-rdoc --no-ri --env-shebang\n"
# p c
# new_c = c.gsub(/sources:(\\n-\shttp:.*)\\n:update_sources/, '\n- http://my1\n- http://my2')
# p new_c
#new_c = c.gsub(/(\-\shttp.*\n)/, 'http://rubygems.my')
# File.write(file_name, new_c)
# p File.read(file_name)

require 'open3'
# Open3.popen3('gem sources --add') do |stdin, stdout, stderr|
#   stdin.print "http://rubygems.org"
#   stdin.print "n\r\n"
#   stdin.close
# end
# # IO.popen("gem sources -a http://rubygems.org", "r+") do |f|
# #   f.puts "n\r"
# #   f.close_write
# # end
# # # o, s = Open3.capture2("gem sources --add http://rubygems.org", stdin_data: "n\r\n")
#
# # IO.popen("irb", "r+") do |pipe|
# #   pipe.puts "puts 111"
# #   pipe.gets
# #   pipe.close_write
# # end
Open3.popen3('gem sources -a http://rubygems.org') do |stdin, stdout, stderr, t|
  # stdin.puts('y\n\r')
  p stderr.gets
end
# Open3.capture3('gem sources -a http://rubygems.org') do |i, o, e, t|
#   i.puts("n\r\n")
#   i.puts("__END__")
# end
# o, e, s = Open3.capture3("gem sources -a http://rubygems.org", :stdin_data=>"n\n")
p `gem sources`