PLDI 2023 Paper #430 Reviews and Comments
===========================================================================
Paper #430 Extensible Metatheory Mechanization via Family Polymorphism


Review #430A
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
3. Knowledgeable

Paper summary
-------------
This paper sets out to tackle the expression problem for theorem provers, i.e., provide linguistic support that enable modular and compositional theories with both extensible inductive types and extensible sets of propositions. The paper takes cues from programming language features like family polymorphism and mixins, mostly seen in object-oriented languages. A concrete design is presented as an extension to Coq. It is implemented by source-to-source translation. A core type theory is also developed, as an extension to Martin-Löf.

PRO:

+ Novel and non-trivial combination of ideas
+ Addresses a relevant problem
+ Good choice of motivating and running examples
+ Develops both theory and implementation
+ Generally well-written

CONS:

- Very dense, contents could easily fill 2 papers
- Some pieces remain underexplained due to lack of space
- hard to tell how powerful and ergonomic this is in practice
- Seems related to type theories for modules, but doesn't discuss the connection

This is a fascinating but tough paper. While generally well-written, it unfortunately suffers from the complex amount of material included, such as general explanation, examples, the implementation, and a formal type theory. Each gets only a couple of pages, although the topic is sophisticated enough that each could take up half the paper limit. As a result, the paper is rather dense. In particular, the core type theory is very hard to understand without more explanation and appeal to intuition, given that it is both non-standard, complex, and subtle.

The initial problem statement and the explanation of the challenges it poses is presented very well. The paper uses a familiar running example (STLC) that covers most of the relevant features. It shows nicely how the proposed language can be used to express this example.

The main idea of the language is to extend Coq and its dependent type theory with a form of "late binding" and mixin composition that together provide a notion of family polymorphism. Technically, late binding is realised as sugar for suitable (implicit) self-abstraction over the late-bound components of the family, which is supplied when it is extended, or when the closed instance of a family is formed (a family simultaneously defines a closed instance and constructor for forming extensions).

Extension is expressed by a form of mixin composition, which allows the combination of multiple compatible extensions. While mixin composition is typically found in OO languages, it is much more restrictive in this language, where it requires preserving the dependency order of components. This tames the recursion inherent to mixin composition such that it does not break consistency of the theory and so that it can be compiled in terms of layered incremental lambda abstractions. The constraints on ordering are reflected in the type system, where order is significant and tracked via "linkage signatures".

Although everything but simple, the design seems very solid. Both the implementation and the type theory made sense -- at least as far as I was able to understand the latter.

Unfortunately, I have to admit that I felt a bit lost in Section 5, which describes the type theory. As mentioned, that theory is rather involved, but the explanation cramped into 2+ pages. I think I got the rough idea, but there are various forms that aren't explained, such as bold-W, bold-P, etc. I understand that it is hard to fit more into the page limit, but I sincerely hope that this section can be expanded significantly in the final version.

In terms of ergonomics, I wonder how powerful and usable is the FInduction construct is. In Coq proofs, it's not rare to use induction tactics inside a larger proof. Will users need to outline those into their explicit own lemmas?

Finally, I note that a family has similarities with an ML-style module, including the fact that some of its members are opaque while others are abstract. This is modelled through the use of singleton types, just as dependent type theories for modules do (e.g., Dreyer, Crary, Harper, POPL 2003), which are also extensions of MLTT. Furthermore, there has been work on extending ML modules with mixin composition (Dreyer, Rossberg, ICFP 2008). ML-style modules are the basis of Coq's module system as well, so I would have expected some comparison with this line of work.

Comments for authors
--------------------
Sec 3.1: I did not fully understand the semantics and role of the motive declarations. For example, what is the difference between the use lambda-bound parameters vs arrows?

Sec 5: I am not intimately familiar with the "current trend" of MLTT presentations, so I was thrown off a bit by some details of this formulation, esp application as a unary operator. I think I eventually understood how this is used in conjunction with explicit substitution, but wouldn't have minded a few more hints for readers like me.

Fig. 7: In the conclusion of rule Tyeq/Casety, R should be T?

