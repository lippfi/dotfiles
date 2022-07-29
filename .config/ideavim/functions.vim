function! IsUppercase(char)
  return a:char >=# 'A' && a:char <=# 'Z'
endfunction

function! IsCaps(word)
  return a:word ==# toupper(a:word)
endfunction

function! Capitalize(word)
  return toupper(a:word[0]) .. a:word[1:]
endfunction

function! Split(text, delimeter)
  let parts = []
  let part = ''
  for char in a:text
    if char ==? a:delimeter
      let parts += [part]
      let part = ''
    else
      let part .= char
    endif
  endfor
  let parts += [part]
  return parts
endfunction

" This function replaces snake case word under caret with its camel case
" version (it's like Vim's `u` keypress, but better)
" e.g. snake_case -> snakeCase
" e.g. SNAKE_CASE -> snakeCase
function! ToCamelCase()
  let capitalize = 0
  
  normal gv"wy
  let wordUnderCaret = @w
  let parts = Split(wordUnderCaret, '_')
  let result = tolower(parts[0])
  let counter = 1
  while counter < len(parts)
    let result .= Capitalize(tolower(parts[counter])) 
    let counter += 1
  endwhile
  execute 'normal gvc' .. result 
endfunction

" This function replaces camel case word under caret with its capitalized snake 
" case version (it's like Vim's `U` keypress, but better)
" e.g. camelCase -> CAMEL_CASE
function! ToSnakeCase()
  normal gv"wy
  let wordUnderCaret = @w
  
  let parts = []
  let subword = ''
  let atWordStart = 1
  for char in wordUnderCaret
    if IsUppercase(char) && !atWordStart
      let parts += [toupper(subword)]
      let subword = char
    else
      let subword .= char
    endif

    let atWordStart = char ==? ' '
  endfor
  let parts += [toupper(subword)]
  execute 'normal gvc' .. join(parts, '_')
endfunction

" This function replaces the word under caret with it's antonym
" e.g. true -> false
" e.g. firt -> last
function! Invert(calledFromVisual)
  let antonyms = [
                   \'true', 'false', 'after', 'before', 'start', 'end', 'left', 'right', 'first', 'last',
                   \'up', 'down',
                   \'True', 'False', 'After', 'Before', 'Start', 'End', 'Left', 'Right', 'First', 'Last',
                   \'Up', 'Down',
                 \]

  if a:calledFromVisual
    normal gv"wy
  else
    normal "wyiw
  endif
  let wordUnderCaret = @w

  let eraseWord = a:calledFromVisual ? 'gvc' : 'ciw'
  let count = 0
  while (count < len(antonyms))
    if (antonyms[count] ==# wordUnderCaret)
      let antonym = (count % 2 ==? 0) ? antonyms[count + 1] : antonyms[count - 1]
      execute 'normal ' .. eraseWord .. antonym
      break
    endif
    let count += 1
  endwhile
endfunction

" works same as vim's default g<C-A> but increments not only the first number,
" but all the numbers in selection
" e.g.
"           val ch1 = tree.getChild(0)                              val ch1 = tree.getChild(0)
"<selection>val ch1 = tree.getChild(0)              ---g<C-A>-->    val ch2 = tree.getChild(1)
"           val ch1 = tree.getChild(0)</selection>                  val ch3 = tree.getChild(2)
function! IncrementWholeLine() range
  if has('ide')
    execute "'<,'>s/\\d\\+/\\=submatch(0)+line('.')-a:firstline+1/g"
  else
    " requires %V support :<
    execute "'<,'>s/\\%V\\d\\+\\%V/\\=submatch(0)+line('.')-a:firstline+1/g"
  endif
  noh
endfunction

