DISTNAME = podslides-ax-magicpoint
VERSION = 0.01
DISTVNAME = $(DISTNAME)-$(VERSION)
DIST_DEFAULT = tardist
SUFFIX = .gz

.SUFFIXES:

.SUFFIXES: .pod .pdf .mgp .axp .pox

all:
	@echo This Makefile has only SUFFIX rules, you need to call make
	@echo with a target ending in either .pdf or .mgp, and you need to supply
	@echo a POD file ending in .pod. E.g.
	@echo
	@echo "make foo.pdf       # creates foo.pdf from foo.pod"
	@echo "make foo.mgp       # creates foo.mgp from foo.pod"
	@echo
	@echo Then you can run the presentation with either of
	@echo
	@echo acroread foo.pdf
	@echo mgp foo.mgp
	@echo
	@echo Please consult this Makefile for prerequisites.
	@echo

dist : $(DIST_DEFAULT)

tardist : $(DISTVNAME).tar$(SUFFIX)

$(DISTVNAME).tar$(SUFFIX) : distdir
	tar cvf $(DISTVNAME).tar $(DISTVNAME)
	rm -rf $(DISTVNAME)
	gzip -9f $(DISTVNAME).tar

distdir :
	rm -rf $(DISTVNAME)
	mkdir $(DISTVNAME)
	perl "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', 'best');"
	cat axpoint2mgp.pod > $(DISTVNAME)/README

.axp.mgp:
	xsltproc axpoint2mgp.xsl $*.axp > $*.mgp

.axp.pdf:
	axpoint $*.axp $*.pdf

.pox.axp:
	xsltproc pod2axpoint.xsl $*.pox > $*.axp

.pod.pox:
	perl -e 'use XML::SAX::Writer;use Pod::SAX;' \
		-e 'my $$source = shift(@ARGV) or die;' \
		-e 'my $$output = shift (@ARGV) || \*STDOUT;' \
		-e 'my $$p = Pod::SAX->new({Handler => XML::SAX::Writer->new()});' \
		-e '$$p->parse_uri($$source);' $*.pod > $*.pox

