files = src/theme.yaml src/css.yaml src/js.yaml src/html.yaml src/ruby.yaml \
        src/php.yaml src/c.yaml src/diff.yaml src/markdown.yaml \
        src/rest.yaml src/other.yaml src/tex.yaml src/python.yaml \
        src/shell.yaml src/java.yaml src/perl.yaml src/text.yaml \
        src/sublimelinter.yaml

theme = Solarized_dark.tmTheme Solarized_light.tmTheme

all: $(theme)

Solarized_dark.tmTheme: src/dict_dark.yaml $(files)
	./yamltotm.py -d src/dict_dark.yaml $(files) $@

Solarized_light.tmTheme: src/dict_light.yaml $(files)
	./yamltotm.py -d src/dict_light.yaml $(files) $@

clean:
	$(RM) $(theme)
