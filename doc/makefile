
DICT_TEMPLATE_SCRIPT=src/dictionary-template.R

MAKE_DICT_TABLE=Rscript $(DICT_TEMPLATE_SCRIPT)

data-dictionary: out/epidemiology-table.md \
								out/government-response-table.md \
								out/mobility-table.md \
							  out/country-coverage.md

out/epidemiology-table.md: src/dictionary-template.R
	$(MAKE_DICT_TABLE) ../data-epidemiology out/epidemiology-table.md

out/government-response-table.md: src/dictionary-template.R
	$(MAKE_DICT_TABLE) ../data-government-response out/government-response-table.md

out/mobility-table.md: src/dictionary-template.R
	$(MAKE_DICT_TABLE) ../data-mobility out/mobility-table.md

out/country-coverage.md: src/list-countries.R
	Rscript src/list-countries.R ../data-epidemiology out/country-coverage.md
