## Update files

```
update.sh
```

or

```
update.sh folder
```

**Note: `folder` must be in "~/.config".**

## Set files

```
set.sh
```

or

```
set.sh folder
```

**Note: `folder` must be in "~/.config".**

## Install dependencies

```
sudo pacman -S --needed - < dependencies.txt 2>&1 | grep 错误 | awk -F'：' '{print $NF}'
```

Some need to install by `yay` or `debtab`
