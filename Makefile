NAME=workspace-to-dock
DOMAIN=yshngg.github.io

.PHONY: all pack install clean

all: dist/extension.js

node_modules/.package-lock.json: package.json
	npm install

dist/extension.js dist/prefs.js: node_modules/.package-lock.json *.ts
	npm run build

pack: dist/extension.js dist/prefs.js
	@cp -r schemas dist/
	@cp metadata.json dist/
	gnome-extensions pack --force --schema schemas/org.gnome.shell.extensions.$(NAME).gschema.xml ./dist

install: pack
	gnome-extensions install --force $(NAME)@$(DOMAIN).shell-extension.zip

clean:
	@rm -rf dist node_modules $(NAME)@$(DOMAIN).shell-extension.zip
