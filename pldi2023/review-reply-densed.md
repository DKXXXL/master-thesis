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



* (Reviewer A/B/C/D) Section 5 FMLTT is too dense, "incrediably terse" and inappropriately presented to give the audience enough intuition. Reviewer D: "More worrisome, the full proof is *only* given in a notation heavy, Agda-style format"



Thank you for your feedback. 
We sympathize with this impression on Section 5, and we agree it is dense, hard to read and not giving too much inspiration for the readers.

We plan to expand it in the main text to clarify the questions the reviewers have, and also use appendices to explain the formalization and the proof in greater details aiming for readability. 





### Review B

* *(Reviewer B)"One thing I don't really get from the rules/discussion (including the
  appendix) is the exact mechanism for choosing the A in rules like TyEq/PK/Add
  and LSig/Add where A is supposed to abstract out the possibly-extensible types
  in deciding what to make available to later definitions. Is A always going to
  be uniquely determinable from s? (or if not, does the nondeterminism matter?)
  Is it up to the user (in this case, the plugin) to get this right, or do the
  rules somehow make sure that the right things are abstracted in a way I can't
  see?"*
  
  The typing rules do not commit to a particular choice of $A$, as the reviewer
  points out.
  In practice, this A is decided by implementation. Our plugin always choose a "default" one which is just making all inductive type into an opaque type (Line 791) and make sure other parts stay the "same".

  Taking (Line 745) Figure. 8 as an example, `σ₅` has `tm : 𝕊(W(τₜₘ))` and `A`
  has `tm : 𝕌` instead. `s` will make sure other fields stay the same type. To
  show this explicitly at the plugin level, we look at Figure 4 (Line 494)
  `Module Type STLC°tm` (corresponding to `A`), where `tm : Set` (corresponding
  to `tm : 𝕌`). With this interface `STLC°tm` we cannot pattern match any term
  of type `tm : 𝕌` thus doing abstraction successfully.

  Generally speaking, all the (extensible) inductive type will be simply
  "wrapped" by a module type with its interface and only exposing the
  constructor (with no eliminators), just like how we generate `STLC°tm`.
  

* *(Reviewer B/D) "I find it somewhat surprising that neither the FPOP plugin / implementation
  itself, nor the code of the case studies, is provided."*

  We will certainly make the FPOP plugin/implementation available.

* *(Review B) "I think the paper would also be improved by delineating the limitations of the
  current implementation / metatheory.."; (Reviewer C) "Be upfront about this limitation instead of hiding it in the section on case studies."; (Reviewer D) "The biggest of these (which is not mentioned in the paper), is that the presence of open terms complicates typechecking dependently typed terms."; (Reviewer D) "It would be nice to add an explicit comment about the trusted code bases of any developments"*

  Thank you for your feedback. We will clearly state the limitations of the
  current implementation and meta-theory in the final revision. In particular,
  we will emphasize the issue raised by Reviewer D regarding equality coercion
  and the pervasive propositional equality on extensible inductive families.
  This can result in unnecessary equality coercion when `denoteTy t` is not
  definitionally equal to `nat`.

  We believe that this opens up new opportunities for future work in both theory
  and practice, (a). such as a normalization algorithm for an extended calculus
  that allows for more convertibility upon elimination of the extensible
  inductive type; (b). and a proper proof assistant that supports native
  extensible inductive types instead of the current encoding via our plugin,
  thus allowing for proper reduction of open terms. This will change the kernel
  of proof assistant for sure. 

  In the final revision, we will also clarify that our plugin only translates
  code into vanilla Coq terms without expanding the trusted codebase.
  

### Review C

