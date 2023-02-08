We thank all the reviewers for their critical and encouraging feedback.
Below we address the main concerns, which might be paraphrased for the space.

* (R-A, R-D) **Ergonomics is lacking because induction is allowed only at the top level.**

  As Reviewer A/D highlighted, the current method for inductively eliminating data only involves using "FInduction" at the top level. We have "fdiscriminate" and "finjection" for deducing intermediate facts, but the key problem is the absence of proper nested pattern matching.

  <!-- The idea is 
      fill in the new hole once pattern matching needs to extend the clauses
      lifting nested induction to top level seems not necessary
  -->

  We acknowledge this limitation of our current research and are trying to advance more in this direction. We hypothesize that we can reuse code involving nested induction/pattern matching, by filling in the new matching clauses after extension happens upon the inductive type. The plugin will generate an extra proof obligation to fill this hole. It certainly requires a significant amount of engineering effort.



* (A) __Connection to work on ML-style modules [DCH 2003, DR 2008]?__

  Thank you for the references.
  Both ML-style modules and our families are modularity mechanisms.
  ML-style modules are more about abstraction (caring about issues such as
  signature ascription), while our families are more about extensibility.
  Both use singletons to model and control the propagation of
  definitions inside a module or family.
  Work on mixin composition for ML-style modules focuses on making 
  mixins play well with the peculiarities of ML-style modules,
  while our work focuses on supporting mixins in the presence of extensible
  inductive types.
  
  <!--
  Generally speaking, compared to ML-style modules, families focus on overridability and code inheritance. The latter can be modelled by the functor in a verbose way. Module also has a clear distinction between the implementation and its signature, while family doesn't -- a given family is usually fixed with one signature, closer to OO classes. 
  ...
  Compared to the paper [DCH 2003], their problem formulation is more mature and they gear towards real-life programming experience. For example, they aim at generativity (a feature for nominality and side effect); subtyping (happens during signature matching); and phase distinction (for compilation). Our current paper handles family in a structural style; doesn't relate different signatures at all; and we work in a full-dependent type setting where mixing static and dynamic phases is acceptable.
  ...
  In fact, for plugin development, the family is compiled into modules/functors. In meta-theory, we use sigma type as a conceptually simpler representation of modules. We also use singleton type to expose concrete type information in a family inspired by their work. So our work is heavily influenced by ML-module.
  ...
  Our module and mixin have similar semantics to that from [DCH 2003] and [DR 2008]. However, compared to their work, we mainly focus on the prospect of the extensible inductive type and (exhaustiveness checking of) the corresponding recursors. Even in the case of mixin, we consider the consequent mixin of the inductive type and recursors.
  -->


* (A, B, D) **The presentation of FMLTT is tough. The Agda-looking scripts are not readable.**

  We sympathize with the reviewers. We will expand the section to clarify things
  in response to the reviewers' questions. We will also use an appendix to
  explain the formalization and proofs in greater detail.

  <!--
  Thank you for your feedback. 
  We sympathize with this impression in Section 5, and we agree it is dense, hard to read and not giving too much inspiration to the readers.
  ...
  We plan to expand it in the main text to clarify the questions the reviewers have, and also use appendices to explain the formalization and the proof in greater detail aiming for accessibility. 
  -->

* (B) __Rules TYEQ/PK/ADD and LSIG/ADD do not seem to prescribe how to choose $A$.__

  The FMLTT typing rules do not commit to a particular choice of the context type $A$,
  though there exists a simple algorithm for picking the right $A$ (lines 785–787): a
  field is checked in a context of type $A$ that hides W-type signatures behind
  $\mathbb{U}$, unless that field invokes a constructor or eliminator of some
  W-type. Intuitively, the type system is sound without this algorithm because
  it restricts the ways a field can be used if a wrong $A$ is chosen.
  
  <!--
   In practice, this A is decided by implementation. Our plugin always choose a "default" one which is just making all inductive type into an opaque type (Line 791) and make sure other parts stay the "same".

  Taking (Line 745) Figure. 8 as an example, `σ₅` has `tm : 𝕊(W(τₜₘ))` and `A`
  has `tm : 𝕌` instead. `s` will make sure other fields stay the same type. To
  show this explicitly at the plugin level, we look at Figure 4 (Line 494)
  `Module Type STLC°tm` (corresponding to `A`), where `tm : Set` (corresponding
  to `tm : 𝕌`). With this interface `STLC°tm` we cannot pattern match any term
  of type `tm : 𝕌` thus doing abstraction successfully.

  Generally speaking, all the (extensible) inductive type will be simply
  "wrapped" by a module type only exposing the
  constructor (with no eliminators), just like how we generate `STLC°tm`.
  -->

* (B, D) __The plugin implementation is not included as a supplement.__

  We will ensure the release of our research artifacts for public access.

* (Review B) __"I think the paper would also be improved by delineating the limitations of the current implementation / metatheory.."__; (Review C) __"Be upfront about this limitation ..."__; (Review D)__ "The biggest of these (which is not mentioned in the paper), is that the presence of open terms complicates typechecking dependently typed terms."__; (Review D) __"It would be nice to add an explicit comment about the trusted code bases of any developments"__

  Thank you for your feedback. We will clearly state the limitations of the
  current implementation and meta-theory in the final revision. 
  <!-- do we want to mention overridability/pins? -->
  In particular, we will emphasize the issue raised by Review D regarding equality coercion
  and the pervasive propositional equality on extensible inductive families.
  This can result in unnecessary equality coercion when `denoteTy t` is not
  definitionally equal to `nat`.

  We believe that this opens up new opportunities for future work in both theory
  and practice, (a). such as a normalization algorithm for an extended calculus
  that admits more conversion equations upon elimination of the extensible
  inductive type; (b). and a proper proof assistant that supports native
  extensible inductive types instead of the current encoding via our plugin,
  thus allowing for proper reduction of open terms. This will change the kernel
  of the proof assistant for sure. 

  In the final revision, we will also clarify that our plugin only translates
  code into vanilla Coq terms without expanding the trusted codebase.
  