Why is W(t) a term and not a type?

What are bold-W and bold-P needed for?



Review #430B
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
3. Knowledgeable

Paper summary
-------------
This submission proposes an approach to the "metatheory expression problem", that is the problem of accommodating extensibility in both datatype definitions and in functions / proofs over the (extensible) datatypes, in a theorem proving/metatheory setting.  The approach taken adapts ideas from the object-oriented programming community including family polymorphism and mixins.  New features allowing datatypes, recursive definitions and inductive proofs in Coq to be extensible, and to allow for actually extending them, are described and an implementation as a Coq plugin is described, including several case studies.  In addition a formal calculus extending Martin-Lof type theory with W-types for induction is presented, with the extensions accommodating families, via features called linkages and linkage transformations, along with some additional technical devices to help ensure that parts of the program/formalization that extend a datatype don't rely on specifics of the type's definition (that may change).

Comments for authors
--------------------
# Discussion and Evaluation

The first part of the paper describing the overall approach is very well written.  All of the potential obstacles I would have anticipated (and more) in supporting extensibility in a dependently typed or theorem proving setting are identified and the explanations how they are addressed are persuasive.  I thought the explanation regarding how to accommodate reasoning about injectivity via partial induction operations was particularly enlightening.  Although there seem to be some limitations (see below) this approach seems worthwhile and a significant step.

The section on the formalization FMLTT is (as the paper acknowledged) extremely dense and until some examples are given on page 15 it is very difficult to follow, with many new constructs being presented in a small amount of space with few examples.  The fact that the presentation of MLTT is itself terse (using explicit substitutions / de Bruijn style) adds another layer of opaqueness to someone not already acquainted with this approach (for example it took me a minute to appreciate the rule for "app" on page 14, which unpacks a function term by adding the argument type to the context, where then have to apply a mostly-identity substitution to it if we actually want to apply the function).

One thing I don't really get from the rules/discussion (including the appendix) is the exact mechanism for choosing the A in rules like TyEq/PK/Add and LSig/Add where A is supposed to abstract out the possibly-extensible types in deciding what to make available to later definitions.  Is A always going to be uniquely determinable from s? (or if not, does the nondeterminism matter?)  Is it up to the user (in this case, the plugin) to get this right, or do the rules somehow make sure that the right things are abstracted in a way I can't see?

It seems the "linkage transformers" representing the common actions one can take in FPOP are definable in a smaller core which seems helpful in a formalization.  A partial formalization is provided in the form of Agda but using features (quotient inductive-inductive types) that cannot currently be checked by Agda.  It is mentioned in an appendix that the formalization also includes a translation-away of the new features down to plain MLTT but this isn't discussed further in the main body of the paper.  (Though if you then look at the actual agda files, the comments explain that they aren't real agda either, but have been modified to be easier to read with syntax highlighting.  So I'm not really sure how to interpret this --- even if we take for granted that it is correct, the formalization is at any rate not a direct proof of correctness of the plugin implementation.)

On the other hand I find it somewhat surprising that neither the FPOP plugin / implementation itself, nor the code of the case studies, is provided.  I would like to hear more about the implementation and how the case studies discussed look in practice (beyond the relatively simple examples in the paper).  I think the paper would also be improved by delineating the limitations of the current implementation / metatheory, particularly where alternatives may exist, such as for extensions that require changes to types which is considered by [15] but is unclear can be handled by FPOP.

Overall my impression is that this paper makes a significant contribution to a really challenging problem using a different approach than other proposals and deserves publication.  I think a case could be made for publication excluding the formalization, since the plugin implementation translates to Coq code that can be checked using the existing trusted base, so the ramifications of bugs in the plugin are limited to inconvenience/usability.  This is analogous to how some features (including inductive datatypes themselves) are handled in some other systems such as Isabelle/HOL: inductive definitions are translated to lower-level concepts checkable by the core logic, and so the implementation of datatypes doesn't need to be fully formalized and proved correct in order to trust specific proofs that use it; though any failures would still be inconvenient, of course.

# Detailed comments

