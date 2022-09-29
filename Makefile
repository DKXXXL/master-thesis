DOC = draft

# Name of the top-level TeX file sans .tex extension.
CONF = paper

TARGETS = $(DOC).pdf

# TeX source files
TEXS = $(DOC).tex abstract.tex title.tex header.tex body.tex	\
	acmart.cls formalisms.sty syntax.tex metatheory.tex standardmodel.tex canonicitymodel.tex coqimpl.tex introduction.tex syntactic-example.tex coq-example.tex lang-design.tex related-work.tex syn-translate.tex challenge.tex	\
	stlc-nonmechanized.tex stlc-mechanized.tex	\
	stlc-intro.pdf

# Included figures (usually .pdf files)
FIGS = graphics

MAKEDIR = make

include $(MAKEDIR)/commondefs

# Change to wherever you put paperversions.tex and the .sty files.
TEXDIR = tex-macros

VPATH = $(TEXDIR):$(FIGS):
TEXINPUTS = $(TEXDIR):$(FIGS):

default: $(TARGETS)

BIBFILE = refs.bib

$(DOC).pdf: $(TEXS) $(DOC).stamp $(DOC).bbl $(BIBFILE)
$(DOC).bbl: $(BIBFILE) $(DOC).stamp

$(DOC).tex: $(CONF).tex
	sed s/DOC/$(DOC)/ < $(CONF).tex > $(DOC).tex
   
LDIRT = local.tex markup.tex draft.tex submission.tex final.tex finaldraft.tex\
    tr.tex trdraft.tex blindtr.tex web.tex

GENERATED += local.* markup.* draft.* submission.* final.* finaldraft.* tr.*  \
    trdraft.* blindtr.* web.*

LLATEXFLAGS = --shell-escape -halt-on-error

include $(COMMONRULES)
