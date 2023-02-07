We thank all the reviewers for their critical and encouraging feedback.
Below we first address the main concerns, which might be paraphrased for the space.

* (Reviewer A) "In terms of ergonomics, I wonder how powerful and usable" this is ... ; (Reviewer D) "Another place where the current approach seems to be lacking is the restriction of induction / case analysis to the top level."


As Reviewer A/D points out, to inductiely eliminate data we currently only are equipped with `FInduction` at top level. We only have `fdiscriminate` and `finjection` for deducing intermediate fact. The key problem is the lack of certain nested pattern matching.

<!-- The idea is 
    fill in the new hole once pattern matching needs to extend the clauses
    lifting nested induction to top level is not necessary
 -->

We acknowledge this limitation of our current research and are trying to advance more in this direction. We hypothesize that code involving nested induction/pattern matching an be reused by fill in the hole after extension upon inductive type. The plugin will generate extra proof obligation to fill this hole. This certainly requires significant amount of engineering effort.



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



* (Reviewer A/B/C/D) Section 5 FMLTT is too dense, "incrediably terse" and inappropriately presented to give the audience enough intuition  



Thank you for your feedback. 
We sympathize with the general impression on Section 5, and we agree it is dense, hard to read and not giving too much inspiration for the general understanding of the whole paper.

We plan to expand it in the main text to clarify the questions the reviewers have, and also use appendices to explain the formalization in greater details. 





### Review B

* (Reviewer B)"One thing I don't really get from the rules/discussion (including the
  appendix) is the exact mechanism for choosing the A in rules like TyEq/PK/Add
  and LSig/Add where A is supposed to abstract out the possibly-extensible types
  in deciding what to make available to later definitions. Is A always going to
  be uniquely determinable from s? (or if not, does the nondeterminism matter?)
  Is it up to the user (in this case, the plugin) to get this right, or do the
  rules somehow make sure that the right things are abstracted in a way I can't
  see?"

At the metatheory level, this A is decided by the programmer and not uniquely determined as you observed. 
In practice, this A is decided by implementation. Our plugin always choose a "default" one which is just making all inductive type opauqe (Line 791) and make sure other parts stay the "same".

<!-- Use example on Pg 16. Concrete run it -->
(I.e. s maps {Nat : W(O, S); pred : Nat -> Nat} into {Nat : U; O : Nat; S : Nat -> Nat; pred : Nat -> Nat}). It is possible to design an interface where the programmer can choose which `A` they would love to abstract to, but we haven't found any use case for this functionality yet.

* (Reviewer B/D) "I find it somewhat surprising that neither the FPOP plugin / implementation
  itself, nor the code of the case studies, is provided."

We will certainly make the FPOP plugin/implementation available.

* (Review B) "I think the paper would also be improved by delineating the limitations of the
  current implementation / metatheory.."; (Reviewer C) "Be upfront about this limitation instead of hiding it in the section on case studies."; (Reviewer D) "The biggest of these (which is not mentioned in the paper), is that the presence of open terms complicates typechecking dependently typed terms."; (Reviewer D) "It would be nice to add an explicit comment about the trusted code bases of any developments"

Thank you for your feedback. We will clearly state the limitations of the current implementation and meta-theory in the final revision. In particular, 

1. we will emphasize the issue raised by Reviewer D regarding equality coercion and the pervasive propositional equality on extensible inductive families. This can result in unnecessary equality coercion when `denoteTy t` is not definitionally equal to `nat`.

We believe that this opens up new opportunities for future work in both theory and practice,
(a). such as a normalization algorithm for an extended calculus that allows for more convertibility upon elimination of the extensible inductive type; 
(b). and a proper proof assistant that supports native extensible inductive types instead of the current encoding via our plugin, thus allowing for proper reduction of open terms. This will change the kernel of proof assistant for sure. 


In the final revision, we will also clarify that our plugin only translates code into vanilla Coq terms without expanding the trusted codebase.


### Review C

* "The utility of the FMLTT formalization in this paper is unclear to me. Don't
  you already have consistency and canonicity via the translation to Coq
  demonstrated by FPOP? Or put another way, instead of defining FMLTT directly,
  couldn't you translate it to MLTT following the approach in FPOP?"

The technical detail here is that, FMLTT also has this unconventional Wtype formulation 
<!-- explain how unconventional it is
      what conventional about unconventional Wtype
 -->
, which is closer to the inductive type in the surface syntax for Coq and Agda. 

Our translation doesn't translate this unconventional Wtype formulation back to the conventional one. So the core calculus after translation is MLTT + this unconventional Wtype. In that case, translation function as a guide to the plugin implementation, and pedantically is not enough to show the consistency/canonicitiy for FMLTT.

<!-- make it clear that we have MLTT + unconventional Wtype as target calculus -->

<!-- acknowledge the reviewer's  idea of translating unconventional Wtype into conventional Wtype -->

<!-- We consider the formalized translation as an oversimplified fundation of the plugin implementation(because the unconventional Wtype is closer to the surface syntax so we believe it is legit), also act as a guidance of the plugin implementation, and hope it function as part of the supplementary text for the reader confused about the description in the main text. -->
### Other questions



* Reviewer A asks five questions in the "comments to authors" section;
  optionally answer them towards the end of the response letter.

* Reviewer B ask some questions as well

* (Reviewer B) How will our plugin react when trying to mixin the contradictory features? For example, since STLC with polymorphism and  STLC + references both enjoying principal typing under HM type inference, but their composition doesn't. 

We can expect our plugin will generate unprovable proof obligation under mixin, hindering qed'ed the proposition and thus closing the family.

Another exmaple would be extend *STLC and its termination proof* with general recursion feature. Our plugin will generate unprovable proof obligation for the reducibility argument.  

 * Reviewer D reviewer also has some minor questions. Optionally respond to them.