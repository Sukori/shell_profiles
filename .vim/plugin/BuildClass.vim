"This plugin intends to automatically create a C++98 Canonical class constructor
"Based on the currently edited file name

" Guard for double loading of the script
if exists('g:loaded_canonical_builder')
  finish
endif
let g:loaded_canonical_builder = 1

function! s:BuildClass()
  let l:file   = expand('%:t')
  let l:name   = fnamemodify(l:file, ':r')
  let l:is_src = index(['c', 'cpp'], expand('%:e')) >= 0

  " Guard for duplicate definitions
  if search('\<class\s\+'.l:name.'\>', 'nw')
    echo "Class ".l:name." already exists."
    return
  endif

  let l:lines = []
  if l:is_src
    call add(l:lines, '#include "'.l:name.'.hpp"')
	call add(l:lines, '')
  endif
  call add(l:lines, l:name.'::'.l:name.'(void) {')
  call add(l:lines, '    std::cout << "Default '.l:name.' constructor" << std::endl;')
  call add(l:lines, '}')
  call add(l:lines, l:name.'::'.l:name.'(const '.l:name.' &other) {')
  call add(l:lines, '    std::cout << "Copy '.l:name.' constructor" << std::endl;')
  call add(l:lines, '    this = &other;')
  call add(l:lines, '}')
  call add(l:lines, '')
  call add(l:lines, l:name.'::~'.l:name.'(void) {')
  call add(l:lines, '    std::cout << "'.l:name.' destructor" << std::endl;')
  call add(l:lines, '}')
  call add(l:lines, l:name.'    &'.l:name.'::operator=(const '.l:name.' &other) {')
  call add(l:lines, '	std::cout << "'.l:name.' assignation operator" << std::endl;')
  call add(l:lines, '	if (this != &other) {')
  call add(l:lines, '    // TODO: members')
  call add(l:lines, '   }')
  call add(l:lines, '   return (*this);')
  call add(l:lines, '};')
  call add(l:lines, '')
  call append('$', l:lines)
endfunction

command! -nargs=0 BuildCanonClass call <SID>BuildClass()