* *"The utility of the FMLTT formalization in this paper is unclear to me. Don't
  you already have consistency and canonicity via the translation to Coq
  demonstrated by FPOP? Or put another way, instead of defining FMLTT directly,
  couldn't you translate it to MLTT following the approach in FPOP?"*

  The technical detail here is that, FMLTT also has this unconventional Wtype
  formulation. While each classic Wtype is defined by a pair of type `A ⊢ B`,
  our unconventional Wtype is defined by a list of pair of types `Aᵢ ⊢ Bᵢ`, each
  pair corresponds to one constructor. 

  One way to interpret it is the classical formluation encoding this list using
  a big sum type. So the conventional and unconventional Wtype can be translated
  to each other. 

  However, our translation doesn't translate this unconventional Wtype
  formulation back to the conventional one. So the target calculus after
  translation is **MLTT + this unconventional Wtype**. In that case, translation
  can only function as a guide to the plugin implementation, and
  **pedantically** is not enough to show the consistency/canonicitiy for FMLTT
  because **pedantically** target calculus is not proven to be
  consistency/canonicity.

  We agree with Reviewer B's insight -- we will get consistency/canonicitiy when
  we translate unconventional Wtype into the conventional one. The reason we
  didn't choose to do so because we expect this translation a lot more verbose
  than the current proof because of the simplicity of Wtype itself compared to
  the rich functionality provided by (fake-)Agda's Inductive Facility. We only
  use the latter when constructing consistency/canonicity model.



### Other questions



* (Reviewer A/B) Why is W(t) a term and not a type? What are bold-W and bold-P needed for?

  In dependent type system, a type is also a term. i.e. we have to allow `Γ ⊢ W(t) : 𝕌`. 

  𝕎(t) is a typo and should be deleted. Thanks for pointing out.

  ℙ is another technical detail of the system. Its functionality is to transform
  a linkage(overridable/extensible) into a module(sigma type). The reason it is
  irreplacable is because, proper abstraction cannot happen on linkage (𝕃) but
  only on a module (ℙ). For example, Line 744 shows we can prove `ℙ(σ₅) ⊢ s₆ :
  A₆[p¹]` but generally `𝕃(σ₅) ⊢ s₆ : A₆[p¹]` not provable for non-trivial
  `A₆`. 


* *(Reviewer B) How will our plugin react when trying to mixin the contradictory features? For example, since STLC with eith polymorphism or references enjoy type soundness, but their composition doesn't.*

<!-- I think we still need to clarify we doesn't support extending these -->
We currently doesn't support extend STLC with polymorphism and reference, which requires extending existent inductive family with new indices. 

Hypothetically speaking, We can expect our plugin will generate unprovable proof obligation under mixin, hindering qed'ed the proposition and thus closing the family.

Another exmaple would be extend *a family of STLC and its termination proof* with general recursion feature. Our plugin will generate unprovable proof obligation inside the reducibility argument for the fixpoint feature.  


* (Reviewer D) **"What goes wrong if a user tries to define a term with the `tm_rect` type using standard pattern matching? Is it rejected? In the latter case, how does the plugin prevent other extensible definitions from referring to it?"**

  Coq will reject on the pattern matching on `tm`. For example, Figure 4, Line
  494 `Module Type STLC°tm` shows the abstraction/wrapped interface around the
  given inductive `tm`. The following field definition will be type-checked
  based on this interface, and for Coq it will only consider `tm` as an
  arbitrary type and will fail to pattern match it.
 

* (Reviewer D) **""In the event that fpop cannot infer where the programmer intends to place a new field, annotation is required." I did not understand what it means to 'place' a field-- when does this occur,  and what do these annotations look like?"**

For example
```C
Family A {Field a; Field b; Field c;}

Family B extends A {
  (* Inherit a. *) 
  (* this vernacular command line will make a difference once uncommented. Before uncommented it, a2 will be the first field of the Family B.
      The fields are order sensitive, especially when the definition of a2 dependent on a, placing a2 before a will cause program rejected. 
      This ``annotation`` require the programmers effort. *) 
  Field a2.
}
```

<!-- I am not sure if I want to mention overridable/pins  -->


* (Reviewer D) **"First, a module named STLC◦subst◦Cases is generated interactively: every time the programmer completes a..." This is also confusing-- why is the programmer involved in the translation? Is it that modules are being generated in the background, while commands are being processed?**

We should be more clear that we want to emphasize, whenever one vernacular command is emitted, our plugin will translate and type-check. Basically type-checking happens together with interactive theorem proving, as opposed to non-interactively -- where the type-checking happens after a whole family is closed

Yes, modules/functors are generated in the background after each command is emitted.