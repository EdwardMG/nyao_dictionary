fu! s:setup()
ruby << RUBY
require 'fileutils'

module NyaoDictionary
  @@p = "#{ENV["HOME"]}/.vim/dictionary/nyao_dictionary.txt"

  def self.add_word word
    unless File.exist? @@p
      FileUtils.mkdir_p @@p[..@@p.rindex('/')-1]
      File.write(@@p, '')
    end
    lines = File.readlines(@@p)
    lines << (word+"\n")
    lines.uniq!
    File.write(@@p, lines.join(''))
    Ex['se dictionary='+@@p]
    puts "Saved `#{word}` to #{@@p}"
  end

  def self.complete
    l    = Vim::Buffer.current.line
    col  = Ev.col('.')
    i    = (l.rindex(/[ \/(,\[]/, col)||-1)+1 # this is a bit arbitrary, but I'm defining a word as allowing . but not allowing ([, etc
    word = l[i..col]
    ls   = File.readlines(@@p, chomp:true)

    if word.bytes.any? { _1 > 64 && _1 < 91 }
      ls.select! { _1.match?(word) }
    else
      ls.select! { _1.downcase.match?(word.downcase) }
    end
    Ev.complete(i+1, ls)
    ''
  end

  Ex['se dictionary='+@@p]
end
RUBY
endfu

call s:setup()

if exists('g:nyao_always_add_mappings') && g:nyao_always_add_mappings
  vno <space>d :ruby NyaoDictionary.add_word(VisualSelection.new.inner[0])<CR>
  nno <c-d> :ruby NyaoDictionary.add_word(Ev.expand("<cword>"))<CR>

  ino kj <C-R>=rubyeval('NyaoDictionary.complete')<CR>
endif

