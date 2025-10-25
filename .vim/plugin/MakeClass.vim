"This plugin intends to automatically create a C++98 Canonical class
"Based on the currently edited file name

" Guard for double loading of the script
if exists('g:loaded_canonical')
  finish
endif
let g:loaded_canonical = 1

function! s:MakeClass()
  let l:file   = expand('%:t')
  let l:name   = fnamemodify(l:file, ':r')
  let l:is_hdr = index(['h', 'hpp'], expand('%:e')) >= 0

  " Guard for duplicate definitions
  if search('\<class\s\+'.l:name.'\>', 'nw')
    echo "Class ".l:name." already exists."
    return
  endif

  let l:lines = []
  if l:is_hdr
	let l:guard = toupper(l:name).'_HPP'
    call add(l:lines, '#ifndef '.l:guard)
    call add(l:lines, '# define '.l:guard)
    call add(l:lines, '')
  endif
  call add(l:lines, '# include <iostream>')
  call add(l:lines, '# include <string>')
  call add(l:lines, '')
  call add(l:lines, 'class '.l:name.' {')
  call add(l:lines, 'public:')
  call add(l:lines, '    '.l:name.'(void);')
  call add(l:lines, '    '.l:name.'(const '.l:name.' &other);')
  call add(l:lines, '    ~'.l:name.'(void);')
  call add(l:lines, '    '.l:name.' &operator=(const '.l:name.' &other);')
  call add(l:lines, '')
  call add(l:lines, 'private:')
  call add(l:lines, '    // TODO: members')
  call add(l:lines, '};')
  call add(l:lines, '#endif')
  call add(l:lines, '')
  call append('$', l:lines)
endfunction

command! -nargs=0 CanonClass call <SID>MakeClass()