* (B, C) __Consistency is already implied for FMLTT by a translation to MLTT, and for FPOP by a translation to Coq__.

  We agree with the reviewers' insights.

  We note that the effort required to prove consistency directly for FMLTT is
  almost identical to that required to prove a translation to MLTT is
  type-preserving: both proofs are structured as type-preserving, metacircular
  interpretations.
  
  <!--
  Our main excuse for doing the proofs is that we found it more
  educational for ourselves to directly prove FMLTT consistent than doing the
  translation.
  ...
  We decided to prove consistency and canonicity directly for FMLTT, because our
  formulation of W-types, which are part of both FMLTT and our target MLTT, is
  slightly unconventional.
  We define a W-type as given by a list of pairs of types $A_i ⊢ B_i$; each pair
  corresponds to one constructor.
  The convention is to define a W-type as given by a single pair of types $A ⊢ B$.
  The conventional and unconventional Wtype can be translated
  to each other because a list is also an inductive type.
  So the conventional and unconventional Wtype can be
  translated to each other. 
  ...
  However, our translation doesn't translate this unconventional Wtype
  formulation back to the conventional one. So the target calculus after
  translation is **MLTT + this unconventional Wtype**. In that case, translation
  can only function as a guide to the plugin implementation, and
  **pedantically** is not enough to show the consistency/canonicity for FMLTT
  because, **pedantically**, target calculus is not proven to be
  consistency/canonicity.
  ...
  We agree with Reviewer B's insight -- we will get consistency/canonicity when
  we translate the unconventional Wtype into the conventional one. In fact, our consistency 
  proof is structurally identical to the  type-preservation proof for a translation to MLTT, 
  since consistency is proved via a type-preserving, metacircular interpretation.
  ...
  The reason we
  didn't choose to do so is that we expect this translation a lot more verbose
  than the current proof because of the simplicity of Wtype itself compared to
  the rich functionality provided by (fake-)Agda's Inductive Facility. We only
  use the latter when constructing the consistency/canonicity model.
  -->


* (A, B) __In the conclusion of rule Tyeq/Casety, R should be T?__

  Yes. Thank you for noticing this typo.

* (Review A) __"Why is W(t) a term and not a type? What are bold-W and bold-P needed for?"__

  In a dependent type system, a type is also a term. i.e. we have to allow `Γ ⊢ W(t) : 𝕌`. 

  𝕎(t) is a typo and should be deleted. Thanks for pointing that out.

  ℙ is another technical detail of the system. Its functionality is to transform
  a linkage(overridable/extensible) into a module(sigma type). The reason it is
  irreplaceable is that proper abstraction cannot happen on linkage (𝕃) but
  only on a module (ℙ). For example, Line 744 shows we can prove `ℙ(σ₅) ⊢ s₆ :
  A₆[p¹]` but generally `𝕃(σ₅) ⊢ s₆ : A₆[p¹]` not provable for non-trivial
  `A₆`. 


* (Review B) __How will our plugin react when trying to mixin the contradictory features? For example, since STLC with eith polymorphism or references enjoy type soundness, but their composition doesn't.__

  <!-- I think we still need to clarify we doesn't support extending these -->
  We currently don't support extending STLC with polymorphism and reference, which requires extending the existent inductive family with new indices. 

  Hypothetically speaking, We can expect our plugin will generate unprovable proof obligation under mixin, hindering qeding the proposition and thus closing the family.

  Another example would be extending *a family of STLC and its termination proof* with the general recursion feature. Our plugin will generate an unprovable proof obligation inside the reducibility argument for the fixpoint feature.  


* (Review D) __"What goes wrong if a user tries to define a term with the `tm_rect` type using standard pattern matching? Is it rejected? In the latter case, how does the plugin prevent other extensible definitions from referring to it?"__

  Coq will reject the pattern matching on `tm`. For example, Figure 4, Line 494 `Module Type STLC°tm` shows the abstraction/wrapped interface around the given inductive `tm`. The following field definition will be type-checked
  based on this interface. As for Coq, it will only consider `tm` as an
  arbitrary type and will fail to pattern-match it.
 

* (Review D) __""In the event that fpop cannot infer where the programmer intends to place a new field, annotation is required." I did not understand what it means to 'place' a field-- when does this occur,  and what do these annotations look like?"__

  For example
```C
Family A {Field a; Field b; Field c;}

Family B extends A {
  (* Inherit a. *) 
    (* this vernacular command line will make a difference once uncommented. 
        Before uncommenting it, a2 will be the first field of Family B.
        The fields are order sensitive, especially when the definition of a2 depends on a, placing a2 before a will fail the type-check. 
      This ``annotation`` require the programmer`s effort. *) 
  Field a2.
}
```



* (Review D) __"First, a module named STLC◦subst◦Cases is generated interactively: every time the programmer completes a..." This is also confusing-- why is the programmer involved in the translation? Is it that modules are being generated in the background, while commands are being processed?__

  We should be clearer that, the point we want to emphasize is, whenever one vernacular command is emitted, our plugin will translate and type-check. Basically, type-checking happens together with interactive theorem proving, as opposed to non-interactively -- where type-checking only happens after a whole family is closed.

  Yes, modules/functors are generated in the background after each command is emitted.