We thank all the reviewers for their critical and encouraging feedback.
Below we first address the main concerns. We might paraphrase

* (Paragraph 3/4 from Reviewer D)**The presentation of the calculus seems to be geared so that it closely mirrors an Agda formalization, in lieu of a more conventional presentation (e.g. substitutions are part of the syntax, and the calculus uses De Bruijn indices). Presumably due to space concerns, the formalization also lacks sufficient examples, which makes it hard to understand how things fit together: As one example, the description of the TM/WSUP rule does not mention the role of the signature $\tau$ in the rule, leaving the reader to figure out its purpose. It would be helpful to provide an concrete example of how this rule is used. I appreciate the effort to ground things via Figure 8's mapping from a few definitions of the STLC family to the core calculus. Unfortunately, this listing is effectively a partial definition, in that it contain several intermediate terms ($l_x$) whose definitions are not given. At the end of the day, I did not emerge from this section with a good intuition of how 'linkages' work and how they are used. In a similar vein, the proof of the key metatheoretic properties assumes that the reader is familiar with similar proofs, stating that the key technical device (an interpretation into a metalanguage) is largely similar to e.g. Altenkirch and Kaposi, without clearly explaining the extension. More worrisome, the full proof is *only* given in a notation heavy, Agda-style format, which is both unchecked by a machine and hard for humans to read.  While the formalization tries to rebut these concerns by acknowledging that the presentation will be dense to those 'without prior exposure to MLTT', but it would be more accurate to stipulate 'non-experts in MLTT'.**

<!-- I am not sure if I want to reply this or how I would like to respond this. 
      The only part I want to reply is 
        "More worrisome, the full proof is *only* given in a notation heavy, Agda-style format, which is both unchecked by a machine and hard for humans to read."
      But my reply will certainly upgrade to a notation war that leads to nowhere.
  
    The real reply I want to give is: For example, For normalization of MLTT, given Abel's thesis (written in conventional style) and Kaposi's thesis (written in fake Agda style), I will believe the latter proof even in pen-and-paper form. This is due to the personal taste and numerous error I have personally made when I use latex/human language to lay out any mathematical object. So I simply believe fake-Agda is better for Human development (at least for myself). 

    Apart from the above sentence, I think I can make no reply but really just do some modification suggestion on the paper
 -->


* (Paragraph 6) Reviewer D gives an example that will lead to awkwardness in our paper, because it require `coe` or equality transpose between propositionally equal types (due to the loss of judgemental(definitional) equality).

<!-- He got a point. To avoid transpose we need overridablity/pins which is not properly covered in the paper. -->


* (Paragraph 9) Reviewer D suggests the inclusion of `fdestruct` tactic

<!-- Generally speaking this is either not possible or trivial.
      For example, for overridable/pins it is trivial,
                  for non-overdiable stuff, it is not possible because the inductive type is extensible
    But I don't know If I want to tell the reviewer at all  -->


* **What goes wrong if a user tries to define a term with the `tm_rect` type using standard pattern matching? Is it rejected? Can it be defined, but only works for STLC.tm? In the latter case, how does the plugin prevent other extensible definitions from referring to it?** (Review D)


* **"In the event that fpop cannot infer where the programmer intends to place a new field, annotation is required." I did not understand what it means to 'place' a field-- when does this occur,  and what do these annotations look like?** (Review D)

```C
// For example
Family A {Field a; Field b; Field c;}

Family B extends A {
  // Inherit a. // this command line will make a difference once uncommented. Because the fields are order sensitive. In the case when a2's definition is dependent on a, omitting the inherit won't type check a2 
  // Thus this ``annotation`` require the programmer's effort. 
  Field a2.
}
```

* (Reviewer C) **The utility of the FMLTT formalization in this paper is unclear to me. Don't you already have consistency and canonicity via the translation to Coq demonstrated by FPOP? Or put another way, instead of defining FMLTT directly, couldn't you translate it to MLTT following the approach in FPOP?**

The technical detail here is that, FMLTT also has this unconventional Wtype formulation, which is closer to the inductive type in the surface syntax for Coq and Agda. 
        
