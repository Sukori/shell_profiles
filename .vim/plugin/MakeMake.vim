"This plugin intends to automatically create a MakeFile for C++ compilation

" Guard for double loading of the script
if exists('g:loaded_Maker')
  finish
endif
let g:loaded_Maker = 1

function! s:MakeMake()
  let l:lines = []
  call add(l:lines, 'NAME		= a.out')
  call add(l:lines, '')
  call add(l:lines, 'CXX			= c++')
  call add(l:lines, 'CXXFLAGS	= -Wall -Wextra -Werror')
  call add(l:lines, '')
  call add(l:lines, 'HDIR		= headers/')
  call add(l:lines, 'SDIR		= sources/')
  call add(l:lines, 'ODIR		= obj/')
  call add(l:lines, '')
  call add(l:lines, 'CXX			+= -std=c++98')
  call add(l:lines, 'CXXFLAGS	+= -I$(HDIR)')
  call add(l:lines, '')
  call add(l:lines, 'HDRS		= ')
  call add(l:lines, 'SRCS		= ')
  call add(l:lines, '')
  call add(l:lines, 'HDR			= $(addprefix $(HDIR), $(addsuffix .hpp, $(HDRS)))')
  call add(l:lines, 'SRC			= $(addprefix $(SDIR), $(addsuffix .cpp, $(SRCS)))')
  call add(l:lines, 'OBJ			= $(addprefix $(ODIR), $(addsuffix .o, $(SRCS)))')
  call add(l:lines, '')
  call add(l:lines, 'all: $(NAME)')
  call add(l:lines, '')
  call add(l:lines, '$(NAME): $(OBJ)')
  call add(l:lines, '	$(CXX) $(CXXFLAGS) $^ -o $@')
  call add(l:lines, '')
  call add(l:lines, '$(ODIR)%.o: $(SDIR)%.cpp $(HDR) | $(ODIR)')
  call add(l:lines, '	$(CXX) $(CXXFLAGS) -c $< -o $@')
  call add(l:lines, '')
  call add(l:lines, '$(ODIR):')
  call add(l:lines, '	mkdir -p $(ODIR)')
  call add(l:lines, '')
  call add(l:lines, 'clean:')
  call add(l:lines, '	rm -rf $(ODIR)')
  call add(l:lines, '')
  call add(l:lines, 'fclean: clean')
  call add(l:lines, '	rm -rf $(NAME)')
  call add(l:lines, '')
  call add(l:lines, 're: fclean all')
  call add(l:lines, '')
  call add(l:lines, '.PHONY: all clean fclean re')
  call add(l:lines, '')
  call append('$', l:lines)
endfunction

command! -nargs=0 MakeMaker call <SID>MakeMake()