103:  The definition of substitution here and for STLCFix is not capture avoiding.  This is fine since you restrict beta reduction to (closed) values as in a programming language, but is of course not sound in general, for example if you wanted to reason about arbitrary code transformations (e.g. inlining) using substitution.  This should be mentioned. 
 Would/does your approach also work in the presence of other approaches to binding, e.g. de Bruijn or locally nameless?

244: looking at figure 2 this extension involves adding cases to the term language and adjusting the proofs, but not adding e.g. new things to the typing judgment.  Imagine we extend STLC to System F, using two type contexts, one for term variables, the other for type variables. Can such an extension be defined?

249: late binding of F constructs: does checking happen when these constructs are checked or when they are "concreted"?

380: discussion of mixins: so imagine we define a mixin for extending with polymorphism (e.g. Damas-Hindley-Milner type inference) and another mixin for extending with references, and we prove type soundness of each extension independently.  Now we compose them, getting a system that is known not to be sound.  If this is possible, where is the failure of the attempt to extend the proof detected?  If not, which part isn't possible?  I think, if this is possible, then the plugin would somehow have to work out what cases involving interaction between references and polymorphism aren't covered by existing proofs and ask for these cases to be filled in.

505: "emmited" sp.

527: "bahaviors" sp.

663: though I have a vague recollection of W-types as a general approach to inductive types, there is a lot to unpack in this section and I suspect it will make no sense to someone not familiar with them at all.  Could be helped by showing how e.g. STLC or STLCFix is represented as a W-type (in addition to the example on page 15)?

666: for readability please add text between "T," and "Wsup"

702: In Tywe/Casety, the metavariable R appears only once, was it meant to be T?  Also since T is applied to p^2, should T be checked to be well-formed in a context with two or more things (perhaps Gamma, A,B) rather than Gamma which could have 0 or more things?

910: define abbreviation DTC at first use?



Review #430C
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
3. Knowledgeable

Paper summary
-------------
The paper adds support for family polymorphism to the Coq interactive
theorem prover, thereby providing a solution to the Expression Problem
in the context of mechanizing the metatheory of programming
languages. The paper describes an implementation of a Coq plugin,
named FPOP, that translates the new features for family polymorphism
into regular Coq code that makes use of modules and parameterization.
The paper also models the new features in a new core type theory named
FMLTT that extends Martin-Lof Dependent Type Theory and prove that
FMLTT satisfies consistency and canonicity. Finally, the paper
describes using FPOP in two case studies: (1) prove type safety of
four extensions to the Simply Typed Lambda Calculus and (2) define and
prove correctness of abstract interpreters (static analyzers) for a
simple imperative language.

Comments for authors
--------------------
The pros and cons of the paper are

+ The paper addresses an important challenge, enabling modular definitions
  and proofs of programming language features.
  
+ The proposed approach, inspired by notions of family polymorphism
  and mixins from Object-Oriented Languages, yields a very nice design
  and is a neat example of pulling together ideas from very different
  subfields within Programming Languages.

+ The paper is well written and relatively easy to read.

- The utility of the FMLTT formalization in this paper is unclear to me.
  Don't you already have consistency and canonicity via the translation
  to Coq demonstrated by FPOP? Or put another way, instead of defining
  FMLTT directly, couldn't you translate it to MLTT following the
  approach in FPOP?

Detailed Comments

Abstract:

    "via a form of family polymorphism, a seemingly object-oriented idea"
    =>
    "via a form of family polymorphism, an object-oriented idea"    

p. 18

    "The base STLC family consists of about 400 LOC. ..."

The case studies should quantify the amount of code reuse enabled by
FPOP, so you need to report the total LOC for the whole development
both with and without FPOP.

    "The current plugin implementation does not yet support mutually
    inductive types or mutual induction, which are useful for modeling
    languages much more complex than STLCs"

Be upfront about this limitation instead of hiding it in the section
on case studies. Move this to the introduction.



Review #430D
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
4. Expert

