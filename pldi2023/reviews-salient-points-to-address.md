### Review A

* "hard to tell how powerful and ergonomic this is in practice"

  "In terms of ergonomics, I wonder how powerful and usable is the FInduction
  construct is. In Coq proofs, it's not rare to use induction tactics inside a
  larger proof. Will users need to outline those into their explicit own
  lemmas?"

  > This question is related to Reviewer D's comment on `fdestruct` and stuff

* "Seems related to type theories for modules, but doesn't discuss the connection"
  
  Finally, I note that a family has similarities with an ML-style module,
  including the fact that some of its members are opaque while others are
  abstract. This is modelled through the use of singleton types, just as
  dependent type theories for modules do (e.g., Dreyer, Crary, Harper, POPL
  2003), which are also extensions of MLTT. Furthermore, there has been work on
  extending ML modules with mixin composition (Dreyer, Rossberg, ICFP 2008).
  ML-style modules are the basis of Coq's module system as well, so I would have
  expected some comparison with this line of work.

  > We need to say something about "A type system for higher-order modules"

* "I understand that it is hard to fit more into the page limit, but I sincerely
  hope that this section can be expanded significantly in the final version."

  > Promise to do that
  
  > Actually all reviewers complained about it.

* > This reviewer asks five questions in the "comments to authors" section;
  optionally answer them towards the end of the response letter.

### Review B

* "One thing I don't really get from the rules/discussion (including the
  appendix) is the exact mechanism for choosing the A in rules like TyEq/PK/Add
  and LSig/Add where A is supposed to abstract out the possibly-extensible types
  in deciding what to make available to later definitions. Is A always going to
  be uniquely determinable from s? (or if not, does the nondeterminism matter?)
  Is it up to the user (in this case, the plugin) to get this right, or do the
  rules somehow make sure that the right things are abstracted in a way I can't
  see?"

  > Respond to this

* "I find it somewhat surprising that neither the FPOP plugin / implementation
  itself, nor the code of the case studies, is provided."

  > Promise to make the artifacts available. Reviewer D also mentions this.

* "I think the paper would also be improved by delineating the limitations of the
  current implementation / metatheory, particularly where alternatives may
  exist, such as for extensions that require changes to types which is
  considered by [15] but is unclear can be handled by FPOP."

  > Related to Reviewer C's final comment on being upfront about limitations.
  > Reviewer D also mentions some limitations or challenges for future research,
  > and asks for explicitly listing the trusted code bases.
  > Can address all these in one place.

### Review C

* "The utility of the FMLTT formalization in this paper is unclear to me. Don't
  you already have consistency and canonicity via the translation to Coq
  demonstrated by FPOP? Or put another way, instead of defining FMLTT directly,
  couldn't you translate it to MLTT following the approach in FPOP?"

  > Respond to this

### Review D

* > This expert reviewer's main concerns are (1) the incredible terseness of the theory
  presentation and (2) a few current limitations (framed as future research challenges).
  I don't think there are misunderstandings, so the strategy is to acknowledge them
  and promise to somehow address them in the final revision.

* > This expert reviewer also has some minor questions. Optionally respond to them.