Our translation doesn't translate the unconventional Wtype formulation back to the conventional Wtype one. So the core calculus after translation is MLTT + this unconventional Wtype.

We consider the formalized translation as an oversimplified fundation of the plugin implementation(because the unconventional Wtype is closer to the surface syntax so we believe it is legit), also act as a guidance of the plugin implementation, and hope it function as part of the supplementary text for the reader confused about the description in the main text.


* **looking at figure 2 this extension involves adding cases to the term language and adjusting the proofs, but not adding e.g. new things to the typing judgment.  Imagine we extend STLC to System F, using two type contexts, one for term variables, the other for type variables. Can such an extension be defined?** 


* (Reviewer B)  **Would/does your approach also work in the presence of other approaches to binding, e.g. de Bruijn or locally nameless?**

* (Reviewer B) **looking at figure 2 this extension involves adding cases to the term language and adjusting the proofs, but not adding e.g. new things to the typing judgment.  Imagine we extend STLC to System F, using two type contexts, one for term variables, the other for type variables. Can such an extension be defined?** (Reviewer B also asked a question on extending the feature of reference) 

To extend typing judgement is actually adding new indices for an existent inductive type, which is not covered in our paper. This not only happens for polymorphism extension, but also for the case of extending with the heap -- since reduction relation will have a new information on heap. 

This is a quite challenging problem we are facing right now as well. The main challenge here for us is how to achieve code/proof reuse after this novel extension.


* (Reviewer B) **the fake-Agda formalization of translation is at any rate not a direct proof of correctness of the plugin implementation.**

We consider the formalized translation as an oversimplified fundation of the plugin implementation, also act as a guidance of the plugin implementation, and hope it function as part of the supplementary text for the reader confused about the description in the main text.

* (Reviewer B) **Where does the A in rules like TyEq/PK/Add come from?**

At the metatheory level, this A is decided by the programmer and not uniquely determined as you observed. 
In practice, the plugin implementation always choose a "default" one. We didn't formalize the "default" one as it is usually just making inductive type into an abstracted form and make sure other parts stay the "same" (I.e. family {Nat : W(O, S); pred : Nat -> Nat} is abstracted into {Nat : U; O : Nat; S : Nat -> Nat; pred : Nat -> Nat}).   


* (Reviewer A/B) **In the conclusion of rule Tyeq/Casety, R should be T?** 
Yes. Sorry for the confusing typo.

* (Reviewer A) **In terms of ergonomics, I wonder how powerful and usable is the FInduction construct is. In Coq proofs, it's not rare to use induction tactics inside a larger proof. Will users need to outline those into their explicit own lemmas?**

Currently at plugin level, we only support layout the subcases in a lemma forms. 
  I think the design challenge of making FInduction-alike structure inside proof script, is mainly how extension happens -- the plugin either needs to manipulate the proof term or manipulate the proof script itself. 
  A. The former idea needs either 
      (1) extend the coq's (proof assistant's) kernel (i.e. make the pattern matching facility extensible) or 
      (2) maniuplate the AST of the proof term
  B. the later idea 
  
  B breaks the expectation of incremental compilation a bit. 
  A.(1) and A.(2) both require sophisticated engineering effort. A(1) will also risk sabtaging the kernel itself and expanding the trusted base.
  Modulo the interesting semantic on the pattern matching itself (i.e. if we always consider the pattern matching can be elaborated to the usage of eliminator), I believe the current prototype is exploring the same semantic. So we didn't choose to explore this direction but this is definitely more practical.


* (Reviewer A) **Why is W(t) a term and not a type? What are bold-W and bold-P needed for?**

bold-W is a typo. We forgot to delete it. In dependent type, a type is also typable (thus need to appear in the term judgement). Thus `W(t)` is a term.

ℙ is a technical device of the system mentioned on Line 788. Its functionality is to transform a linkage(overridable/extensible family) into a module(sigma type). The reason we need it is because, proper abstraction `A` cannot happen on linkage (𝕃) but only on a module (ℙ). (i.e. contrary to Line 788, the `Γ, 𝕃(𝜎) ⊢ s : A[p¹]` is usually unprovable for nontrivial `A`)

<!-- Do I want to expand it? -->

