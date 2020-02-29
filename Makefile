ADOC_PATH ?= ~/usr/bin
ADOC_EXEC  = asciidoctor

PATH_RFC   = rfc
PATH_HTML  = docs

CSS_PATH   = css/stylesheets
CSS_STYLE  = golo.css

# list of RFC files : rfc/rfc*.adoc
TMP_IN     = $(wildcard $(PATH_RFC)/rfc*.adoc)
TMP_IN    += $(PATH_RFC)/index.adoc

# it removes the prefix rfc/
IN         = $(subst $(PATH_RFC)/,,$(TMP_IN))

# it adds the prefix doc
OUT        = $(patsubst %.adoc,%.html,$(IN))

VPATH = $(PATH_HTML)

html: $(OUT)

%.html : $(PATH_RFC)/%.adoc
	$(ADOC_PATH)/$(ADOC_EXEC) -a stylesdir=../$(CSS_PATH) -a stylesheet=$(CSS_STYLE) -b html5 -d article $< -o $(PATH_HTML)/$@

clean:
	@rm -f $(foreach f,$(OUT),$(PATH_HTML)/$(f))