Paper summary
-------------
The so-called *expression problem* was first noticed by John Reynolds: in most languages, there is a fundamental tension between supporting modular extensions of existing datatypes with both new variants and new operations. When Wadler coined the phrase expression problem, OO-style languages naturally supported adding new variants (using subclassing), while functional languages made it easy to add new operations over (closed) algebraic data types. In the intervening years, a variety of design patterns have been proposed to help users solve this problem (e.g. the visitor pattern in OO-languages and datatypes à la carte in the FP setting). These solutions vary in terms of how much linguistic support is required from the host language -- the ideal solution would obviously be one where both kinds of extension are supported without *any* extra effort from the programmer, à la inheritance Java's support for inheritance via subclassing.

In the context of dependently typed languages, the expression problem becomes even more interesting: here, an inductive datatype corresponds to the syntax of a language, an inductive relation encodes its semantics and type system, and dependently-typed functions (i.e. theorems) encode its metatheory. When viewed through the lens of the Curry-Howard isomorphism, a solution to the expression problem allows users to modularly extend the syntax of a language, its semantics, *and* its metatheory (i.e. proofs). In the context of large language developments, a good solution enables users to reuse existing developments when extending an established languages with new features, lowering the cost of updating any metatheory proofs. Existing solutions to this problem have proposed techniques for structuring developments to support modular reuse using the built-in features of the theorem prover, sometimes with considerable tool support (e.g. using meta-programming). This paper explores a different solution: how to add new features to the dependently-typed language underpinning a theorem prover, in order to better support modular reuse of definitions?

The proposed answer is to add a form of family polymorphism to the language. At its core, a family can be thought of as a record whose fields can recursively refer to themselves. Family polymorphism allows these references to be bound later, after the initial definition. This effectively leaves inductive and recursive definitions open, allowing them to be extended later when inheriting behaviors of the original record. The paper formalizes this feature in an extended version of a standard Martin-Lof type theory equipped with W-types, and prove consistency and canonicity for the resulting calculus. These proofs are encoded in an (unchecked) Agda-style development.

