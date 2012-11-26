# _Können wir die Kurve umbringen ?_

Formerly known as _INSAchtung_, the world-famous arcade game inspired by _Achtung, die Kurve !_.

## get coffee
### Archlinux
Install `nodejs` and `npm` using the package manager `pacman`:
```bash
pacman -S nodejs
```
### Mac Os X
Install `nodejs` and `npm` using for instance [MacPorts](http://www.macports.org/):
```bash
port install npm
```

… then use the Node.js package manager `npm` to install the coffee-script compiler:
```bash
npm install -g coffee-script # leave off -g to execute as normal user
```

## compile
```bash
make # requires coffee
```

## play
```bash
open static/index.html # using your favorite cutting-edge web browser 
```
