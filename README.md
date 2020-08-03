# bash-jumper

## Feature Overview

bash-jumper provide fast directory navigation in a terminal. kind of like bookmarks, but for terminal

Also comes with completions

## Commands

`j <name>` : jump to directory labeled with 'name'

`js <name>` : save current directory as 'name'. if name already exist, orreride existing one

`jl` : list current saved directories

`jd <name>` : remove entry named 'name' from list

## installation

simply add jumper.sh in your .bashrc

```bash
source jumper.sh
```
