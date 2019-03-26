# JavaSnippet.vim

## Introduction

This plugin can do snippet complement java language.

## Installation

[dein.vim](https://github.com/Shougo/dein.vim)

```
call dein#add('kazukazuinaina/JavaSnippet.vim')
```

[Vim-plug](https://github.com/Shougo/dein.vim)

```
Plug 'kazukazuinaina/JavaSnippet.vim'
```

## What to use

### Command List

| Command                                    | Description                                                        |
| -----------------------------------        | ------------------------------------------------------------------ |
| `Javasnippet [accessname] [classname]`     | Do complement class sentence                                       |
| `Getter [mold] [fieldname]`                | Do complete getter method for java                                 |
| `Setter[mold] [fieldname]`                 | Do complete setter method for java                                 |
| `Method [accessname] [mold] [methodname] ` | Do complete something method for java                              |
| `SwitchOn`                                 | You can establish auto complete about class sentence               |
| `SwitchOff`                                | You can establish auto complete about class sentence               |
| `Import`                                   | Do complement import sentence for ~/.dict/JavaImport.txt           |
| `Indent`                                   | You can easily adjust all buffor`s indent                          |

**default`s auto complete about class sentence is off!!**

## Caution

If you want to use Import command,

**please trancefar dict/JavaImport.txt to ~.dict/JavaImport.txt**

## Lisence

MIT