This approach has been implemented in a Coq plugin that implements the proposed form of family polymorphism. In order to support this form of late binding, the plugin includes several niceties to help users write proofs in a more idiomatic style. Such support is important in the context of proof developments (i.e. dependently typed programming via tactics). These are inherently more challenging than in the simply typed setting, as solving intermediate proof states often involves destructing terms and simplifying definitions using that term in the current context (this precisely is what Coq's `discriminate` and `injection` tactics do under the hood). Since the definitions of late-bound terms are unavailable, it is not possible to perform case analysis on a term of a late-bound type, and late-bound definitions cannot be simplified-- the expression `subst tm_unit x t` cannot be reduced to `tm_unit` when `subst` is a late-bound identifier, for example. To remedy the former problem, the plugin includes analogues of Coq's `induction` tactic for writing proofs and another for writing functions that recurse terms of late-bound types.  To handle the latter concern, the plugin admits an axiom to the context that encodes the expected computational behavior; e.g. making the equation `subst tm_unit x t = tm_unit` available for use with the Coq's standard `rewrite` tactic. The plugin elaborates families into parameterized Coq modules, as well as versions that "tie the recursive knot": the latter can be used as normal, while the former can be inherited and further extended. There is also some support for overriding the definitions of inherited fields, although this is needs to be fairly restricted to ensure logical consistency. Another nice feature of the setup is that a new family can inherit from multiple existing families.

This implementation is evaluated via two case studies. The first defines a collection of variants of the simply type lambda calculus, extended with combinations of fixpoints, sums, products, and recursive types. The second defines an abstract interpreter for a simple imperative language, which is instantiated to do type checking, and the language is extended with arithmetic operations.

Comments for authors
--------------------
This paper has contributions to both the theory and practice of programming languages, exactly as one hopes to see in a PLDI paper. On the theory side, it looks at the under-explored question of how to integrate useful features from other programming languages into proof assistants. While others have looked at how to structure programs or use meta-programming to enable extensible proof developments, this work takes a more foundational approach. On the practical side, it presents a Coq plugin realizing the theoretical ideas, while also providing some necessary and needed tactics for end-users. In addition, it offers something to the working PL researcher: as mechanized metatheory developments become more popular, any techniques that helps users reuse existing efforts is useful!

That said, there are some deficiencies with both components that prevent me from strongly advocating for the paper. Since there are contributions in both directions, the current presentation must chose which to emphasize to fit within the page limit. The current authors chose to focus on the plugin and its interface-- probably the right choice, since these components are more easily appreciated by the general PLDI audience. Unfortunately, the presentation of the main conceptual contribution (family polymorphism in a dependent type theory) is incredibly terse. As a consequence, the section on the theoretical contributions is insufficiently self-contained.

The presentation of the calculus seems to be geared so that it closely mirrors an Agda formalization, in lieu of a more conventional presentation (e.g. substitutions are part of the syntax, and the calculus uses De Bruijn indices). Presumably due to space concerns, the formalization also lacks sufficient examples, which makes it hard to understand how things fit together: As one example, the description of the TM/WSUP rule does not mention the role of the signature $\tau$ in the rule, leaving the reader to figure out its purpose. It would be helpful to provide an concrete example of how this rule is used. I appreciate the effort to ground things via Figure 8's mapping from a few definitions of the STLC family to the core calculus. Unfortunately, this listing is effectively a partial definition, in that it contain several intermediate terms ($l_x$) whose definitions are not given. At the end of the day, I did not emerge from this section with a good intuition of how 'linkages' work and how they are used.

In a similar vein, the proof of the key metatheoretic properties assumes that the reader is familiar with similar proofs, stating that the key technical device (an interpretation into a metalanguage) is largely similar to e.g. Altenkirch and Kaposi, without clearly explaining the extension. More worrisome, the full proof is *only* given in a notation heavy, Agda-style format, which is both unchecked by a machine and hard for humans to read.  While the formalization tries to rebut these concerns by acknowledging that the presentation will be dense to those 'without prior exposure to MLTT', but it would be more accurate to stipulate 'non-experts in MLTT'.

As one suggestion to free up some space, Figure 2 is currently taking up valuable real estate that could be better used on examples in Section 5. While I appreciate the effort to include a complete example, the authors could move this example to the appendix, and instead include a more canonical example of the expression problem (e.g., a DSL with boolean and numeric expressions), which still demonstrates the core of the problem. This would also allow for smaller versions of Figures 4 and 5, and (potentially) a more complete version of the correspondence shown in Figure 8. As a side note,

On the 'practice' side of the equation, the current plugin has some limitations that prevent it from being a complete solution. (In my opinion, it is unreasonable to expect a complete solution, so I note these more as future research challenges.) The biggest of these (which is not mentioned in the paper), is that the presence of open terms complicates typechecking dependently typed terms. Normally, occurrences of a function application in a type can be simplified via reduction, but when a term is late-bound, this is no longer an option. More concretely, the question is how to handle the definition of a inductive data type for expressions indexed with a code for their type, like so:

    Inductive Ty : Set := Nat.
    
    Inductive Exp : Ty -> Set :=
     | Lit (n : nat) : Exp Nat
     | Plus (n m : Exp Nat) :  Exp Nat.

    Definition denoteTy (t : Ty) : Set :=
      match t with
       | Nat => nat
      end.

    Fixpoint eval {t : Ty} (e : Exp t) : denoteTy t :=
    match e with
      | Lit n => n
      | Plus n m => (eval n) + (eval m)
     end.

Since `denoteTy Nat` is no longer definitionally equal to `nat`, the definition of `eval` would not typecheck. The proposed solution of using axioms allows users to insert explicit 'casts' (eq_rect) into the definition of `eval`, but this complicates both writing and reading functions.

Another place where the current approach seems to be lacking is the restriction of induction / case analysis to the top level. It is common practice in Coq proofs to prove intermediate facts by case analysis or induction 'inline', e.g. via the `destruct` tactic. Indeed, this is what happens under the hood with `injection` and `discriminate`, for which the authors have developed `finjection` and `fdiscriminate` variants. One would expect to (eventually) see a similar tactic for `destruct`, although this will undoubtedly involve more engineering work to in order to extract the necessary lemmas and add them to the family's interface. 

The purpose of the second case study was not immediately clear: why is the generic abstract interpreter defined separately from Imp? Is this to showcase support for adding new fields to families? In addition, it was unclear what it means for fields to be 'unspecified' or 'unproven'? Access to the case studies would help, but they are not available, and neither is the plugin. I understand that packaging everything up in a reusable way before the deadline may have been a bit too much, but it would have been nice to be able to examine the source code for these case studies.

## Minor questions / concerns:
- (l903) What does it mean to have a decision procedure for context-free grammars? Does this mean membership checking?

- 'Family' should be given (at least) an english language definition early on.  The 'fields' of a family are mentioned at several points, suggesting that they can be thought of as records. If that is the intent of the authors, it should be explicitly stated.

- (l188) What goes wrong if a user tries to define a term with the `tm_rect` type using standard pattern matching? Is it rejected? Can it be defined, but only works for STLC.tm? In the latter case, how does the plugin prevent other extensible definitions from referring to it?

- (l26) There is no shortage of solutions to the EP in various languages, but there are no citations to those works.

- (l35) The Coq à la Carte paper is arguably more than just a design pattern / encoding, given that it extends the surface syntax of the theorem prover. The same designation could ostensibly be applied to the plugin described in Sections 3-4. The difference, I suppose, is that the extended language in that work does not have a formal treatment. 

- (l135) The line "... cannot equate references to the substitution to its definition..." was confusing -- the key idea is that when defining a field in a family, the definitions of all the other fields cannot be unfolded, since they may be redefined later on by an extended family.

- (l318) The discussion of overriding and the equality axioms you provided was initially quite alarming -- it wasn't clear that the proposed checking strategy couldn't lead to inconsistent assumptions. This concern was ameliorated with the discussion in Section 4, which explains how families are compiled into vanilla Coq terms. It would be nice to add an explicit comment about the trusted code bases of any developments using the plugin: if I understand correctly, the core theory is not extended, all introduced 'axioms' are checked when a family is closed, `Print Assumptions` can be used   to examine any lingering axioms, and definitions can be unfolded and examined by the end users.

- (l374) "In the event that fpop cannot infer where the programmer intends to place a new field, annotation is required." I did not understand what it means to 'place' a field-- when does this occur,  and what do these annotations look like?

- (l487) "First, a module named STLC◦subst◦Cases is generated interactively: every time the programmer completes a..." This is also confusing-- why is the programmer involved in the translation? Is it that modules are being generated in the background, while commands are being processed?

- (l665-667): The description of TM/WSUP is inconsistent with respect to the premises of the rule which do not include a type B, and construct a term of type El(W($\tau$)).

- (l899) What were the results of testing the extracted abstract interpreters? I don't expect much in the way of performance, but did they return the correct results?  What sorts of benchmarks did you use?

- Out of curiosity, but how does your plugin integrate with universes? Could there be a situation where 'closing the loop' produces an inconsistent set of constraints?

## Typos and detailed comments:

+ l125: induction reasoning --> inductive reasoning.

+ l131: binding: code of --> binding: the code of

+ l175: STLCFix, inductive type --> STLCFix, the inductive type

+ l193: becomes in jeopardy --> is compromised

+ l194: In particular: recursor  --> In particular: the recursor

+ l374: field, annotation is --> field, an annotation is

+ l585+587: Computational behaviors --> "The computational behaviors"

+ l612: tuples composed of the fields --> tuples composed of fields

+ l722+724: have form --> have the form

+ l762: For readability, we feel free to use --> For readability, we use

+ l763: and feel free to write -> and write

+ l780: in rules --> in the rules

+ l781: $\mathbb{P}(\sigma)$ <-- what is $\mathbb{P}(\sigma)$ here? Is
$\mathbb{P}$ a metavariable, is it a function, or is it something
else?

+ l897: the computation ability of the host --> the code extraction
ability of the host

+ l898: We put them to test over queries. --> and tested them on a set
of benchmarks (describe the benchmarks).
