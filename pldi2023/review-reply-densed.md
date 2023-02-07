We thank all the reviewers for their critical and encouraging feedback.
Below we first address the main concerns, which might be paraphrased for the space.

* (Reviewer A) "In terms of ergonomics, I wonder how powerful and usable" this is ... ; (Reviewer D) "Another place where the current approach seems to be lacking is the restriction of induction / case analysis to the top level."

<!-- I am not sure if the following respond is appropriate -->


<!-- 
we hypothesize that nested induction can be lifted to the top level and then it will generate extra proof obligation balabla.

requires significant engineering effort

 -->

As Reviewer A/D points out, to inductiely eliminate data we currently only are equipped with `FInduction` at top level. We only have `fdiscriminate` and `finjection` for intermediate fact. We acknowledge this limitation of our current research and are trying to advance more in this future direction. 

<!-- 
Doesn't seem very relevant for our paper rebuttal

We believe the design challenge of making FInduction-alike structure inside proof script, is mainly how extension happens -- the plugin either needs to manipulate the proof term or manipulate the proof script itself. 
A. The former idea needs either 
    (1) extend the Coq's kernel (i.e. make the Coq's pattern matching facility extensible) or 
    (2) maniuplate the AST of the proof term -> this will need to be shown at proof-script level
B. the latter will manipulate the AST of the proof script
  
B will break incremental compilation "a bit more" (i.e. we cannot have incremental compilation for each recursor). We believe the promising future lies in the direction of A(1), by enhance proof assistants with native extensible pattern matching instead of this current encoding. As Reviewer D mentioned, there is much work to be done. -->

<!-- Basically the generated proof term, we look at each pattern matching point
      and trying to give further proof obligation
    // concretize this idea
 -->

<!-- 

// the reviewer is actually asking nested pattern matching stuff here
// I am not sure if I want to include the following

Reviewer D points out the current lack of "fdestruct". In fact, we believe "fdestruct" doesn't exist. 

Both "finjection" and "fdiscriminate" works on arbitrary extensible inductive type but "fdestruct" can only work on extensible inductive type with fixed number of constructors -- that is a contradiction because all the extensions right now are about extending with new constructors.

One way to have destruct tactic usable is to use overridable/pins. This is not completely covered in Section 3.3, but this is used when we want overridable term to be transparent and thus an inductive type and "destruct"-able

 -->

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

<!-- I love you chatgpt -->

Thank you for your feedback. We will promptly reorganize the structure of Section 5 to improve accessibility
<!-- sympethsize, dense ,hard to read, not giving too much

    we will expand  it in the main text to clarify the question the reviewers have, and also use appendices to explain the  formalization  in greater details 
         -->




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
### Review D
* (Reviewer D) 
* > This expert reviewer's main concerns are (1) the incredible terseness of the theory
  presentation and (2) a few current limitations (framed as future research challenges).
  I don't think there are misunderstandings, so the strategy is to acknowledge them
  and promise to somehow address them in the final revision.

<!-- I think 
  terseness is already covered above
  challenge:
  1. the equality coerciion thing, covered above
  2. the limitedness of the current tactics, covered in the first question
  
  // TBH I don't know what are other tactics people usually use can be added here... But it is future work. I think this question 

  // so I think there is no big questions from Reviewer D anymore.

-->

* Reviewer D reviewer also has some minor questions. Optionally respond to them.

* Reviewer A asks five questions in the "comments to authors" section;
  optionally answer them towards the end of the response letter.

* Reviewer B ask some questions as well

* (Reviewer B) contradictory feature like polymorphism + heap causing unsoundness
<!-- we can expect mixin will generate proof obligation that is not pluasible be proved

one fixpoint extension, the other termination, definitely will fail on the reducibility argument.
 -->