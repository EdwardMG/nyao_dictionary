*nyao_dictionary*

INTRODUCTION

Vim has a <complete> function which activates its completion system using an
array of strings that has been passed to it, the same as <c-p> normally does
for words in the current buffer. This plugin saves words to a file called a
dictionary that will be loaded for this completion so you can easily define
a set of completions you find particularly useful in your projects.

Completions with this plugin are tolerant of matchings in the middle of words
and items in the dictionary that have spaces, making it well suited to smaller
dictionaries that won't have too many matches.

Requires rubywrapper plugin.

USAGE

<Functions>

:ruby NyaoDictionary.add_word(VisualSelection.new.inner[0])

  Add the visually selected word to nyao_dictionary

  should be a visual mapping

:ruby NyaoDictionary.add_word(Ev.expand("<cword>"))

  Add the cword under cursor to nyao_dictionary

  should be a normal mapping

<C-R>=rubyeval('NyaoDictionary.complete')

  Start vims autocomplete using nyao_dictionary words you have added.

  should be an insert mapping

<C-R>=rubyeval('NyaoDictionary.complete_strict')

  Start vims autocomplete using nyao_dictionary words you have added. Unlike
  NyaoDictionary.complete, does not include <.> as part of word being
  completed, which is preferable when trying to complete a method name on an
  instance.

  should be an insert mapping

vim:autoindent noexpandtab tabstop=8 shiftwidth=8
vim:se modifiable
vim:tw=78:et:ft=help:norl:

